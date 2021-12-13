//
//  ComplexImageView.m
//  ArtMedia2
//
//  Created by icnengy on 2020/5/27.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import "ComplexImageView.h"

@implementation ComplexImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.clearColor;
    }return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        self.backgroundColor = UIColor.clearColor;
    }return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = UIColor.clearColor;
}


- (UIImageView *)createImageView {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.layer.borderWidth = 2.0f;
    imageView.layer.borderColor = UIColor.whiteColor.CGColor;
    imageView.layer.masksToBounds = YES;
    return imageView;
}

- (void)setImageArray:(NSArray<NSString *> *)imageArray {
    _imageArray = imageArray;
    if (self.subviews.count) [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (_imageArray.count == 1) {
        UIImageView *imageView = [self createImageView];
        [self addSubview:imageView];
        [imageView am_setImageWithURL:imageArray.lastObject placeholderImage:ImageNamed(@"logo") contentMode:(UIViewContentModeScaleAspectFill)];
        
        imageView.frame = self.bounds;
        imageView.layer.cornerRadius = imageView.width/2;
    }else {
        for (int i = 0; i < _imageArray.count; i ++) {
            
            UIImageView *imageView = [self createImageView];
            [self addSubview:imageView];
            [imageView am_setImageWithURL:_imageArray[i] placeholderImage:ImageNamed(@"logo") contentMode:(UIViewContentModeScaleAspectFill)];
            
            CGPoint orgin = self.bounds.origin;
            CGSize size = self.bounds.size;
            if (i == 0) {
                //players[0].frame = (CGRect){.origin = CGPointZero, .size = self.view.frame.size};
                size = CGSizeMake(size.width*0.9, size.width*0.9);
                imageView.frame = (CGRect){.origin = orgin, .size = size};
            }else {
                size = CGSizeMake(size.width*0.7, size.width*0.7);
                orgin = CGPointMake(self.width-size.width, self.height-size.height);
                imageView.frame = (CGRect){.origin = orgin, .size = size};
            }
            
            imageView.layer.cornerRadius = imageView.width/2;
        }
    }
}

@end
