//
//  HLUIKit_Factory.h
//  LearningRoad
//
//  Created by 张会林 on 2018/7/31.
//  Copyright © 2018年 LearningRoad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HLUIKit_Factory : NSObject

//------------------------- UILabel -------------------------//
+ (UILabel *)create_UILabel_WithFrame:(CGRect)frame textColor:(UIColor *)textColor font:(UIFont *)font;

+ (UILabel *)create_UILabel_WithFrame:(CGRect)frame textColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment;

+ (UILabel *)create_UILabel_WithTextColor:(UIColor *)textColor font:(UIFont*)font;

+ (UILabel *)create_UILabel_WithTextColor:(UIColor *)textColor font:(UIFont*)font textAlignment:(NSTextAlignment)textAlignment;


//-------------------------- UIButton ------------------------//
+ (UIButton *)create_UIButton_WithButtonType:(UIButtonType)btnType frame:(CGRect)frame normalTitleColor:(UIColor *)normalTitleColor normalFont:(UIFont *)font normalTitle:(NSString *)normalTitle;

+ (UIButton *)create_UIButton_WithButtonType:(UIButtonType)btnType frame:(CGRect)frame backgroundImage:(NSString*)backgroundImageName;

+ (UIButton *)create_UIButton_WithButtonType:(UIButtonType)btnType frame:(CGRect)frame Image:(NSString*)ImageName;


//-------------------------- UITableView ------------------------//
+ (UITableView *)create_UITableView_WithFrame:(CGRect)frame tableViewStyle:(UITableViewStyle)style delegate:(id<UITableViewDelegate>)delegate dataSource:(id<UITableViewDataSource>)dataSource;


//-------------------------- UIScrollView ------------------------//
+ (UIScrollView *)create_UIScrollView_WithFrame:(CGRect)frame delegate:(id<UIScrollViewDelegate>)delegate bounces:(BOOL)bounces contentSize:(CGSize)contentSize pageEnable:(BOOL)pageEnabel;

//-------------------------- UITextView ------------------------//
+ (UITextView *)create_UITextViewWith_Frame:(CGRect)frame delegate:(id<UITextViewDelegate>)delegate;


//-------------------------- UITextField ------------------------//
+ (UITextField *)create_UITextField_WithFrame:(CGRect)frame delegate:(id<UITextFieldDelegate>)delegate placeHolder:(NSString *)placeHolder keyboardType:(UIKeyboardType)keyboardType;
@end
