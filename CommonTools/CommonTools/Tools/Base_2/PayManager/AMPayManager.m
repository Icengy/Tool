//
//  AMPayManager.m
//  ArtMedia2
//
//  Created by icnengy on 2020/11/23.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import "AMPayManager.h"

@interface AMPayManager ()

@property (nonatomic ,weak) id <AMPayManagerDelagate> delegate;

@end

@implementation AMPayManager

static AMPayManager*manager = nil;

+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

- (void)dealloc {
    [self removeObserverForWXPay];
    [self removeObserverForAliPay];
}

/// 添加监听者
- (void)addObserverForWXPay {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showWXPayResult:) name:WXPaymentResultForNormal object:nil];
}

- (void)addObserverForAliPay {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAliPayResult:) name:AliPaymentResultForNormal object:nil];
}

/// 移除监听者
- (void)removeObserverForWXPay {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WXPaymentResultForNormal object:nil];
}

- (void)removeObserverForAliPay {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AliPaymentResultForNormal object:nil];
}

#pragma mark -
- (void)payCommonWithRelevanceMap:(NSArray *)orderid_map withPayType:(NSInteger)payType byChannel:(NSInteger)payChannel delegate:(id <AMPayManagerDelagate>)delegate {
    self.delegate = delegate;
    
    /// 1:支付宝;2:微信;3:apple pay;4:线下支付
    switch (payChannel) {
        case 2: {/// 微信
            [self addObserverForWXPay];
            [[WechatManager shareManager] payCommonByWechatWithRelevanceMap:orderid_map withPayType:payType];
            break;
        }
        case 1: {/// 支付宝
            [self addObserverForAliPay];
            [[AlipayManager shareManager] payCommonByAlipayWithRelevanceMap:orderid_map withPayType:payType];
            break;
        }
        case 3:/// apple pay
            
            break;
        case 4: ///线下支付
            [self payOfflineWithRelevanceMap:orderid_map withPayType:payType];
            break;
            
        default:
            break;
    }
}

- (void)payIdentifyFeeWithType:(NSString*)type roleType:(NSString *)roleType byChannel:(NSInteger)payChannel delegate:(id <AMPayManagerDelagate>)delegate {
    self.delegate = delegate;
    
    /// 1:支付宝、2:微信
    switch (payChannel) {
        case 2: {/// 微信
            [self addObserverForWXPay];
            [[WechatManager shareManager] payIdentifyFeeWithType:type roleType:roleType];
            break;
        }
        case 1: {/// 支付宝
            [self addObserverForAliPay];
            [[AlipayManager shareManager] payIdentifyFeeWithType:type roleType:roleType];
            break;
        }
            
        default:
            break;
    }
}

- (void)payOrderWithType:(NSString*)type withOrderID:(NSString*)order_id byChannel:(NSInteger)payChannel delegate:(id <AMPayManagerDelagate>)delegate {
    self.delegate = delegate;
    
    /// 1:支付宝、2:微信
    switch (payChannel) {
        case 2: {/// 微信
            [self addObserverForWXPay];
            [[WechatManager shareManager] payOrderWithType:type withOrderID:order_id];
            break;
        }
        case 1: {/// 支付宝
            [self addObserverForAliPay];
            [[AlipayManager shareManager] payOrderWithType:type withOrderID:order_id];
            break;
        }
            
        default:
            break;
    }
}

- (void)payMeetingOrderWithID:(NSString *)order_id type:(NSString *)type byChannel:(NSInteger)payChannel delegate:(id <AMPayManagerDelagate>)delegate {
    self.delegate = delegate;
    
    /// 1:支付宝、2:微信
    switch (payChannel) {
        case 2: {/// 微信
            [self addObserverForWXPay];
            [[WechatManager shareManager] payMeetingOrderWithID:order_id type:type];
            break;
        }
        case 1: {/// 支付宝
            [self addObserverForAliPay];
            [[AlipayManager shareManager] payMeetingOrderWithID:order_id type:type];
            break;
        }
            
        default:
            break;
    }
}

- (void)payGiftWithReceiverID:(NSString *)receiver_id
                     videoid:(NSString *)video_id
                      giftID:(NSString*)gift_id
                    giftCount:(NSInteger)gift_count
                    byChannel:(NSInteger)payChannel delegate:(id <AMPayManagerDelagate>)delegate {
    /// 1:支付宝、2:微信
    switch (payChannel) {
        case 2: {/// 微信
            [self addObserverForWXPay];
            [[WechatManager shareManager] payGiftWithReceiverID:receiver_id videoid:video_id giftID:gift_id giftCount:gift_count];
            break;
        }
        case 1: {/// 支付宝
            [self addObserverForAliPay];
            [[AlipayManager shareManager] payGiftWithReceiverID:receiver_id videoid:video_id giftID:gift_id giftCount:gift_count];
            break;
        }
            
        default:
            break;
    }
}

#pragma mark -
- (void)payOfflineWithRelevanceMap:(NSArray *)orderid_map withPayType:(NSInteger)payType {
    
    NSMutableDictionary *params = @{}.mutableCopy;
    /// {  #关联业务订单信息,key:业务类型{1:茶会订单; 2:艺币充值订单; 3:专场服务费订单; 4:专场保证金订单; 5:商家订单} value:订单ID集合
    params[@"relevanceMap"] = @{StringWithFormat(@(payType)):orderid_map};
    /// #交易渠道 1:支付宝;2:微信;3:apple pay;4:线下支付
    params[@"tradingChannel"] = StringWithFormat(@(4));
    
    [ApiUtil postWithParent:nil url:[ApiUtilHeader payCommon] params:params.copy success:^(NSInteger code, id  _Nullable response) {
        NSDictionary *data = (NSDictionary *)[response objectForKey:@"data"];
        if (data && data.count) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(getOfflinePayResult:offlineTradeNo:)]) {
                [self.delegate getOfflinePayResult:YES offlineTradeNo:[data objectForKey:@"offlineTradeNo"]];
            }
        }else
            [SVProgressHUD showError:@"订单支付失败，请重试或联系客服" completion:^{
                if (self.delegate && [self.delegate respondsToSelector:@selector(getOfflinePayResult:offlineTradeNo:)]) {
                    [self.delegate getOfflinePayResult:NO offlineTradeNo:nil];
                }
            }];
    } fail:^(NSInteger errorCode, NSString * _Nullable errorMsg) {
        [SVProgressHUD showError:errorMsg completion:^{
            if (self.delegate && [self.delegate respondsToSelector:@selector(getOfflinePayResult:offlineTradeNo:)]) {
                [self.delegate getOfflinePayResult:NO offlineTradeNo:nil];
            }
        }];
        
    }];
}

#pragma mark -
- (void)showWXPayResult:(NSNotification *)noti {
    [self removeObserverForWXPay];
    BOOL isSuccess = [noti.object boolValue];
    
    [[AMAlertView shareInstanceWithTitle:isSuccess?@"支付成功！":@"支付失败，请重试！" buttonArray:@[@"确定"] confirm:^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(getWXPayResult:)]) {
            [self.delegate getWXPayResult:isSuccess];
        }
    } cancel:nil] show];

}

- (void)showAliPayResult:(NSNotification *)noti {
    [self removeObserverForAliPay];
    NSInteger resultCode = [noti.object integerValue];
    if (resultCode == 0) {
        [[AMAlertView shareInstanceWithTitle:@"支付成功！" buttonArray:@[@"确定"] confirm:^{
            [self getAlipayPayResult:YES];
        } cancel:nil] show];
    }else if (resultCode == 1) {
        [[AMAlertView shareInstanceWithTitle:@"已取消支付" buttonArray:@[@"确定"] confirm:^{
            [self getAlipayPayResult:NO];
        } cancel:nil] show];
    }else {
        [[AMAlertView shareInstanceWithTitle:@"支付失败，请重试！" buttonArray:@[@"确定"] confirm:^{
            [self getAlipayPayResult:NO];
        } cancel:nil] show];
    }
}

- (void)getAlipayPayResult:(BOOL)isSuccess {
    if (self.delegate && [self.delegate respondsToSelector:@selector(getAlipayPayResult:)]) {
        [self.delegate getAlipayPayResult:isSuccess];
    }
}

@end
