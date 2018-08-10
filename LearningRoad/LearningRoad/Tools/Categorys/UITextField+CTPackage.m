//
//  UITextField+CTPackage.m
//  LearningRoad
//
//  Created by Zhl on 16/6/30.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "UITextField+CTPackage.h"

@implementation UITextField (CTPackage)
-(instancetype)initWithFrame:(CGRect)frame hasToolBar:(BOOL)hasToolBar hasDelete:(BOOL)hasDeleteBtn{
    self = [[UITextField alloc] initWithFrame:frame];
    if (self) {
        if (hasToolBar) {
            UIToolbar *tool = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
            //        tool.layer.borderColor = rgb(220, 50, 50, 1).CGColor;
            //        tool.layer.borderWidth = 0.5;
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            
            button.titleLabel.font = [UIFont systemFontOfSize:20];
            button.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
            [button addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:@"确定" forState:UIControlStateNormal];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            UIBarButtonItem *sureItem = [[UIBarButtonItem alloc] initWithCustomView:button];
            
            UIBarButtonItem *spaceItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            [spaceItem1 setWidth:-16];
            tool.items =@[spaceItem1,sureItem];
            self.inputAccessoryView =tool;
        }
        if (hasDeleteBtn) {
            UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, self.height)];
            
            UIImage *img = [UIImage imageNamed:@"login_cancle"];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:img forState:UIControlStateNormal];
            btn.frame = CGRectMake(0, (rightView.height-img.size.height)/2.0, img.size.width, img.size.height);
            [rightView addSubview:btn];
            [btn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
            self.rightView = rightView;
            self.rightViewMode = UITextFieldViewModeAlways;
        }
    }
    return self;
}
-(void)setLeftViewWithImgName:(NSString *)leftImgName{
    UIImage *img = [UIImage imageNamed:leftImgName];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, self.height)];

    
    UIImageView *imgV = [[UIImageView alloc] initWithImage:img];
    imgV.frame = CGRectMake((leftView.width-img.size.width)/2, (leftView.height-img.size.height)/2.0, img.size.width, img.size.height);
    [leftView addSubview:imgV];
    
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;

}
-(void)setRightViewWithImgName:(NSString *)rightImgName{
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, self.height)];
    
    UIImage *img = [UIImage imageNamed:rightImgName];
    UIImageView *imgV = [[UIImageView alloc] initWithImage:img];
    imgV.frame = CGRectMake(0, (rightView.height-img.size.height)/2.0, img.size.width, img.size.height);
    [rightView addSubview:imgV];
    
    self.rightView = rightView;
    self.rightViewMode = UITextFieldViewModeAlways;
    
}



-(void)sureBtnClick:(UIButton*)btn{
    [self resignFirstResponder];
}
-(void)deleteBtnClick{
    self.text = @"";
}

@end
