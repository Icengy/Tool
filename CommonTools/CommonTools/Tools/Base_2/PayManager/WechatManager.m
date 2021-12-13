//
//  WechatManager.m
//  HM503
//
//  Created by 美术传媒 on 2018/11/8.
//  Copyright © 2018 lcy. All rights reserved.
//

#import "WechatManager.h"

@implementation WechatManager
static WechatManager*manager=nil;

+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

- (void)payIdentifyFeeWithType:(NSString*)type roleType:(NSString *)roleType {
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    params[@"uid"] = [UserInfoManager shareManager].uid;
    params[@"type"] = type;
    params[@"roletype"] = roleType;
    params[@"apptype"] = @"1";
    
    [ApiUtil postWithParent:nil url:[ApiUtilHeader sendOrderWithWX] params:params.copy success:^(NSInteger code, id  _Nullable response) {
        NSDictionary*d = (NSDictionary *)[response objectForKey:@"data"];
        if (d && d.count) {
            [self wakeUpWechatForPayWithDic:d];
        }
    } fail:nil];
}

- (void)payOrderWithType:(NSString*)type withOrderID:(NSString*)order_id {
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    params[@"uid"] = [UserInfoManager shareManager].uid;
    params[@"type"] = type;
    params[@"order_id"] = order_id;
    params[@"apptype"] = @"1";
    
    [ApiUtil postWithParent:nil url:[ApiUtilHeader sendOrderWithWX] params:params.copy success:^(NSInteger code, id  _Nullable response) {
        NSDictionary*d = (NSDictionary *)[response objectForKey:@"data"];
        if (d && d.count) {
            [self wakeUpWechatForPayWithDic:d];
        }
    } fail:nil];
}

- (void)payGiftWithReceiverID:(NSString *)receiver_id
					 videoid:(NSString *)video_id
					  giftID:(NSString*)gift_id
				   giftCount:(NSInteger)gift_count {
	
	NSMutableDictionary *params = [NSMutableDictionary new];
	
    params[@"giveruid"] = [UserInfoManager shareManager].uid;
	
	params[@"apptype"] = @"3";
	params[@"type"] = @"8";
	
	params[@"uid"] = [ToolUtil isEqualToNonNullKong:receiver_id];
	params[@"giftid"] = [ToolUtil isEqualToNonNullKong:gift_id];
	params[@"num"] = [NSString stringWithFormat:@"%@",@(gift_count)];
	params[@"videoid"] = [ToolUtil isEqualToNonNullKong:video_id];
	
    [ApiUtil postWithParent:nil url:[ApiUtilHeader sendOrderWithWX] params:params.copy success:^(NSInteger code, id  _Nullable response) {
        NSDictionary*d = (NSDictionary *)[response objectForKey:@"data"];
        if (d && d.count) {
            [self wakeUpWechatForPayWithDic:d];
        }
    } fail:nil];
}

- (void)getStateOfOrderWithResp:(BaseResp *)resp {
    PayResp*response=(PayResp*)resp;
    switch(response.errCode){
        case WXSuccess: {
            if([_delegate respondsToSelector:@selector(wechatPaySuccessful)])
            {
                [_delegate wechatPaySuccessful];
            }
        }
            break;
        default: {
            if([_delegate respondsToSelector:@selector(wechatPayFail)])
            {
                [_delegate wechatPayFail];
            }
           // NSLog(@"支付失败，retcode=%d",resp.errCode);
        }
            break;
    }

}

- (void)payMeetingOrderWithID:(NSString *)order_id type:(NSString *)type {
    NSMutableDictionary *params = @{}.mutableCopy;
    params[@"relevanceId"] = [ToolUtil isEqualToNonNullKong:order_id];
    params[@"relevanceType"] = type;
    params[@"tradingChannel"] = @"2";
    
    [ApiUtil postWithParent:nil url:[ApiUtilHeader payTeaOrder] params:params.copy success:^(NSInteger code, id  _Nullable response) {
        NSDictionary *data = (NSDictionary *)[response objectForKey:@"data"];
        if (data && data.count) {
            NSDictionary *wechatResult = (NSDictionary *)[data objectForKey:@"wechatResult"];
            if (wechatResult && wechatResult.count) {
                [self wakeUpWechatForPayWithDic:wechatResult];
            }
        }
    } fail:nil];
}

- (void)payCommonByWechatWithRelevanceMap:(NSArray *)orderid_map withPayType:(NSInteger)payType {
    
    NSMutableDictionary *params = @{}.mutableCopy;
    /// {  #关联业务订单信息,key:业务类型{1:茶会订单; 2:艺币充值订单; 3:专场服务费订单; 4:专场保证金订单; 5:商家订单} value:订单ID集合
    params[@"relevanceMap"] = @{StringWithFormat(@(payType)):orderid_map};
    /// #交易渠道 1:支付宝;2:微信;3:apple pay;4:线下支付

    params[@"tradingChannel"] = StringWithFormat(@(2));
    
    [ApiUtil postWithParent:nil url:[ApiUtilHeader payCommon] params:params.copy success:^(NSInteger code, id  _Nullable response) {
        NSDictionary *data = (NSDictionary *)[response objectForKey:@"data"];
        if (data && data.count) {
            NSDictionary *wechatResult = (NSDictionary *)[data objectForKey:@"wechatResult"];
            if (wechatResult && wechatResult.count) {
                [self wakeUpWechatForPayWithDic:wechatResult];
            }else
                [SVProgressHUD showError:@"订单支付失败，请重试或联系客服"];
        }else
            [SVProgressHUD showError:@"订单支付失败，请重试或联系客服"];
    } fail:nil];
}

#pragma mark -
//调微信支付
- (void)wakeUpWechatForPayWithDic:(NSDictionary*)dic {
    //NSLog(@"dic = %@",dic);
    PayReq *request = [[PayReq alloc] init] ;
    request.openID  = [dic objectForKey:@"appid"];
    request.partnerId = [dic objectForKey:@"partnerid"];
    request.prepayId= [dic objectForKey:@"prepayid"];
    request.package = [dic objectForKey:@"package"];
    request.nonceStr= [dic objectForKey:@"noncestr"];
    request.timeStamp=[[dic objectForKey:@"timestamp"] intValue];
    request.sign= [dic objectForKey:@"sign"];
    [WXApi sendReq:request completion:nil];
}

#pragma mark -
/**
 发起微信分享

 @param scene 类型
 */
- (void)wxSendReqWithScene:(AMShareViewItemStyle)scene withParams:(NSDictionary *_Nullable)params {
    if([WXApi isWXAppInstalled]) {//判断当前设备是否安装微信客户端
        NSLog(@"_params = %@",params);
        //创建多媒体消息结构体
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = [ToolUtil isEqualToNonNullKong:[params objectForKey:@"title"]];
        message.description = [ToolUtil isEqualToNonNullKong:[params objectForKey:@"des"]];//描述
        NSString *imageStr = [ToolUtil isEqualToNonNullKong:[params objectForKey:@"img"]];
        message.thumbData = [ImagesTool compressOriginalImageForShare:imageStr];
        
        //创建网页数据对象
        WXWebpageObject *webObj = [WXWebpageObject object];
        webObj.webpageUrl = [params objectForKey:@"url"];//链接
        message.mediaObject = webObj;
        
        SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
        sendReq.bText = NO;//不使用文本信息
        sendReq.message = message;
        sendReq.scene = (scene == AMShareViewItemStyleWX)?0:1;//分享到好友/会话
        
        [WXApi sendReq:sendReq completion:nil];//发送对象实例
    }else{
        //未安装微信应用或版本过低
        AMAlertView *alertView = [AMAlertView shareInstanceWithTitle:@"未检测到微信应用或版本过低" buttonArray:@[@"知道了"] confirm:nil cancel:nil];
        [alertView show];
    }
}

- (void)wxSendImageWithScene:(AMShareViewItemStyle)scene withImage:(UIImage *_Nullable)image {
    if (!image || UIImagePNGRepresentation(image).length <= 0) {
        [SVProgressHUD showError:@"图片错误，请重试"];
        return;
    }
    if([WXApi isWXAppInstalled]) {
        WXImageObject *imageObject = [WXImageObject object];
        imageObject.imageData = UIImagePNGRepresentation(image);
        WXMediaMessage *message = [WXMediaMessage message];
        message.mediaObject = imageObject;
        
        SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
        sendReq.bText = NO;//不使用文本信息
        sendReq.message = message;
        sendReq.scene = (scene == AMShareViewItemStyleWX)?0:1;//分享到好友/会话
        
        [WXApi sendReq:sendReq completion:nil];//发送对象实例
    }else{
        //未安装微信应用或版本过低
        AMAlertView *alertView = [AMAlertView shareInstanceWithTitle:@"未检测到微信应用或版本过低" buttonArray:@[@"知道了"] confirm:nil cancel:nil];
        [alertView show];
    }
}


@end
