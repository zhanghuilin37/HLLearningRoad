//
//  HLUIKit_Factory.m
//  LearningRoad
//
//  Created by 张会林 on 2018/7/31.
//  Copyright © 2018年 LearningRoad. All rights reserved.
//

#import "HLUIKit_Factory.h"

@implementation HLUIKit_Factory
//------------------------- UILabel -------------------------//
+ (UILabel *)create_UILabel_WithFrame:(CGRect)frame textColor:(UIColor *)textColor font:(UIFont *)font{
    
    UILabel *label  = [[UILabel alloc] init];
    label.frame     = frame;
    label.textColor = textColor;
    label.font      = font;
    return label;
}

+ (UILabel *)create_UILabel_WithFrame:(CGRect)frame textColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment{
    
    UILabel *label  = [[UILabel alloc] init];
    label.frame     = frame;
    label.textColor = textColor;
    label.font      = font;
    label.textAlignment = textAlignment;
    return label;
}

+ (UILabel *)create_UILabel_WithTextColor:(UIColor *)textColor font:(UIFont*)font{
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = textColor;
    label.font = font;
    return label;
}

+ (UILabel *)create_UILabel_WithTextColor:(UIColor *)textColor font:(UIFont*)font textAlignment:(NSTextAlignment)textAlignment{
    
    UILabel *label  = [[UILabel alloc] init];
    label.textColor = textColor;
    label.font      = font;
    label.textAlignment = textAlignment;
    return label;
}


//-------------------------- UIButton ------------------------//
+ (UIButton *)create_UIButton_WithButtonType:(UIButtonType)btnType frame:(CGRect)frame normalTitleColor:(UIColor *)normalTitleColor normalFont:(UIFont *)font normalTitle:(NSString *)normalTitle{
    
    UIButton *btn = [UIButton buttonWithType:btnType];
    btn.frame     = frame;
    btn.titleLabel.font = font;
    [btn setTitleColor:normalTitleColor forState:UIControlStateNormal];
    [btn setTitle:normalTitle forState:UIControlStateNormal];
    return btn;
}

+ (UIButton *)create_UIButton_WithButtonType:(UIButtonType)btnType frame:(CGRect)frame backgroundImage:(NSString*)normalBackgroundImageName{
    
    UIButton *btn = [UIButton buttonWithType:btnType];
    btn.frame     = frame;
    [btn setBackgroundImage:[UIImage imageNamed:normalBackgroundImageName] forState:UIControlStateNormal];
    return btn;
    
}

+ (UIButton *)create_UIButton_WithButtonType:(UIButtonType)btnType frame:(CGRect)frame Image:(NSString*)normalImageName{
    
    UIButton *btn = [UIButton buttonWithType:btnType];
    btn.frame     = frame;
    [btn setImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
    return btn;
    
}


//-------------------------- UITableView ------------------------//
+ (UITableView *)create_UITableView_WithFrame:(CGRect)frame tableViewStyle:(UITableViewStyle)style delegate:(id<UITableViewDelegate>)delegate dataSource:(id<UITableViewDataSource>)dataSource{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:style];
    tableView.delegate     = delegate;
    tableView.dataSource   = dataSource;
    return tableView;
}


//-------------------------- UIScrollView ------------------------//
+ (UIScrollView *)create_UIScrollView_WithFrame:(CGRect)frame delegate:(id<UIScrollViewDelegate>)delegate bounces:(BOOL)bounces contentSize:(CGSize)contentSize pageEnable:(BOOL)pageEnabel {
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.delegate      = delegate;
    scrollView.bounces       = bounces;
    scrollView.contentSize   = contentSize;
    scrollView.pagingEnabled = pageEnabel;
    return scrollView;
}

//-------------------------- UITextView ------------------------//
+ (UITextView *)create_UITextViewWith_Frame:(CGRect)frame delegate:(id<UITextViewDelegate>)delegate {
    
    UITextView *textView = [[UITextView alloc] initWithFrame:frame];
    textView.delegate    = delegate;
    return textView;
}


//-------------------------- UITextField ------------------------//
+ (UITextField *)create_UITextField_WithFrame:(CGRect)frame delegate:(id<UITextFieldDelegate>)delegate placeHolder:(NSString *)placeHolder keyboardType:(UIKeyboardType)keyboardType{
    
    UITextField *textField  = [[UITextField alloc] initWithFrame:frame];
    textField.delegate      = delegate;
    textField.placeholder   = placeHolder;
    textField.keyboardType  = keyboardType;
    return textField;
}
@end
