//
//  HLUIKit_Factory+HLCustom.m
//  LearningRoad
//
//  Created by 张会林 on 2018/7/31.
//  Copyright © 2018年 LearningRoad. All rights reserved.
//

#import "HLUIKit_Factory+HLCustom.h"

@implementation HLUIKit_Factory (HLCustom)
+ (HLButton *)create_HLButton_WithButtonType:(UIButtonType)btnType hlButtonType:(HLButtonType)hlButtonType frame:(CGRect)frame normalTitleColor:(UIColor *)normalTitleColor normalFont:(UIFont *)font normalTitle:(NSString *)normalTitle {
    
    HLButton *btn = [HLButton buttonWithType:btnType HLButtonType:hlButtonType Frame:frame];
    btn.titleLabel.font = font;
    [btn setTitleColor:normalTitleColor forState:UIControlStateNormal];
    [btn setTitle:normalTitle forState:UIControlStateNormal];
    return btn;
}

+ (HLButton *)create_HLButton_WithButtonType:(UIButtonType)btnType hlButtonType:(HLButtonType)hlButtonType frame:(CGRect)frame backgroundImage:(NSString*)normalBackgroundImageName{
    
    HLButton *btn = [HLButton buttonWithType:btnType HLButtonType:hlButtonType Frame:frame];
    [btn setBackgroundImage:[UIImage imageNamed:normalBackgroundImageName] forState:UIControlStateNormal];
    return btn;
    
}

+ (HLButton *)create_HLButton_WithButtonType:(UIButtonType)btnType hlButtonType:(HLButtonType)hlButtonType frame:(CGRect)frame Image:(NSString*)normalImageName{
    
    HLButton *btn = [HLButton buttonWithType:btnType HLButtonType:hlButtonType Frame:frame];
    [btn setImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
    return btn;
    
}
//----------------------------------- HLTextField -----------------------------------//
+ (HLTextField *)create_HLTextField_WithFrame:(CGRect)frame delegate:(id<HLTextFieldDelegate>)delegate hasConfirm:(BOOL)hasConfirm hasDelete:(BOOL)hasDelete{
    
    HLTextField *textField = [[HLTextField alloc] initWithFrame:frame hasToolBar:hasConfirm hasDelete:YES];
    textField.delegate     = delegate;
    textField.hlTextFieldDelete = delegate;
    return textField;
}


//----------------------------------- HLTextView -----------------------------------//
+ (HLTextView *)create_HLTextView_WithFrame:(CGRect)frame delegate:(id<HLTextViewDelegate>)delegate hasConfirm:(BOOL)hasConfirm placeHolder:(NSString*)placeHolder {
    
    HLTextView *textView = [[HLTextView alloc] initWithFrame:frame HasToolBar:hasConfirm];
    textView.delegate    = delegate;
    textView.hlTextViewDelegate = delegate;
    textView.placeHolder        = placeHolder;
    return textView;
}
//----------------------------------- HLScrollSegmentControl -----------------------------------//
+ (HLScrollSegmentControl *)create_HLScrollSegmentControl_WithFrame:(CGRect)frame delegate:(id<HLScrollSegmentControlDelegate>)delegate textFont:(UIFont *)textFont spageWidth:(CGFloat)spaceWidth items:(NSArray<NSString *> *)items {
    
    HLScrollSegmentControl *control = [[HLScrollSegmentControl alloc] initWithFrame:frame Items:items TextFont:textFont SpaceWidth:spaceWidth AndDelegate:delegate];
    return control;
}


//----------------------------------- HLUNScrollSegmentControl -----------------------------------//
+ (HLUNScrollSegmentControl *)create_HLUNScrollSegmentControl_WithFrame:(CGRect)frame delegate:(id<HLUNScrollSegmentControlDelegate>)delegate textFont:(UIFont *)textFont Items:(NSArray <NSString *> *)items{
    HLUNScrollSegmentControl *control = [[HLUNScrollSegmentControl alloc] initWithFrame:frame Items:items TextFont:textFont AndDelegate:delegate];
    return control;
}








@end
