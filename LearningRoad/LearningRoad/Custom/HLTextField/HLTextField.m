//
//  HLTextField.m
//  demo
//
//  Created by Zhl on 16/11/18.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import "HLTextField.h"

@implementation HLTextField


- (void)deleteBackward {
//    ！！！这里要调用super方法，要不然删不了东西
    [super deleteBackward];
    
    if ([self.hlTextFieldDelete respondsToSelector:@selector(hlTextFieldDeleteBackward:)]) {
        [self.hlTextFieldDelete hlTextFieldDeleteBackward:self];
    }
}
-(instancetype)initWithFrame:(CGRect)frame hasToolBar:(BOOL)hasToolBar hasDelete:(BOOL)hasDeleteBtn{
    self = [super initWithFrame:frame];
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
+(NSInteger)getWordNumber:(UITextField*)textField{
    NSString *language = textField.textInputMode.primaryLanguage;
    static NSInteger length = 0;
    if ([language isEqualToString:@"zh-Hans"]) {//汉字
        UITextRange *selectedRange = [textField markedTextRange];
        //避免拼音计入字数引起不必要麻烦
        if (!selectedRange) {//没有高亮
            length = textField.text.length;
        }else{//有高亮时暂不统计字数
            
        }
    }else{
        length = textField.text.length;
    }
    return length;
}


-(void)sureBtnClick:(UIButton*)btn{
    [self resignFirstResponder];
}
-(void)deleteBtnClick{
    self.text = @"";
}

@end
