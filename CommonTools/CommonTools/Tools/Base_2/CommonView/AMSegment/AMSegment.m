//
//  AMSegment.m
//  ArtMedia2
//
//  Created by icnengy on 2020/6/9.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import "AMSegment.h"

#define AMsetmentItemDefaultTag  890

@interface AMSegmentSlider : UIView
@property (nonatomic ,strong) UIView *slider;
@property (nonatomic ,strong) UIColor *sliderColor;
@end

@implementation AMSegmentSlider

- (UIView *)slider {
    if (_slider) return _slider;
    _slider = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 3)];
    _slider.layer.cornerRadius = _slider.height/2;
    return _slider;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubViews];
    }return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self initSubViews];
    }return self;
}

- (void)initSubViews {
    self.backgroundColor = UIColor.whiteColor;
    self.layer.cornerRadius = self.height/2;
    [self addSubview:self.slider];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.height.equalTo(self);
        make.width.offset(self.width/4);
    }];
}

- (void)setSliderColor:(UIColor *)sliderColor {
    _sliderColor = sliderColor;
    self.slider.backgroundColor = _sliderColor? :RGB(249, 110, 34);
}

@end

@interface AMSegment ()
@property (nonatomic ,strong) AMSegmentSlider *slider;
@end

@implementation AMSegment {
    NSInteger _selectedIndex;
    NSMutableArray <AMBadgeNumberButton *>*_itemArray;
    AMSegmentStyle _style;
}

- (AMSegmentSlider *)slider {
    if (!_slider) {
        _slider = [[AMSegmentSlider alloc] initWithFrame:CGRectMake(0, 0, 0, 3)];
    }return _slider;
}

- (instancetype)initWithItemArray:(NSArray *_Nullable)items segStyle:(AMSegmentStyle)segStyle {
    if (self = [super init]) {
        self.items = items;
        self.segStyle = segStyle;
        [self setup];
    }return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.segStyle = AMSegmentStyleNone;
        [self setup];
    }return self;
}

- (void)setup {
    self.selectedSegmentIndex  = 0;
    [self addSubview:self.slider];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_itemArray.count) {
        CGFloat width = (self.width-10.0f*(_itemArray.count +1)) / _itemArray.count;
        CGFloat height = self.height*0.7;
        _slider.width = width;
        _slider.y = self.height-_slider.height;
        [_itemArray enumerateObjectsUsingBlock:^(AMBadgeNumberButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.layer.cornerRadius = obj.height/2;
            obj.frame = CGRectMake(10.0f+idx*(width + 10.0f), (self.height-height)/2, width, height);
        }];
    }
}

- (IBAction)clickToSelect:(AMBadgeNumberButton *)sender {
    if (_selectedIndex == (sender.tag - AMsetmentItemDefaultTag)) return;
    _selectedIndex = sender.tag - AMsetmentItemDefaultTag;
    [_itemArray enumerateObjectsUsingBlock:^(AMBadgeNumberButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = (obj.tag == sender.tag)?YES:NO;
    }];
    [self updateSliderPosition];
    if (self.delegate && [self.delegate respondsToSelector:@selector(segment: switchSegmentIndex:)]) {
        [self.delegate segment:self switchSegmentIndex:_selectedIndex];
    }
}

#pragma mark - setter
- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex {
    _selectedIndex = selectedSegmentIndex;
    [self updateSegment];
}

- (void)setItems:(NSArray *)items {
    _items = items;
    if (!items.count) return;
    if (!_itemArray.count) _itemArray = @[].mutableCopy;
    NSMutableArray <AMBadgeNumberButton *>*itemArray = _itemArray;
    if (items.count < _itemArray.count) {///需要移除button
        [itemArray enumerateObjectsUsingBlock:^(AMBadgeNumberButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx < items.count) {
                [_itemArray replaceObjectAtIndex:idx withObject:obj];
            }else {
                _selectedIndex = 0;
                [obj removeFromSuperview];
                [_itemArray removeObjectAtIndex:idx];
            }
        }];
    }else if (items.count > _itemArray.count) {///需要新增button
        [items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx < _itemArray.count) {
                AMBadgeNumberButton *item = itemArray[idx];
                [_itemArray replaceObjectAtIndex:idx withObject:item];
            }else {
                AMBadgeNumberButton *item = [AMBadgeNumberButton buttonWithType:UIButtonTypeCustom];
                [self addSubview:item];
                
                item.tag = _itemArray.count + AMsetmentItemDefaultTag;
                [item addTarget:self action:@selector(clickToSelect:) forControlEvents:UIControlEventTouchUpInside];
                
                [_itemArray insertObject:item atIndex:_itemArray.count];
            }
        }];
    }
    
    
    [self updateSegment];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setBadges:(NSArray *)badges {
    _badges = badges;
    
    [self updateSegment];
}

- (void)setNormalItemTextAttributes:(NSDictionary<NSAttributedStringKey,id> *)normalItemTextAttributes {
    _normalItemTextAttributes = normalItemTextAttributes;
    [self updateSegment];
}

- (void)setSelectedItemTextAttributes:(NSDictionary<NSAttributedStringKey,id> *)selectedItemTextAttributes {
    _selectedItemTextAttributes = selectedItemTextAttributes;
    [self updateSegment];
}

- (void)setSegStyle:(AMSegmentStyle)segStyle {
    _style = segStyle;
    [self updateSegment];
}

- (void)setSliderColor:(UIColor *)sliderColor {
    _sliderColor = sliderColor;
    _slider.sliderColor = _sliderColor;
}

#pragma mark - getter
- (NSInteger)selectedSegmentIndex{
    return _selectedIndex;
}

- (AMSegmentStyle)segStyle {
    return _style;
}

#pragma mark - private
- (void)updateSliderPosition {
    CGFloat newOriginX = _selectedIndex *(_slider.width +10.0f) + 10.0f;
    CGFloat oldOriginX = _slider.x;
    if (newOriginX != oldOriginX) {
        CGFloat offset = newOriginX - oldOriginX;
        [UIView animateWithDuration:0.33 animations:^{
            _slider.x += offset;
        }];
    }
}

- (void)updateSegment {
    _slider.sliderColor = _sliderColor;
    [self updateSliderPosition];
    [_itemArray enumerateObjectsUsingBlock:^(AMBadgeNumberButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //设置button文字/文字颜色
        [self setButton:obj withTitle:_items[idx]];
        //设置背景
        obj.backgroundColor = UIColor.whiteColor;
        if (_style == AMSegmentStyleCoverView) {
            obj.backgroundColor =  _itemBackgroundColor? :RGB(247, 247, 247);
        }
        //设置滑块
        _slider.hidden = YES;
        if (_style == AMSegmentStyleProgressView) {
            _slider.hidden = NO;
        }
        //设置选中
        obj.selected = (obj.tag == _selectedIndex + AMsetmentItemDefaultTag)?YES:NO;
        
        //设置badge
        if (_badges.count && _badges.count == _itemArray.count) {
            obj.badgeNum = [_badges[idx] integerValue];
            [_itemArray replaceObjectAtIndex:idx withObject:obj];
        }
    }];
}

- (void)setButton:(AMBadgeNumberButton *)btn withTitle:(NSString *)title {
    [self setAttributedBtn:btn withTitle:title forState:UIControlStateNormal];
    [self setAttributedBtn:btn withTitle:title forState:UIControlStateSelected];
}

- (void)setAttributedBtn:(AMBadgeNumberButton *)btn withTitle:(NSString *)title forState:(UIControlState)state {
    NSDictionary <NSAttributedStringKey ,id> *attributes;
    if (state == UIControlStateNormal) {
        attributes = self.normalItemTextAttributes? :@{NSFontAttributeName:[UIFont addHanSanSC:16.0f fontType:0], NSForegroundColorAttributeName:RGB(153, 153, 153)};
    }
    if (state == UIControlStateSelected) {
        attributes = self.selectedItemTextAttributes? :@{NSFontAttributeName:[UIFont addHanSanSC:16.0f fontType:1], NSForegroundColorAttributeName:RGB(21, 22, 26)};
    }
    if ([ToolUtil isEqualToNonNullKong:title]) {
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:title];
        [attributedStr setAttributes:attributes range:[title rangeOfString:title]];
        [btn setAttributedTitle:attributedStr forState:state];
    }
}

@end
