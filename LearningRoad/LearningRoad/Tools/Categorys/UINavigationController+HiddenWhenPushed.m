//
//  UINavigationController+HiddenWhenPushed.m
//  demo
//
//  Created by Zhl on 16/8/25.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import "UINavigationController+HiddenWhenPushed.h"
#import "AppDelegate.h"
#import <objc/runtime.h>
@implementation UINavigationController (HiddenWhenPushed)

+ (void)load
{
    swizzleMethod([self class], @selector(pushViewController:animated:), @selector(swizzled_pushViewController:animated:));
}

- (void)swizzled_pushViewController:(UIViewController *)vc
                           animated:(BOOL)animated
{
    vc.hidesBottomBarWhenPushed = [self isHideBottomBar:vc];
    [self swizzled_pushViewController:vc animated:animated];
}
- (BOOL)isHideBottomBar:(UIViewController *)vc
{
    BOOL haveVc = NO;
//    if (kAppDelegate.window.rootViewController!=nil&&![kAppDelegate.window.rootViewController isKindOfClass:[UITabBarController class]]) {
//        
//    }
    
    if ([kAppDelegate.window.rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBar = (UITabBarController *)kAppDelegate.window.rootViewController;
        
        haveVc = (tabBar.viewControllers.count > 0 ? YES : NO); // tabbar没有viewControllers时证明还没加入controller，目前只有主界面在创建
        for (UINavigationController *na in tabBar.viewControllers) {
            if ([vc isKindOfClass:[na.topViewController class]]) {
                haveVc = NO;
                break;
            }else{
                haveVc = YES;
            }
        }
    }else{
        haveVc = NO;
    }

    return haveVc;
}

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector)  {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
@end
