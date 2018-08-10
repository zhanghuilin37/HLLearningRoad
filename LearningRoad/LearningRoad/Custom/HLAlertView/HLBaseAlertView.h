//
//  HLBaseAlertView.h
//  LearningRoad
//
//  Created by 张会林 on 2018/7/31.
//  Copyright © 2018年 LearningRoad. All rights reserved.
//
/**
 自定义弹框基类
 1》子类需要实现-createSubViews
 2》协议中的- hlAlertView: clickedInedx:中的index从0开始，默认取消按钮index为0确定按钮index为1，如需更改，复写相应的点击方法即可
 3》默认点击空白处没有响应事件，如需添加调用- (void)addTapSpaceGesture 方法即可
 */
#import <UIKit/UIKit.h>
@protocol HLBaseAlertViewDelegate;
@interface HLBaseAlertView : UIView
@property (nonatomic,weak)  id<HLBaseAlertViewDelegate> delegate;
/** 所有子控件的容器子类需要制定contentView的frame */
@property (nonatomic,strong) UIView   *contentView;
/** 确定按钮 需要设置父视图、frame、标题、背景等 */
@property (nonatomic,strong) UIButton *confirmBtn;
/** 取消按钮 需要设置父视图、frame、标题、背景等 */
@property (nonatomic,strong) UIButton *cancelBtn;
+ (instancetype)showWithDelegate:(id<HLBaseAlertViewDelegate>)delegate Tag:(NSInteger)tag;
- (instancetype)initWithDelegate:(id<HLBaseAlertViewDelegate>)delegate Tag:(NSInteger)tag;
- (void)show;
- (void)hidden;
- (void)createSubViews;
/**
 * 点击空白处，按需要添加，默认不添加点击空白隐藏
 */
- (void)addTapSpaceGesture;
/**
 * 确定按钮的点击方法（在子类中创建确定按钮时需要添加该方法）
 */
- (void)confirmBtnClicked;

/**
 * 取消按钮的点击方法（在子类中创建取消按钮时需要添加该方法）
 */
- (void)cancelBtnClicked;
@end

@protocol HLBaseAlertViewDelegate <NSObject>
@optional
- (void)hlAlertView:(HLBaseAlertView*)alertView clickedInedx:(NSInteger)index;
- (void)hlAlertViewTapSpace;
@end
