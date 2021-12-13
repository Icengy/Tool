//
//  AMPayPriceHeader.m
//  ArtMedia2
//
//  Created by icnengy on 2020/5/21.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import "AMPayPriceHeader.h"

@interface AMPayPriceHeader ()
@property (weak, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet AMButton *priceBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation AMPayPriceHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }return self;
}

- (void)setup {
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    [self addSubview:self.view];
    self.view.frame = self.bounds;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _priceBtn.titleLabel.font = [UIFont addHanSanSC:28 fontType:2];
    _titleLabel.font = [UIFont addHanSanSC:14.0f fontType:0];
}

- (void)setPayStyle:(AMAwakenPayStyle)payStyle {
    _payStyle = payStyle;
    _priceBtn.selected = (_payStyle == AMAwakenPayStyleConsumption);
    switch (_payStyle) {
        case AMAwakenPayStyleDefalut: {
            _titleLabel.text = @"支付金额";
            break;
        }
        case AMAwakenPayStyleRecharge: {
            _titleLabel.text = @"充值艺币数量";
            break;
        }
        case AMAwakenPayStyleConsumption: {
            _titleLabel.text = @"支付艺币";
            break;
        }
            
        default:
            break;
    }
}

- (void)setPriceStr:(NSString *)priceStr {
    _priceStr = priceStr;
    switch (_payStyle) {
        case AMAwakenPayStyleDefalut: {
            [_priceBtn setTitle:[NSString stringWithFormat:@"¥ %.2f", _priceStr.doubleValue] forState:_priceBtn.state];
            break;
        }
        case AMAwakenPayStyleRecharge: {
            [_priceBtn setTitle:[NSString stringWithFormat:@"%@", @(_priceStr.integerValue)] forState:_priceBtn.state];
            break;
        }
        case AMAwakenPayStyleConsumption: {
            [_priceBtn setTitle:[NSString stringWithFormat:@"%@", @(_priceStr.integerValue)] forState:_priceBtn.state];
            break;
        }
            
        default:
            [_priceBtn setTitle:[NSString stringWithFormat:@"¥ %.2f", _priceStr.doubleValue] forState:_priceBtn.state];
            break;
    }
}

- (IBAction)clickToDismiss:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(payHeader:didClickToDismiss:)]) {
        [self.delegate payHeader:self didClickToDismiss:sender];
    }
}

@end
