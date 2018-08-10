//
//  GestureSettingViewController.m
//  demo
//
//  Created by Zhl on 16/10/24.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import "GestureSettingViewController.h"
#import "UserManager.h"
@interface GestureSettingViewController ()<HLGestureLockViewDelegate>

@end

@implementation GestureSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavItemWithImage:@"navback" isLeft:YES Target:self Sel:@selector(leftClick:)];
    if ([[UserManager sharedInstance] getLoginUser].isGestureLock) {
        self.title = @"重置手势";
    }else{
        self.title = @"设置手势";
    }
    self.view.backgroundColor = rgb(100, 100, 100, 1);
    UILabel *label = [[UILabel alloc] initWithFrame:ccr(20, 40, SCREEN_WIDTH-40, 40) text:@"" font:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor]];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    //gesture
    CGFloat x,y,w,h;
    x = 20,  w = SCREEN_WIDTH-2*x,   h = w,   y = (SCREEN_HEIGHT-h)/2.0;
    HLGestureLockView *gesture = [[HLGestureLockView alloc] initWithFrame:ccr(x, y, w, h)];
    gesture.delegate = self;
    if (self.type == 0) {//输入密码
        gesture.isSetPs = NO;
        gesture.state = HLGestureLockViewInputStateSetPS;
        label.text = @"请输入密码";
    }else{//设置密码
        gesture.isSetPs = YES;
        gesture.state = HLGestureLockViewInputStateSetPS;
        label.text = @"请设置密码";
    }
    __weak UILabel *weakLabel = label;
    [gesture setGestureLockState:^(HLGestureLockViewInputState state) {
        if (state == HLGestureLockViewInputStateSetPS) {
            weakLabel.text = @"请再次输入密码";
        }else if (state == HLGestureLockViewInputStateSetPSConfirm){
            weakLabel.text = @"设置成功";
        }else if(state == HLGestureLockViewInputStateInputPs){
            weakLabel.text = @"请输入密码";
        }
    }];
    [self.view addSubview:gesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)hlGestureLockView:(HLGestureLockView *)hlGLView didSettedPassowrd:(NSString *)passowrdStr{
    UserManager *manager = [UserManager sharedInstance];
    UserModel *model = [manager getLoginUser];
    model.isGestureLock = YES;
    model.gesturePsword = passowrdStr;
    [manager setLoginUser:model];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)hlGestureLockView:(HLGestureLockView *)hlGLView didInputPassowrd:(NSString *)inputStr{
    UserManager *manager = [UserManager sharedInstance];
    UserModel *model = [manager getLoginUser];
    if ([model.gesturePsword isEqualToString:inputStr]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [LRTools hl_showAlertViewWithString:@"密码输入错误请重新输入"];
    }
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
