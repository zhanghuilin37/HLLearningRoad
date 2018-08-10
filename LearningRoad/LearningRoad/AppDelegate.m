//
//  AppDelegate.m
//  LearningRoad
//
//  Created by Zhl on 2017/6/1.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import "AppDelegate.h"
#import "HLTabbarController.h"
#import "GuidePageViewCtrl.h"
#import "UserManager.h"
#import "GestureSettingViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:NeedDisPlayGuidePage]) {
        HLTabbarController *tabCtrl = [[HLTabbarController alloc] init];
        self.window.rootViewController = tabCtrl;
    }else{
        [defaults setObject:[NSNumber numberWithBool:NO] forKey:NeedDisPlayGuidePage];
        [defaults synchronize];
        GuidePageViewCtrl *ctrl = [[GuidePageViewCtrl alloc] init];
        __weak AppDelegate *this = self;
        [ctrl setGuideComplete:^(BOOL flag) {
            if (flag) {
                HLTabbarController *tabCtrl = [[HLTabbarController alloc] init];
                this.window.rootViewController = tabCtrl;
            }
        }];
        self.window.rootViewController = ctrl;
    }
    NSLog(@"123");
    NSLog(@"456");
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    UITabBarController *tabbarController = (UITabBarController*)self.window.rootViewController;
    if (tabbarController.selectedIndex == 2&&[[UserManager sharedInstance] getLoginUser].isGestureLock) {
        GestureSettingViewController *vc = [[GestureSettingViewController alloc] init];
        vc.type = 0;
        [self.window.rootViewController presentViewController:vc animated:YES completion:^{
            
        }];
    }
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {

    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
