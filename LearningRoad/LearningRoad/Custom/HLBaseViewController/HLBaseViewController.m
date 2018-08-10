//
//  HLBaseViewController.m
//  BaiDuDemo
//
//  Created by CH10 on 16/1/15.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "HLBaseViewController.h"
#import <objc/runtime.h>
@interface HLBaseViewController ()

@end

@implementation HLBaseViewController
-(void)dealloc{
    NSLog(@"%@ is dealloced",NSStringFromClass([self class]));
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [LRTools hl_colorWithHexString:@"F6F6F6"];
    self.view.backgroundColor = HLCom_Color_mainBgView;
    self.navigationController.navigationBar.translucent = NO;
    [self setNavBgWithBgimage:@"navbg2"];
}
-(void)initUI{
    
}
-(void)setBackNav{
    [self setNavBgWithBgimage:@"navbg2"];
    self.title = @"学路";
}
//设置Title
- (void)setTitle:(NSString *)title
{
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.frame = CGRectMake(0, 0, 10, 100);
    [titleButton setTitle:title forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [titleButton addTarget:self action:@selector(titleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
}

-(void)titleBtnClick{
    
}
-(void)setNavTitle{

    self.navigationController.navigationBar.titleTextAttributes =@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]};
}
-(void)leftClick:(UIButton*)btn{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightClick:(UIButton*)btn{
    
}
-(void)setNavItemWithImage:(NSString *)imageName isLeft:(BOOL)isLeft Target:(NSObject*)objc Sel:(SEL)selector{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 44);
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:objc action:selector forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    if (isLeft) {
        button.tag = 2016;
        self.navigationItem.leftBarButtonItem = item;
    }else{
        button.tag = 2016+1;
        self.navigationItem.rightBarButtonItem = item;
    }
}
-(void)setNavItemWithTitle:(NSString*)title Color:(UIColor*)color IsLeft:(BOOL)isLeft Target:(NSObject*)objc Sel:(SEL)selector{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 44);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button addTarget:objc action:selector forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    if (isLeft) {
        button.tag = 2016;
        self.navigationItem.leftBarButtonItem = item;
    }else{
        button.tag = 2016+1;
        self.navigationItem.rightBarButtonItem = item;
    }

}
-(void)setNavBgWithBgimage:(NSString*)bgimgName{
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navbg2"]];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:bgimgName]forBarMetrics:UIBarMetricsDefault];
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
