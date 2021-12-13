//
//  ToolMacro.h
//  ArtMedia
//
//  Created by 美术传媒 on 2018/10/8.
//  Copyright © 2018年 lcy. All rights reserved.
//

#ifndef ToolMacro_h
#define ToolMacro_h

#define Lead_Space 15.f
#define WeakSelf(type)  __weak typeof(type) weak##type = type;
// 适配比例
#define ADAPTATIONRATIO     K_Width / 750.0f
#define ADAPTATIONRATIOVALUE(value)   ADAPTATIONRATIO *value
#define ADAptationMargin   ADAPTATIONRATIOVALUE(20.0f)
#define ADBottomButtonHeight  ADAPTATIONRATIOVALUE(84.0f)
#define ADRowHeight  (ADDefaultButtonHeight *1.2)
#define ADDefaultButtonHeight ADAPTATIONRATIOVALUE(70.0f)
#define FONTN1(NAME, FONTSIZE)    [UIFont fontWithName:(NAME) size:(FONTSIZE)]

#define DefaultFont [UIFont addHanSanSC:(15.0f) fontType:0]
#define DefaultTextFont [UIFont addHanSanSC:(12.0f) fontType:0]

#define MainLabelColor       [UIColor colorWithRed:(153)/255.0f green:(153)/255.0f blue:(153)/255.0f alpha:1]
#define TitleColor   [UIColor colorWithRed:(21)/255.0f green:(21)/255.0f blue:(25)/255.0f alpha:1]
#define MainScreenWidht [UIScreen mainScreen].bounds.size.width/375.0
#define MainScreenHeight [UIScreen mainScreen].bounds.size.height/667.0

/**宽度比例*/
#define CZH_ScaleWidth(__VA_ARGS__)  ([UIScreen mainScreen].bounds.size.width/375)*(__VA_ARGS__)

/**高度比例*/
#define CZH_ScaleHeight(__VA_ARGS__)  ([UIScreen mainScreen].bounds.size.height/667)*(__VA_ARGS__)
//字体
#define CZHGlobelNormalFont(__VA_ARGS__) ([UIFont systemFontOfSize:CZH_ScaleFont(__VA_ARGS__)])

//定义UIImage对象
#define ImageNamed(_pointer) [UIImage imageNamed:_pointer]
//
#define StringWithFormat(_pointer)  [NSString stringWithFormat:@"%@",_pointer]

#define is_IPhone13  @available(iOS 13.0, *)
#define Is_IPhoneX   [ToolUtil isPhoneX]

#define StatusNav_Height    (Is_IPhoneX ? 88.f : 64.f)
#define StatusBar_Height     (Is_IPhoneX ? (44.0):(20.0))
#define TabBar_Height        49.0f
#define NavBar_Height        44.0f
#define SearchBar_Height    55.0f

//适配iPhoneX
#define SafeAreaTopHeight               (Is_IPhoneX ? 88.0 : 64.0)
#define SafeAreaBottomHeight          (Is_IPhoneX ? 34 : 0)
#define SafeAreaStatuBarHeight        (Is_IPhoneX ? 44 : 20)
#define SafeAreaValueHeight             (Is_IPhoneX ? 24 : 0)

#define k_Bounds ([UIScreen mainScreen].bounds)
#define K_Width  ([UIScreen mainScreen].bounds.size.width)
#define K_Height ([UIScreen mainScreen].bounds.size.height)

#define ViewWidthOf(view) self.frame.size.width
#define ViewHeightOf(view) self.frame.size.height

#define  AMUserDefaults   [NSUserDefaults standardUserDefaults]
#define  AMUserDefaultsObjectForKey(key)   [AMUserDefaults objectForKey:key]

//#define  AMSetObject(obj, key)   [AMUserDefaults setObject:obj forKey:key]
//#define AMUserDefaultsSynchronize  [AMUserDefaults synchronize]

#define AMUserDefaultsSetObject(obj, key) [AMUserDefaults setObject:obj forKey:key]
#define AMUserDefaultsSynchronize  [AMUserDefaults synchronize]

//获取SDKAppID  SECRETKEY
#define  AM_SDKAppID   (UInt32)[[AMUserDefaults objectForKey:@"sdkAppId"] integerValue]
#define  AM_SDKAppKey   [AMUserDefaults objectForKey:@"sdkAppKey"]

#define AMBundleName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

#define isiOS13 ([UIDevice currentDevice].systemVersion.floatValue >= 13.0)
#define isiOS14 ([UIDevice currentDevice].systemVersion.floatValue >= 14.0)
// 来自YYKit
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

#endif /* ToolMacro_h */
