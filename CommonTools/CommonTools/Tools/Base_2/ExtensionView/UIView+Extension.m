//
//  UIView+Extension.m
//
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (UIViewController *)tx_viewController {
    UIView *view = self;
    while (view) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
        view = view.superview;
      }
    return nil;
}

- (void)tx_observeKeyboardOnChange:(void(^)(CGFloat keyboardTop, CGFloat height))changeHandler {
    __weak __typeof(self) wSelf = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillChangeFrameNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        CGRect endFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        double animDuration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        changeHandler(endFrame.origin.y, endFrame.size.height);
        [UIView animateWithDuration:animDuration animations:^{
            [wSelf layoutIfNeeded];
        }];
    }];
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setMaxX:(CGFloat)maxX{
    CGRect frame = self.frame;
    frame.origin.x = maxX - frame.size.width;
    self.frame = frame;
}

- (CGFloat)maxX{
    return CGRectGetMaxX(self.frame);
}

- (void)setMaxY:(CGFloat)maxY{
    CGRect frame = self.frame;
    frame.origin.y = maxY - frame.size.height;
    self.frame = frame;
}

- (CGFloat)maxY{
    return CGRectGetMaxY(self.frame);
}


- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

-(CGFloat)boundsWidth{
    return self.bounds.size.width;
}

-(void)setBoundsWidth:(CGFloat)boundsWidth{
    CGRect bounds = self.bounds;
    bounds.size.width = boundsWidth;
    self.bounds = bounds;
}

-(CGFloat)boundsHeight{
    return self.bounds.size.height;
}

-(void)setBoundsHeight:(CGFloat)boundsHeight{
    CGRect bounds = self.bounds;
    bounds.size.height = boundsHeight;
    self.bounds = bounds;
}





- (CGFloat)left {
	return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
	CGRect frame = self.frame;
	frame.origin.x = x;
	self.frame = frame;
}

- (CGFloat)top {
	return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
	CGRect frame = self.frame;
	frame.origin.y = y;
	self.frame = frame;
}

- (CGFloat)right {
	return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
	CGRect frame = self.frame;
	frame.origin.x = right - frame.size.width;
	self.frame = frame;
}

- (CGFloat)bottom {
	return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
	CGRect frame = self.frame;
	frame.origin.y = bottom - frame.size.height;
	self.frame = frame;
}


#pragma mark - 设置部分圆角
///设置部分圆角(绝对布局)
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii {
    
    if (@available(iOS 11.0, *)) {
        self.layer.cornerRadius = radii.height;
        self.layer.maskedCorners = (CACornerMask)corners;
        self.layer.masksToBounds = YES;
    } else {
        UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radii];
        CAShapeLayer* shape = [[CAShapeLayer alloc] init];
        shape.frame = self.bounds;
        [shape setPath:rounded.CGPath];
        
        self.layer.mask = shape;
    }
}


///设置部分圆角(相对布局)
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect {
    if (@available(iOS 11.0, *)) {
        self.layer.cornerRadius = radii.height;
        self.layer.maskedCorners = (CACornerMask)corners;
        self.layer.masksToBounds = YES;
    } else {
        UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
        CAShapeLayer* shape = [[CAShapeLayer alloc] init];
        [shape setPath:rounded.CGPath];
        
        self.layer.mask = shape;
    }
}

#pragma mark -
- (void)borderForColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(UIBorderSideType)borderType {
    
    if (borderType == UIBorderSideTypeAll) {
        self.layer.borderWidth = borderWidth;
        self.layer.borderColor = color.CGColor;
    }
    
    
    /// 左侧
    if (borderType & UIBorderSideTypeLeft) {
        /// 左侧线路径
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.f, 0.f) toPoint:CGPointMake(0.0f, self.frame.size.height) color:color borderWidth:borderWidth]];
    }
    
    /// 右侧
    if (borderType & UIBorderSideTypeRight) {
        /// 右侧线路径
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(self.frame.size.width, 0.0f) toPoint:CGPointMake( self.frame.size.width, self.frame.size.height) color:color borderWidth:borderWidth]];
    }
    
    /// top
    if (borderType & UIBorderSideTypeTop) {
        /// top线路径
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.0f, 0.0f) toPoint:CGPointMake(self.frame.size.width, 0.0f) color:color borderWidth:borderWidth]];
    }
    
    /// bottom
    if (borderType & UIBorderSideTypeBottom) {
        /// bottom线路径
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.0f, self.frame.size.height) toPoint:CGPointMake( self.frame.size.width, self.frame.size.height) color:color borderWidth:borderWidth]];
    }
}

- (CAShapeLayer *)addLineOriginPoint:(CGPoint)p0 toPoint:(CGPoint)p1 color:(UIColor *)color borderWidth:(CGFloat)borderWidth {

    /// 线的路径
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:p0];
    [bezierPath addLineToPoint:p1];
    
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.fillColor  = [UIColor clearColor].CGColor;
    /// 添加路径
    shapeLayer.path = bezierPath.CGPath;
    /// 线宽度
    shapeLayer.lineWidth = borderWidth;
    return shapeLayer;
}

#pragma mark -加载view类名对应的Xib
+ (instancetype)am_loadFirstViewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

@end
