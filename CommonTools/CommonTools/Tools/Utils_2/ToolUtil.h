//
//  ToolUtil.h
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/11/18.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "EnumUtil.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToolUtil : NSObject

+ (NSString *)getCachesSize;
+ (void)removeCache:(void (^ __nullable)(BOOL finished))completion;

#pragma mark -
/// 银行卡号加*
+ (NSString *)getSecretBankNumWithBankNum:(NSString *_Nullable)bankNum;
/// 身份证号加*
+ (NSString *)getSecretCardIDWitCardID:(NSString *_Nullable)cardID;
/// 手机号加*
+ (NSString *)getSecretMobileNumWitMobileNum:(NSString *_Nullable)mobileNum;

/// 校验身份证号码是否正确 返回BOOL值
/// @param idCardString idCardString
+ (BOOL)verifyIDCardString:(NSString *_Nullable)idCardString;
/// 校验手机号格式
/// @param mobile mobile
+ (BOOL)valifyMobile:(NSString *)mobile;
/// 校验输入价格
/// @param price price
+ (BOOL)valifyInputPrice:(NSString *)price;
/// 判断是否为当前用户
/// @param userID userID
+ (BOOL) isEqualOwner:(id)userID;
/// 判断是否为刘海屏
+ (BOOL)isPhoneX;

#pragma mark -
+ (NSString *)html5StringWithContent:(NSString *_Nullable)content withTitle:(NSString *_Nullable)title;

/// 将服务器存储的图片链接拼接成URLStr
/// @param urlStr urlStr
+ (NSString *)getNetImageURLStringWith:(NSString *)urlStr;

#pragma mark -
/**
 选择图片/拍照并上传

 @param parentController 展示图片选择controller/相机的父Controller
 @param photoOfMax 最大相片数量/最大拍照数量
 @param type AMImageSelectedMeidaType媒体类型
 @param uploadType 上传类型,当uploadType<0时不上传
 @param completion 返回值，当uploadType<0时返回的是图片数组/nil，否则返回图片Url数组/nil
 */
+ (void)showInController:(UIViewController *)parentController photoOfMax:(NSInteger)photoOfMax withType:(AMImageSelectedMeidaType)type uploadType:(NSInteger)uploadType completion:(void (^ __nullable)(NSArray *_Nullable images))completion;


/// 选择图片/拍照、不上传
/// @param parentController 展示图片选择controller/相机的父Controller
/// @param photoOfMax 最大相片数量/最大拍照数量
/// @param type AMImageSelectedMeidaType媒体类型
/// @param completion 返回值，当uploadType<0时返回的是图片数组/nil，否则返回图片Url数组/nil
+ (void)showInControllerWithoutUpload:(UIViewController *)parentController photoOfMax:(NSInteger)photoOfMax withType:(AMImageSelectedMeidaType)type completion:(void (^ __nullable)(NSArray *_Nullable images))completion;



/// Fankkly自定义方法
/// @param parentController <#parentController description#>
/// @param photoOfMax <#photoOfMax description#>
/// @param type <#type description#>
/// @param uploadType <#uploadType description#>
/// @param completion <#completion description#>
+ (void)FK_showInController:(UIViewController *)parentController photoOfMax:(NSInteger)photoOfMax withType:(AMImageSelectedMeidaType)type uploadType:(NSInteger)uploadType completion:(void (^ __nullable)(NSArray *_Nullable images))completion;
/**
 上传图片

 @param imageArray 图片数组
 @param uploadType 上传类型,
 @param completion 返回值，图片Url数组
 */
+ (void)uploadImgs:(NSArray *)imageArray uploadType:(NSInteger)uploadType completion:(void (^ __nullable)(NSArray *_Nullable imageURls))completion;

/**
 上传图片

 @param imageArray 图片数组
 @param uploadType 上传类型,
 @param completion 返回值，图片Url数组
 @param fail 返回值，错误
 */
+ (void)uploadImgs:(NSArray *)imageArray uploadType:(NSInteger)uploadType completion:(void (^ __nullable)(NSArray *_Nullable imageURls))completion fail:(void (^ __nullable)(NSString *errorMsg))fail;

#pragma mark - JAVA图片上传
+ (void)JAVA_uploadImgs:(NSArray *)imageArray uploadType:(NSInteger)uploadType completion:(void (^ __nullable)(NSArray *_Nullable imageURls))completion;

+ (void)JAVA_uploadImgs:(NSArray *)imageArray uploadType:(NSInteger)uploadType completion:(void (^ __nullable)(NSArray *_Nullable imageURls))completion fail:(void (^ _Nullable)(NSString * _Nonnull))fail;






#pragma mark -
/**
 判断字符串是否为不空

 @return yes: 字符串不为空 no：字符串为空
 */
+ (BOOL)isEqualToNonNull:(id)value;
/**
 当字符串为空时返回@""

 @return [self class]/@""
 */
+ (NSString *)isEqualToNonNullKong:(id)value;

/**
  当字符串为空时返回@"暂无"

 @return [self class]/@""
 */
+ (NSString *)isEqualToNonNullForZanWu:(id)value;
/**
用replace替换当前字符串

@param replace 替换的字符串
@return [self class]/replace
*/
+ (NSString *)isEqualToNonNull:(id)value replace:(id _Nullable)replace;


/**
转换金额显示格式 123,456,789

@param string 原始字符串
@return 转换后的金额字符串
*/
+ (NSString *)stringToDealMoneyString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
