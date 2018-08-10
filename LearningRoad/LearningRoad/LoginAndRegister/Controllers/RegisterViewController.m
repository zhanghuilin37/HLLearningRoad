//
//  RegisterViewController.m
//  demo
//
//  Created by Zhl on 16/10/8.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import "RegisterViewController.h"
#import "UserManager.h"
#import "User.h"
@interface RegisterViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *userNameTextField;
@property(nonatomic,strong)UITextField *passwordTextField;
@property(nonatomic,strong)UITextField *confirmTextField;
@property(nonatomic,strong)UIButton *confirmBtn;
@end

@implementation RegisterViewController
#pragma mark -------------------------------------- life time
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addLeftLabel];
    [self.view addSubview:self.userNameTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.confirmTextField];
    [self.view addSubview:self.confirmBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark -------------------------------------- Actions
-(void)confirmBtnClick{
//    NSString *userName = self.userNameTextField.text;
//    NSString *password = self.passwordTextField.text;
//    NSString *confirmPassword = self.confirmTextField.text;
    if ([self testInfo]) {//符合要求则加密后调用注册接口
        [self registerHttpRequest];
    }
    
    
    
    
    NSLog(@"确认");
}
#pragma mark --------------------------------------http
//注册
-(void)registerHttpRequest{
    //加密
    
    //调用接口
    
    //上传成功后自动登录（返回User）
    //模拟注册成功返回的用户信息
    User *registerUser = [[User alloc] init];
    registerUser.userName = self.userNameTextField.text;
    registerUser.password = self.passwordTextField.text;
    [self saveToLocalWithLoginUser:registerUser];
    [self loginHttpRequest];
}
//登录
-(void)loginHttpRequest{
    //调用接口
    
    //
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -------------------------------------- setter and getter methods
-(UITextField *)userNameTextField{
    if (_userNameTextField == nil) {
        //昵称
        CGFloat x,y,w,h;
        x = 20+80,  y = 40,  w = SCREEN_WIDTH - 120,   h = 40;
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(x, y, w, h) hasToolBar:YES hasDelete:YES];
        textField.delegate = self;
        textField.layer.borderWidth = 1;
        textField.layer.borderColor = rgb(200, 200, 200, 1).CGColor;
        textField.layer.cornerRadius = 4;
        textField.layer.masksToBounds = YES;
        _userNameTextField = textField;
    }
    return _userNameTextField;
}
-(UITextField *)passwordTextField{
    if (_passwordTextField == nil) {
        //昵称
        CGFloat x,y,w,h;
        x = self.userNameTextField.left,  y = _userNameTextField.bottom+20,  w = self.userNameTextField.width,   h = self.userNameTextField.height;
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(x, y, w, h) hasToolBar:YES hasDelete:YES];
        textField.delegate = self;
        textField.layer.borderWidth = 1;
        textField.layer.borderColor = rgb(200, 200, 200, 1).CGColor;
        textField.layer.cornerRadius = 4;
        textField.layer.masksToBounds = YES;
        _passwordTextField = textField;
    }
    return _passwordTextField;
}
-(UITextField *)confirmTextField{
    if (_confirmTextField == nil) {
        //昵称
        CGFloat x,y,w,h;
        x = self.userNameTextField.left,  y = _passwordTextField.bottom+20,  w = self.userNameTextField.width,   h = self.userNameTextField.height;
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(x, y, w, h) hasToolBar:YES hasDelete:YES];
        textField.delegate = self;
        textField.layer.borderWidth = 1;
        textField.layer.borderColor = rgb(200, 200, 200, 1).CGColor;
        textField.layer.cornerRadius = 4;
        textField.layer.masksToBounds = YES;
        _confirmTextField = textField;
    }
    return _confirmTextField;
}
-(UIButton *)confirmBtn{
    if (_confirmBtn == nil) {
        //登录按钮
        CGFloat x,y,w,h;
        
        w = SCREEN_WIDTH-40,   h = 40,x = (SCREEN_WIDTH-w)/2.0,  y = self.confirmTextField.bottom+80;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(x, y, w, h);
        [btn setTitle:@"确       定" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:20];
        btn.backgroundColor = [UIColor colorWithRed:250/256.0 green:10/256.0 blue:10/256.0 alpha:1];
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _confirmBtn = btn;
    }
    return _confirmBtn;
}
#pragma mark - private Methods
-(void)addLeftLabel{
    NSArray *titles = @[@"请输入昵称:",@"请输入密码:",@"请确认密码:"];
    for (int i = 0; i<3; i++) {
        CGFloat x,y,w,h;
        x = 20,  y = 40+i*(self.userNameTextField.height+20),  w = 80,   h = 40;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h) text:[titles objectAtIndex:i] font:[UIFont systemFontOfSize:15] textColor:[UIColor blackColor]];
        [label adjustsFontSizeToFitWidth];
        [self.view addSubview:label];
    }
}
-(BOOL)testInfo{
    NSString *userName = self.userNameTextField.text;
    NSString *password = self.passwordTextField.text;
    NSString *confirmPassword = self.confirmTextField.text;
    if (userName.length==0) {
        [LRTools hl_showAlertViewWithString:@"用户名不能为空"];
        return NO;
    }
    if (userName.length>8){
        [LRTools hl_showAlertViewWithString:@"最多8位"];
        return NO;
    }
    //6-15
    if (password.length<6) {
        [LRTools hl_showAlertViewWithString:@"密码最少6位"];
        return NO;
    }
    if (password.length>15) {
        [LRTools hl_showAlertViewWithString:@"密码最多15位"];
        return NO;
    }
    if (![confirmPassword isEqualToString:password]) {
        [LRTools hl_showAlertViewWithString:@"两次密码输入不一致"];
        return NO;
    }
    return YES;
}
//注册成功后自动登录
-(void)autoLogin{

    //登录。。
}
//登录时保存数据到本地记录当前用户信息和登录状态
-(void)saveToLocalWithLoginUser:(User*)loginUser{
    
    UserModel *currentUser = [[UserModel alloc] init];
    currentUser.isLogin = YES;
    currentUser.user = loginUser;
    [[UserManager sharedInstance] setLoginUser:currentUser];
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
