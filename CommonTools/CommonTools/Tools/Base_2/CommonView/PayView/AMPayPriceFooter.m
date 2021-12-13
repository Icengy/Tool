//
//  AMPayPriceFooter.m
//  ArtMedia2
//
//  Created by icnengy on 2020/7/2.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import "AMPayPriceFooter.h"

@interface AMPayPriceFooter ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation AMPayPriceFooter

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    _label.font = [UIFont addHanSanSC:14.0f fontType:0];
}

- (IBAction)clickToAddNewBank:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(payFooter:didClickToAddNewBank:)]) {
        [self.delegate payFooter:self didClickToAddNewBank:sender];
    }
}

@end
