//
//  Const.h
//  BaiDuDemo
//
//  Created by CH10 on 16/1/15.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#ifndef Const_h
#define Const_h
#pragma mark ------------------------------屏幕适配
//屏幕尺寸



#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

//屏幕适配比例
#define PPL_SCREEN_SCALE \
({\
CGFloat screenScale = 1.0; \
if(IPHONE6){ \
screenScale = 1.17;\
} else if (IPHONE6PLUS){ \
screenScale = 1.2937;\
}\
screenScale;\
})

//坐标和size做适配
#define CT_SCREEN_FIT(d) (PPL_SCREEN_SCALE * d)
//CGRect
#define ccr(x,y,w,h) CGRectMake(x,y,w,h)
#define CT_CCR_FIT(x,y,w,h) CGRectMake(PPL_SCREEN_SCALE*x,PPL_SCREEN_SCALE*y,PPL_SCREEN_SCALE*w,PPL_SCREEN_SCALE*h)

#pragma mark ---------------------------------------文字适配
//文字大小适配比例
#define PPL_FONT_SCALE \
({\
CGFloat fontScale = 1.0;\
if(IPHONE6){ \
fontScale = 1.05;\
} else if (IPHONE6PLUS){\
fontScale = 1.15;\
}\
fontScale;\
})
#define CT_FONT_FIT(f) [UIFont systemFontOfSize:(f * PPL_FONT_SCALE)]

#pragma mark ----------------------------------------系统版本
//屏幕
#define IPHONE5 (SCREEN_HEIGHT == 568)
#define IPHONE4 (SCREEN_HEIGHT == 480)
#define IPHONE6 (SCREEN_HEIGHT == 667)
#define IPHONE6PLUS (SCREEN_HEIGHT == 736)
//获取设备系统版本
#define KDeviceOSVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#define IOS_9_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define IOS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IOS_7_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS_6_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
//应用版本号
#define LR_VERSION_CODE @"1.0"

#pragma mark -----------------------------------------第三方Key
//百度地图appkey
#define AppKey @"jurKRt2mojMgol3Wr6hxmURx"
//shareSDK AppKey 和 AppSecret
#define ShareAppKey @"d3a1f3169d88"
#define ShareSecret @"adb8904a2a490b8f99f11efdf77505da"
//新浪
#define ShareSinaAppKey @"3528274000"
#define ShareSinaAppSecret @"707c1438fe5b6693bbc07b426146147e"
//qq
#define ShareQQAppID @"1105131742"
#define ShareQQAppKey @"6EAgayeLOrbnfz0P"

#pragma mark ------------------------------------------沙盒文件路径
//DocumentPath
#define DocumentPath(path)  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] \
stringByAppendingPathComponent:path]
//CachePath
#define CachePath(path)     [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] \
stringByAppendingPathComponent:path]

#pragma mark ------------------------------------------颜色

#define kAppDelegate  ((AppDelegate *)[UIApplication sharedApplication].delegate)
//三色值
#define rgb(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#pragma mark -------------------------------------------其他
//正确的 1 像素写法
#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)

//安全释放
#define Release(obj) [obj release];obj = nil;
//NSLog
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif

typedef enum {
    GradientLayerKindLeftRight = 2000,
    GradientLayerKindUpDown,
    GradientLayerKindLBRT,//左下-右上
    GradientLayerKindLTRB //左上-右下
}GradientLayerKind;
#endif /* Const_h */
