//
//  UIView+Extension.h
//
//

#import <UIKit/UIKit.h>

#define ScrW [UIScreen mainScreen].bounds.size.width
#define ScrH [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface UIView (Extension)

- (UIViewController *)tx_viewController;
- (void)tx_observeKeyboardOnChange:(void(^)(CGFloat keyboardTop, CGFloat height))changeHandler;

/** UIView 的坐标X点 */
@property (nonatomic, assign) CGFloat x;
/** UIView 的坐标Y点 */
@property (nonatomic, assign) CGFloat y;

/** UIView 的中心点X值 */
@property (nonatomic, assign) CGFloat centerX;
/** UIView 的中心点Y值 */
@property (nonatomic, assign) CGFloat centerY;

/** UIView的最大X值 */
@property (assign, nonatomic) CGFloat maxX;
/** UIView的最大Y值 */
@property (assign, nonatomic) CGFloat maxY;

/** UIView 的宽度 */
@property (nonatomic, assign) CGFloat width;
/** UIView 的高度 */
@property (nonatomic, assign) CGFloat height;

/** UIView 的 size */
@property (nonatomic, assign) CGSize size;
/** UIView 的坐标 */
@property (nonatomic, assign) CGPoint origin;

/** UIView 的宽度 bounds */
@property (nonatomic, assign) CGFloat boundsWidth;

/** UIView 的高度 bounds */
@property (nonatomic, assign) CGFloat boundsHeight;

/**
 *  9.上 < Shortcut for frame.origin.y
 */
@property (nonatomic) CGFloat top;

/**
 *  10.下 < Shortcut for frame.origin.y + frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 *  11.左 < Shortcut for frame.origin.x.
 */
@property (nonatomic) CGFloat left;

/**
 *  12.右 < Shortcut for frame.origin.x + frame.size.width
 */
@property (nonatomic) CGFloat right;


#pragma mark -
/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii;
/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param rect    需要设置的圆角view的rect
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect;


#pragma mark -
typedef NS_OPTIONS(NSUInteger, UIBorderSideType) {
    UIBorderSideTypeAll  = 0,
    UIBorderSideTypeTop = 1 << 0,
    UIBorderSideTypeBottom = 1 << 1,
    UIBorderSideTypeLeft = 1 << 2,
    UIBorderSideTypeRight = 1 << 3,
};

- (void)borderForColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(UIBorderSideType)borderType;

#pragma mark -加载view类名对应的Xib
+ (instancetype)am_loadFirstViewFromXib;

@end
