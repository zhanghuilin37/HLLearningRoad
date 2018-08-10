//
//  LoginViewController.m
//  demo
//
//  Created by Zhl on 16/10/8.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
@interface LoginViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)UIImageView *userImgV;
@property (nonatomic,strong)UITextField *userNameTextField;
@property (nonatomic,strong)UITextField *paswordTextField;
@property (nonatomic,strong)UIButton *loginBtn;
@property (nonatomic,strong)UIButton *registerBtn;
@property (nonatomic,strong)UIButton *forgetPasswordBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavItemWithImage:@"navback" isLeft:YES Target:self Sel:@selector(leftClick:)];
    [self.view addSubview:self.userImgV];
    [self.view addSubview:self.userNameTextField];
    [self.view addSubview:self.paswordTextField];
    [self.view addSubview:self.registerBtn];
    [self.view addSubview:self.forgetPasswordBtn];
    [self.view addSubview:self.loginBtn];
    UserManager *userManager = [UserManager sharedInstance];
    if ([userManager getLoginUser].user.userName.length) {
        self.userNameTextField.text = [userManager getLoginUser].user.userName;
    }
    if ([userManager getLoginUser].isGestureLock) {
        
    }
}
-(void)viewWillAppear:(BOOL)animated{
    UserManager *userManager = [UserManager sharedInstance];
    if ([userManager getLoginUser].isLogin) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma mark ----------------------------------- Actions
-(void)leftClick:(UIButton*)btn{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)loginBtnClick{
    [self loginHttpRequest];
    
}
-(void)registerBtnClick{
    NSLog(@"注册");
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}
-(void)forgetPasswordBtnClick{
    NSLog(@"忘记密码");
}
#pragma mark ----------------------------------- HttpRequest
-(void)loginHttpRequest{
    //调用登录接口
    
    //登录成功
    User *loginUser = [[User alloc] init];
    loginUser.userName = self.userNameTextField.text;
    loginUser.password = self.paswordTextField.text;
    [self saveToLocalWithLoginUser:loginUser];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark ----------------------------------- setter And getter methods
-(UIImageView *)userImgV{
    if (_userImgV == nil) {
        //用户头像
        CGFloat x,y,w,h;
        UIImage *img = [UIImage imageNamed:@"w_yueliang"];
        w = 80,   h = 80,  x = (SCREEN_WIDTH-w)/2.0,  y = 40;
        UIImageView *imgV = [[UIImageView alloc] initWithImage:img];
        imgV.frame = ccr(x, y, w, h);
        imgV.layer.cornerRadius  = w/2.0;
        imgV.layer.masksToBounds = YES;
        imgV.layer.borderWidth   = 3;
        imgV.layer.borderColor   = rgb(230, 230, 230, 1).CGColor;
        _userImgV = imgV;
    }
    return _userImgV;
}
-(UITextField *)userNameTextField{
    if (_userNameTextField == nil) {
        //用户名
        CGFloat x,y,w,h;
        x = 50,  y = self.userImgV.bottom+40,  w = SCREEN_WIDTH-x*2,   h = 40;
        UITextField *textField = [[UITextField alloc] initWithFrame:ccr(x, y, w, h) hasToolBar:YES hasDelete:YES];
        textField.textAlignment = NSTextAlignmentCenter;
        textField.clearButtonMode = UITextFieldViewModeAlways;
        textField.placeholder = @"请输入用户名";
        textField.delegate = self;
        textField.layer.cornerRadius  = 4;
        textField.layer.masksToBounds = YES;
        textField.layer.borderWidth   = 1;
        textField.layer.borderColor   = rgb(200, 200, 200, 1).CGColor;
        [textField setLeftViewWithImgName:@"login_icon_user"];
        _userNameTextField = textField;
    }
    return _userNameTextField;
}
-(UITextField*)paswordTextField{
    if (_paswordTextField == nil) {
        //密码
        CGFloat x,y,w,h;
        x = 50,  y = self.userNameTextField.bottom+30,  w = SCREEN_WIDTH-x*2,   h = 40;
        UITextField *textField = [[UITextField alloc] initWithFrame:ccr(x, y, w, h) hasToolBar:YES hasDelete:YES];
        [textField setLeftViewWithImgName:@"login_icon_lock"];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.textAlignment = NSTextAlignmentCenter;
        textField.placeholder = @"请输入密码";
        textField.keyboardType = UIKeyboardTypeASCIICapable;
        textField.secureTextEntry = YES;
        textField.delegate = self;
        textField.layer.cornerRadius  = 4;
        textField.layer.masksToBounds = YES;
        textField.layer.borderWidth   = 1;
        textField.layer.borderColor   = rgb(200, 200, 200, 1).CGColor;
        _paswordTextField = textField;
    }
    return _paswordTextField;
}
-(UIButton *)loginBtn{
    if (_loginBtn == nil) {
        //登录按钮
        CGFloat x,y,w,h;
        
        w = self.userNameTextField.width,   h = 40,x = (SCREEN_WIDTH-w)/2.0,  y = self.registerBtn.bottom+20;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(x, y, w, h);
        [btn setTitle:@"登    录" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:20];
        btn.backgroundColor = [UIColor colorWithRed:250/256.0 green:10/256.0 blue:10/256.0 alpha:1];
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _loginBtn = btn;
    }
    return _loginBtn;
}
-(UIButton *)registerBtn{
    if (_registerBtn == nil) {
        //注册按钮
        CGFloat x,y,w,h;
        x = self.userNameTextField.left,  y = self.paswordTextField.bottom+5,  w = 80,   h = 40;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(x, y, w, h);
        [btn setTitle:@"立即注册" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        CGSize size = [LRTools hl_getFontSizeWithString:@"立即注册" font:[UIFont systemFontOfSize:15] constrainSize:CGSizeMake(10000, 30000)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, w-size.width)];
        [btn setTitleColor:rgb(10, 50, 150, 1) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _registerBtn = btn;
    }
    return _registerBtn;
}
-(UIButton *)forgetPasswordBtn{
    if (_forgetPasswordBtn == nil) {
        //忘记密码按钮
        CGFloat x,y,w,h;
        w = 100,  x = self.userNameTextField.right-w,  y = self.paswordTextField.bottom+5,  h = 40;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(x, y, w, h);
        [btn setTitle:@"忘记密码" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        CGSize size = [LRTools hl_getFontSizeWithString:@"忘记密码" font:[UIFont systemFontOfSize:15] constrainSize:CGSizeMake(10000, 30000)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, w-size.width, 0, 0)];
        [btn setTitleColor:rgb(10, 50, 150, 1) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(forgetPasswordBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _forgetPasswordBtn = btn;
    }
    return _forgetPasswordBtn;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
