//
//  LRTools.h
//  demo
//
//  Created by Zhl on 16/7/1.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LRTools : NSObject
/**
 *  判断系统版本号
 */
+(BOOL)hl_isIOS7OrLater;
/**
 *  获取DocumentPath
 */
+(NSString*)hl_getDocumentPath;
/**
 *  通过事件响应者链获取视图的控制器
 */
+(UIViewController *)hl_getViewControllerWithView:(UIView *)view;
/**
 *  获取字母表数组
 */
+(NSArray *)hl_getAlphaBetNumbers;
/**
 *  获取当前控制器
 */
+(UINavigationController *)hl_getCurrentNav;

+(NSString *)hl_decodeFromPercentEscapeString:(NSString *) input;
#pragma mark ------------------------------------------字符串处理
//+(NSString*)getClearWebUrl;
/**
 *  生成前后两种颜色的属性文本
 */
+(NSAttributedString*)hl_manageStr:(NSString*)str WithFirstColor:(UIColor*)firstColor andSecondColor:(UIColor *)secondColor andSeparateIndex:(NSInteger)index;
/**
 *  获取字符串的Size
 */
+(CGSize)hl_getFontSizeWithString:(NSString *)words font:(UIFont *)font constrainSize:(CGSize)cSize;
/**
 *  MD5加密
 */
+(NSString *)hl_getMD5StringWithStamp:(NSString *)stamp token:(NSMutableString *)token;
+(NSString *)hl_md5:(NSString *)str;
/**
 *  通过字典生成 带等号的字符串
 */
+(NSString *)hl_jsonEqualWithDic:(NSDictionary *)dic;
/**
 *  三位一个，加逗号
 */
+(NSString *)hl_countNumAndChangeformat:(NSString *)num;
/**
 *  去掉换行符
 */
+(NSString *)hl_replaceBRString:(NSString *)url;

/**
 *  手机号码验证
 */
+(BOOL)hl_validateMobile:(NSString *)mobile;

/**
 *  身份证号
 */
+(BOOL) hl_validateIdentityCard: (NSString *)identityCard;
/**
 *  判断输入字符是否在26个字母里
 */
+(BOOL)hl_isAlphabetContainsChar:(NSString *)str;
/**
 *  汉字转拼音
 */
+(NSString *)hl_pinyinWithText:(NSString *)hanziText;
/**
 *  弹出提示对话框
 */
+(void)hl_showAlertViewWithString:(NSString *)string;
/**
 *  是否包含指定字符（ios8以后有官方方法）
 */
+(BOOL)hl_containString:(NSString *)str sourceString:(NSString *)sourceString;

/**
 *  通过NSDictionary 生成 json串
 */
+(NSString*)hl_jsonStringWithPrettyPrint:(BOOL) prettyPrint dic:(NSDictionary *)dic;
#pragma mark ------------------------------------------多媒体
/**
 *  呼叫电话
 */
+(void)hl_callTelphoneWithNum:(NSString *)num;
/**
 *  发短信
 */
+(void)hl_sendMessageWithNum:(NSString *)num;
/**
 *  跳转浏览器
 */
+(void) hl_jumpSafariWithUrl:(NSString*) url;
#pragma mark ------------------------------------------ 图片
/**
 *  产生颜色图片
 */
+(UIImage *)hl_imageWithColor:(UIColor *)color;
/**
 *  1灰色  2  3  4 反色
 */
+(UIImage*) hl_grayscale:(UIImage*)anImage type:(char)type;
/**
 *  生成新尺寸图片
 */
+(UIImage*) hl_OriginImage:(UIImage *)image scaleToSize:(CGSize)size;

#pragma mark ------------------------------------------ 颜色
/**
 *  获取随机颜色
 */
+(UIColor *)hl_colorWithRandom;
/**
 *  十六进制颜色转换成
 */
+(UIColor *)hl_colorWithHexString:(NSString *)stringToConvert;

#pragma mark ------------------------------------------ Layer

/**
 *  创建矩形渐变图层
 */
- (CALayer*)hl_getGradientLayerWithFrame:(CGRect)frame StartColor:(UIColor *)startColor endColor:(UIColor*)endColor andKind:(GradientLayerKind)kind;

/**
 *  在View上添加虚线
 */
+(void)drawLineInView:(UIView*)view fromPoint:(CGPoint)point lineSize:(CGSize)size isHorizontal:(BOOL)isHorizontal;
#pragma mark ------------------------------------------ Time
/**
 *  获取时间戳
 */
+(NSString *)hl_getStamp;
/**
 *  两个日期之间相差的天数
 */
+(NSInteger)hl_numberOfDaysBetween:(NSString *)start and:(NSString *)end;
/**
 *  根据时间字符串返回与当前时间的时间差
 */
+(NSTimeInterval)hl_intervalSinceNow:(NSString *)theDate;
/**
 *  获取当前时间字符串
 */
+(NSString *)hl_getCurrentTimeWithFormatStr:(NSString*)formatStr;
/**
 *  获取当前日期
 */
+(NSDate *)hl_getCurrentDate;
/**
 *  时间字符串转日期
 */
+(NSDate *)hl_dateWithString:(NSString *)dateString;

#pragma mark - 设置view的圆角

//通过设置layer 切圆角，是最常用的，也是最耗性能的
+ (void)setLayerCutCirculayWithView:(UIView *) view roundedCornersSize:(CGFloat )cornersSize;

// 通过layer和bezierPath 设置圆角
+ (void)setLayerAndBezierPathCutCircularWithView:(UIView *) view roundedCornersSize:(CGFloat )cornersSize;

/**
 *  通过Graphics 和 BezierPath 设置圆角（推荐）
 */
+ (void)setGraphicsCutCirculayWithView:(UIImageView *) view roundedCornersSize:(CGFloat )cornersSize;

#pragma mark ---------------------------------------------快捷创建控件
+(UIButton *)hl_buttonWithType:(UIButtonType)type frame:(CGRect)frame title:(NSString *)title target:(NSObject*)objc action:(SEL)sel event:(UIControlEvents)event;
@end
