//
//  ColorsMacro.h
//  ArtMedia2
//
//  Created by icnengy on 2020/3/25.
//  Copyright © 2020 翁磊. All rights reserved.
//

#ifndef ColorsMacro_h
#define ColorsMacro_h

// 取色值相关的方法
#define RGB(r,g,b)          [UIColor colorWithRed:(r)/255.f \
                                            green:(g)/255.f \
                                             blue:(b)/255.f \
                                            alpha:1.f]

#define RGBA(r,g,b,a)       [UIColor colorWithRed:(r)/255.f \
                                            green:(g)/255.f \
                                             blue:(b)/255.f \
                                            alpha:(a)]

#define RGBOF(rgbValue)     [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                                            green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
                                             blue:((float)(rgbValue & 0xFF))/255.0 \
                                            alpha:1.0]

#define RGBA_OF(rgbValue)   [UIColor colorWithRed:((float)(((rgbValue) & 0xFF000000) >> 24))/255.0 \
                                             green:((float)(((rgbValue) & 0x00FF0000) >> 16))/255.0 \
                                              blue:((float)(rgbValue & 0x0000FF00) >> 8)/255.0 \
                                             alpha:((float)(rgbValue & 0x000000FF))/255.0]

#define RGBAOF(v, a)        [UIColor colorWithRed:((float)(((v) & 0xFF0000) >> 16))/255.0 \
                                            green:((float)(((v) & 0x00FF00) >> 8))/255.0 \
                                             blue:((float)(v & 0x0000FF))/255.0 \
                                            alpha:a]


// 定义通用颜色
#define kBlackColor           [UIColor blackColor]
#define kDarkGrayColor      [UIColor darkGrayColor]
#define kLightGrayColor     [UIColor lightGrayColor]
#define kWhiteColor           [UIColor whiteColor]
#define kGrayColor            [UIColor grayColor]
#define kRedColor             [UIColor redColor]
#define kGreenColor         [UIColor greenColor]
#define kBlueColor          [UIColor blueColor]
#define kCyanColor          [UIColor cyanColor]
#define kYellowColor        [UIColor yellowColor]
#define kMagentaColor       [UIColor magentaColor]
#define kOrangeColor        [UIColor orangeColor]
#define kPurpleColor        [UIColor purpleColor]
#define kClearColor         [UIColor clearColor]

#define kRandomFlatColor    [UIColor randomFlatColor]

///获取RGB实现
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// 1> 灰色系:灰50 ~ 灰98
#define Color_Grey98 RGB(250, 250, 250)
#define Color_Grey97 RGB(247, 247, 247) //所有View 默认背景颜色
#define Color_Grey92 RGB(235, 235, 235)
#define Color_Grey86 RGB(219, 219, 219)
#define Color_Grey80 RGB(204, 204, 204)
#define Color_Grey50 RGB(128, 128, 128)

#define Color_MainBg  RGB(249, 110, 34)///主题背景色(橙色(深))

#define Color_Main HexRGB(0xdd4338)//主色(当前选中及移动下划线)_B
#define Color_Whiter  [UIColor whiteColor]//view默认白色
#define Color_Assistant RGB(50, 109, 187)//副色(海蓝色)
#define Color_Red RGB(219,17,17)//红色_B
#define Color_RedA(alpha)  [RGB(219,17,17) colorWithAlphaComponent:alpha]//红色_B

#define Color_Black RGB(21, 22, 26)//主色(标题)文字黑色_B
#define Color_Grey RGB(180, 184, 204)//文字灰色
#define Color_GreyLight RGB(112, 115, 128)//文字淡灰色
#define Color_GreyLightA(alpha)  [RGB(112, 115, 128) colorWithAlphaComponent:alpha]//文字淡灰色

#define Color_Orange RGB(249, 110, 34)//橙色主题
#define Color_Blue RGB(129, 143, 164)//文字蓝色

#define Color_Yellow RGB(187, 134, 50)//文字黄色


#endif /* ColorsMacro_h */
