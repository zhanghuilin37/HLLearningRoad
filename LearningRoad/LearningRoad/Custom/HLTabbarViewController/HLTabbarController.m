//
//  HLTabbarController.m
//  HLTabbarDemo
//
//  Created by Zhl on 2017/3/3.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import "HLTabbarController.h"
#import "AppDelegate.h"
#import "UserManager.h"
#import "LoginViewController.h"
@interface HLTabbarController ()<UINavigationControllerDelegate,UITabBarControllerDelegate>

@end

@implementation HLTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    HLTabbarDataSource *dataSource = [HLTabbarDataSource sharedInstance];
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    for (HLTabbarItemModel *model in dataSource.dataArr) {
        
        UIViewController *vc = [[NSClassFromString(model.className) alloc] init];
        
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
        
        [viewControllers addObject:nvc];
    }
    
    self.viewControllers = viewControllers;
    //这样可以避免push控制器时隐藏tabbar出问题
    [self.tabBar addSubview:self.hlTabBar];
    self.selectedIndex = 0;
}
-(void)setSelectedIndex:(NSUInteger)selectedIndex{
    [super setSelectedIndex:selectedIndex];
    self.hlTabBar.selectedIndex = selectedIndex;
}
-(HLTabbar *)hlTabBar{
    if (_hlTabBar == nil) {
        
        _hlTabBar = [HLTabbar createHLTabbarWithFrame:self.tabBar.bounds andArr:[HLTabbarDataSource sharedInstance].dataArr];
        _hlTabBar.selectedItemColor = [UIColor redColor];
        _hlTabBar.tintColor = [UIColor grayColor];
        _hlTabBar.backgroundImgV.backgroundColor = [UIColor whiteColor];
        __weak HLTabbarController *this = self;
        [_hlTabBar setTabbarClickedAtIndex:^(NSInteger index) {
            if (index<this.viewControllers.count) {
                this.selectedViewController = [this.viewControllers objectAtIndex:index];
                [this tabBarController:this didSelectViewController:[this.viewControllers objectAtIndex:index]];
            }
        }];
    }
    return _hlTabBar;
}



- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.rootNav = (UINavigationController *)[tabBarController.viewControllers objectAtIndex:tabBarController.selectedIndex];
    if (![[UserManager sharedInstance] getLoginUser].isLogin) {
        if (tabBarController.selectedIndex==2 ) {
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:loginVC];
            [[LRTools hl_getCurrentNav] presentViewController:nvc animated:YES completion:nil];
        }

    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
