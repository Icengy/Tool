//
//  AlipayManager.m
//  ArtMedia2
//
//  Created by icnengy on 2020/2/25.
//  Copyright © 2020 lcy. All rights reserved.
//

#import "AlipayManager.h"

#import <AlipaySDK/AlipaySDK.h>

@implementation AlipayManager
static AlipayManager *manager=nil;

+(instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

#pragma mark -
- (void)payIdentifyFeeWithType:(NSString *)type roleType:(NSString *)roleType {
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    params[@"uid"] = [UserInfoManager shareManager].uid;
    params[@"type"] = type;
    params[@"roletype"] = roleType;
    params[@"apptype"] = @"6";
    
    [ApiUtil postWithParent:nil url:[ApiUtilHeader sendOrderWithAlipay] params:params.copy success:^(NSInteger code, id  _Nullable response) {
        NSString *d = (NSString *)[response objectForKey:@"data"];
        [self wakeUpAlipayForPayWithOrderString:d];
    } fail:nil];
}

- (void)payOrderWithType:(NSString*)type withOrderID:(NSString*)order_id {
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    params[@"uid"] = [UserInfoManager shareManager].uid;
    params[@"type"] = type;
    params[@"order_id"] = [ToolUtil isEqualToNonNullKong:order_id];
    params[@"apptype"] = @"6";
    
    [ApiUtil postWithParent:nil url:[ApiUtilHeader sendOrderWithAlipay] params:params.copy success:^(NSInteger code, id  _Nullable response) {
        NSString *d = (NSString *)[response objectForKey:@"data"];
        [self wakeUpAlipayForPayWithOrderString:d];
    } fail:nil];
}

- (void)payGiftWithReceiverID:(NSString *)receiver_id
                     videoid:(NSString *)video_id
                      giftID:(NSString*)gift_id
                   giftCount:(NSInteger)gift_count {
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    params[@"giveruid"] = [UserInfoManager shareManager].uid;
    
    params[@"apptype"] = @"6";
    params[@"type"] = @"8";
    
    params[@"uid"] = [ToolUtil isEqualToNonNullKong:receiver_id];
    params[@"giftid"] = [ToolUtil isEqualToNonNullKong:gift_id];
    params[@"num"] = [NSString stringWithFormat:@"%@",@(gift_count)];
    params[@"videoid"] = [ToolUtil isEqualToNonNullKong:video_id];
    
    [ApiUtil postWithParent:nil url:[ApiUtilHeader sendOrderWithAlipay] params:params.copy success:^(NSInteger code, id  _Nullable response) {
        NSString *d = (NSString *)[response objectForKey:@"data"];
        [self wakeUpAlipayForPayWithOrderString:d];
    } fail:nil];
}

- (void)payMeetingOrderWithID:(NSString *)order_id type:(NSString *)type {
    NSMutableDictionary *params = @{}.mutableCopy;
    params[@"relevanceId"] = [ToolUtil isEqualToNonNullKong:order_id];
    params[@"relevanceType"] = type;
    params[@"tradingChannel"] = @"1";
    
    [ApiUtil postWithParent:nil url:[ApiUtilHeader payTeaOrder] params:params.copy success:^(NSInteger code, id  _Nullable response) {
        NSDictionary *data = (NSDictionary *)[response objectForKey:@"data"];
        if (data && data.count) {
            NSString *aliResult = [data objectForKey:@"aliResult"];
            if ([ToolUtil isEqualToNonNull:aliResult]) {
                [self wakeUpAlipayForPayWithOrderString:aliResult];
            }
        }
    } fail:nil];
}

- (void)payCommonByAlipayWithRelevanceMap:(NSArray *)orderid_map withPayType:(NSInteger)payType {
    
    NSMutableDictionary *params = @{}.mutableCopy;
    /// {  #关联业务订单信息,key:业务类型{1:茶会订单; 2:艺币充值订单; 3:专场服务费订单; 4:专场保证金订单; 5:商家订单} value:订单ID集合
    params[@"relevanceMap"] = @{StringWithFormat(@(payType)):orderid_map};
    /// #交易渠道 1:支付宝;2:微信;3:apple pay;4:线下支付
    params[@"tradingChannel"] = StringWithFormat(@(1));
    
    [ApiUtil postWithParent:nil url:[ApiUtilHeader payCommon] params:params.copy success:^(NSInteger code, id  _Nullable response) {
        NSDictionary *data = (NSDictionary *)[response objectForKey:@"data"];
        if (data && data.count) {
            NSString *aliResult = (NSString *)[data objectForKey:@"aliResult"];
            if ([ToolUtil isEqualToNonNull:aliResult]) {
                [self wakeUpAlipayForPayWithOrderString:aliResult];
            }else
                [SVProgressHUD showError:@"订单支付失败，请重试或联系客服"];
        }else
            [SVProgressHUD showError:@"订单支付失败，请重试或联系客服"];
    } fail:nil];
}


#pragma mark -
- (void)wakeUpAlipayForPayWithOrderString:(NSString *)orderString {
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:@"artvideoForMSCM" callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
        NSDictionary * dict;
        if ([resultDic[@"resultStatus"] integerValue] == 9000) {
            dict = @{@"code":@"0",@"result":@"支付成功"};
            [SVProgressHUD showSuccess:dict[@"result"]];
        } else if([resultDic[@"resultStatus"] integerValue] == 6001) {
            dict = @{@"code":@"-2",@"result":@"已取消支付"};
            [SVProgressHUD showMsg:dict[@"result"]];
        } else{
            dict = @{@"code":@"-1",@"result":@"支付失败"};
            [SVProgressHUD showError:dict[@"result"]];
        }
    }];
}

@end
