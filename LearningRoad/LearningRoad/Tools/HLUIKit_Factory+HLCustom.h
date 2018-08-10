//
//  HLUIKit_Factory+HLCustom.h
//  LearningRoad
//
//  Created by 张会林 on 2018/7/31.
//  Copyright © 2018年 LearningRoad. All rights reserved.
//

#import "HLUIKit_Factory.h"
#import "HLTextField.h"
#import "HLTextView.h"
#import "HLButton.h"
#import "HLScrollSegmentControl.h"
#import "HLUNScrollSegmentControl.h"
@interface HLUIKit_Factory (HLCustom)
//----------------------------------- HLButton -----------------------------------//
+ (HLButton *)create_HLButton_WithButtonType:(UIButtonType)btnType hlButtonType:(HLButtonType)hlButtonType frame:(CGRect)frame normalTitleColor:(UIColor *)normalTitleColor normalFont:(UIFont *)font normalTitle:(NSString *)normalTitle;

+ (HLButton *)create_HLButton_WithButtonType:(UIButtonType)btnType hlButtonType:(HLButtonType)hlButtonType frame:(CGRect)frame backgroundImage:(NSString*)normalBackgroundImageName;

+ (HLButton *)create_HLButton_WithButtonType:(UIButtonType)btnType hlButtonType:(HLButtonType)hlButtonType frame:(CGRect)frame Image:(NSString*)normalImageName;


//----------------------------------- HLTextField -----------------------------------//
+ (HLTextField *)create_HLTextField_WithFrame:(CGRect)frame delegate:(id<HLTextFieldDelegate>)delegate hasConfirm:(BOOL)hasConfirm hasDelete:(BOOL)hasDelete;


//----------------------------------- HLTextView -----------------------------------//
+ (HLTextView *)create_HLTextView_WithFrame:(CGRect)frame delegate:(id<HLTextViewDelegate>)delegate hasConfirm:(BOOL)hasConfirm placeHolder:(NSString*)placeHolder;


//----------------------------------- HLScrollSegmentControl -----------------------------------//
+ (HLScrollSegmentControl *)create_HLScrollSegmentControl_WithFrame:(CGRect)frame delegate:(id<HLScrollSegmentControlDelegate>)delegate textFont:(UIFont *)textFont spageWidth:(CGFloat)spaceWidth items:(NSArray<NSString *> *)items;


//----------------------------------- HLUNScrollSegmentControl -----------------------------------//

+ (HLUNScrollSegmentControl *)create_HLUNScrollSegmentControl_WithFrame:(CGRect)frame delegate:(id<HLUNScrollSegmentControlDelegate>)delegate textFont:(UIFont *)textFont Items:(NSArray <NSString *> *)items;
@end
