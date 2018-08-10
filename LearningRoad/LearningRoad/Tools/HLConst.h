
//
//  HLConst.h
//  demo
//
//  Created by Zhl on 2017/3/27.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#ifndef HLConst_h
#define HLConst_h


//获取屏幕size 宽 高 支持横屏
#if __IPHONE_OS_VERSION_MAX_ALLOWED>=80000//当前xcode支持ios8及以上

#define SCREEN_WIDTH ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.height)
#define SCREEN_SIZE ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale, [UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale):[UIScreen mainScreen].bounds.size)

#else

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_SIZE [[UIScreen mainScreen] bounds].size
#endif

//显示引导页
#define NeedDisPlayGuidePage @"NeedDisPlayGuidePage"
//获取通知中心
#define LRNotificationCenter [NSNotificationCenter defaultCenter]

//设置随机颜色
#define LRRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
//设置RGBA颜色
#define RGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]
//设置RGB颜色
#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:1.0]
//自定义Log
#ifdef DEBUG
#define LRLog(...) NSLog(@"%s 第%d行\n%@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define LRLog(...) {}
#define NSLog(...) {}
#endif

//设置圆角和边框
#define LRViewBorderRadius(view,radius,width,color)\
view.layer.cornerRadius = radius;\
view.layer.masksToBounds = YES;\
view.layer.borderWidth = width;\
view.layer.borderColor = color.CGColor;



//获取temp
#define kPathTemp NSTemporaryDirectory()
//获取沙盒Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
#define kdeviceWidth [UIScreen mainScreen].bounds.size.width
#define kdeviceHeight [UIScreen mainScreen].bounds.size.height
#define IPHONEX (kdeviceHeight == 812)
/**
 *   电池栏高度
 */
#define k_StatusBar_H [[UIApplication sharedApplication] statusBarFrame].size.height

/**
 *   导航栏高度
 */
#define k_NavBar_H  (44 + k_StatusBar_H)

/**
 *   底部UItabbar高度
 */
#define k_TabBar_H 49

/**
 *   iPhone X home 安全区域高度
 */
#define k_X_HomeSafeArea_H (IPHONEX?34:0)

#endif /* HLConst_h */
































