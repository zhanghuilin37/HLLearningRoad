//
//  HLAlertDemoViewController.m
//  LearningRoad
//
//  Created by 张会林 on 2018/7/31.
//  Copyright © 2018年 LearningRoad. All rights reserved.
//

#import "HLAlertDemoViewController.h"
#import "HLUIKit_Factory.h"
#import "HLAlertView.h"
#import "HLTestAlertView.h"

@interface HLAlertDemoViewController ()<HLAlertViewDelegate,HLBaseAlertViewDelegate>
@property (nonatomic,strong)   HLAlertView * hlAlertView;
@property (nonatomic,strong)   HLTestAlertView * testAlertView;
@end

@implementation HLAlertDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"HLAlertDemo";
    _hlAlertView = [[HLAlertView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2.0-150, SCREEN_HEIGHT/2.0-250, 300, 500) delegate:self btnHeight:30 cancleBtnTitle:@"取消" otherBtnTitle:@[@"确定"]];
    
    _testAlertView = [[HLTestAlertView alloc] initWithDelegate:self Tag:1243];
    [_testAlertView addTapSpaceGesture];
    UIButton *btn = [HLUIKit_Factory create_UIButton_WithButtonType:UIButtonTypeCustom frame:CGRectMake(100, 20, 100, 60) normalTitleColor:[UIColor redColor] normalFont:[UIFont systemFontOfSize:16] normalTitle:@"弹框一"];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor grayColor];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [HLUIKit_Factory create_UIButton_WithButtonType:UIButtonTypeCustom frame:CGRectMake(100, 100, 100, 60) normalTitleColor:[UIColor redColor] normalFont:[UIFont systemFontOfSize:16] normalTitle:@"弹框二"];
    [btn2 addTarget:self action:@selector(btn2Clicked) forControlEvents:UIControlEventTouchUpInside];
    btn2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:btn2];

    // Do any additional setup after loading the view.
}
- (void)btnClicked{
    [_hlAlertView alertShow];
}
- (void)btn2Clicked{
    [_testAlertView show];
}
- (void)hlAlertView:(HLAlertView *)alertView didClickedBtnAtIndex:(NSInteger)index{
    NSLog(@"hlalertView clicked index:%ld",(long)index);
}
- (void)hlAlertView:(HLBaseAlertView *)alertView clickedInedx:(NSInteger)index{
    if (index == 0) {
        NSLog(@"Cancel");
    }else if (index == 1){
        NSLog(@"Confirm");
        [alertView hidden];
    }
}
- (void)hlAlertViewTapSpace{
    NSLog(@"TapSpace");
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
