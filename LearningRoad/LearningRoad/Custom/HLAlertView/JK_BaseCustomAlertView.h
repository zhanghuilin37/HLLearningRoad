//
//  JK_BaseCustomAlertView.h
//  AskPlate
//
//  Created by 张会林 on 2018/4/17.
//  Copyright © 2018年 cheng. All rights reserved.
//
/**
 * 自定义弹框的根类 实现了弹出和隐藏 创建子类时注意事项
 * 1》复写 -createSubViews 方法 实现子控件的布局
 * 2》指定contentview、confirmBtn、cancelBtn的frame等
 * 3》子控件都添加到contentView中
 * 4》本控件是直接添加到window上的
 * 5》按需要添加点击空白处隐藏，默认不添加
 * 6》当子类只需要一个按钮时只需要添加cancelBtn并这只相应标题属性即可
 */
#import <UIKit/UIKit.h>
@class JK_BaseCustomAlertView;
/** 确定回调block */
typedef void(^JK_BaseCustomAlertViewConfirmBlock) (JK_BaseCustomAlertView *alert);
/** 去消回调block */
typedef void(^JK_BaseCustomAlertViewCancelBlock)  (JK_BaseCustomAlertView *alert);
/** 点击空白处回调block */
typedef void(^JK_BaseCustomAlertViewTapSpaceBlock) (JK_BaseCustomAlertView *alert);

@interface JK_BaseCustomAlertView : UIView

/** 所有子控件的容器子类需要制定contentView的frame */
@property (nonatomic,strong) UIView   *contentView;
/** 确定按钮 需要设置父视图、frame、标题、背景等 */
@property (nonatomic,strong) UIButton *confirmBtn;
/** 取消按钮 需要设置父视图、frame、标题、背景等 */
@property (nonatomic,strong) UIButton *cancelBtn;

/**
 * 显示弹框 （只有取消按钮 的回调）
 * alertClass   : 子类的类型
 * block        : 取消按钮回调
 *
 */
+ (instancetype)showAlertWithAlertClass:(Class)alertClass Tag:(NSInteger)tag CancelClick:(JK_BaseCustomAlertViewCancelBlock)block;

/**
 * 显示弹框 （确定&取消按钮 的回调）
 * alertClass   : 子类的类型
 * confirmBlock : 确定按钮回调
 * cancelBlock  : 取消按钮回调
 */
+ (instancetype)showAlertWithAlertClass:(Class)alertClass Tag:(NSInteger)tag ConfirmClick:(JK_BaseCustomAlertViewConfirmBlock)confirmBlock CancelClick:(JK_BaseCustomAlertViewCancelBlock)cancelBlock;

/**
 * 隐藏指定tag值得弹框
 */
+ (void)hiddenAlertWithTag:(NSInteger)tag;

/**
 * 隐藏弹框
 */
- (void)hiddenAlertView;


/**
 * 创建子控件的subViews（重要方法，子类必须实现的方法）
 */
- (void)createSubViews;

/**
 * 确定按钮的点击方法（在子类中创建确定按钮时需要添加该方法）
 */
- (void)confirmBtnClicked;

/**
 * 取消按钮的点击方法（在子类中创建取消按钮时需要添加该方法）
 */
- (void)cancelBtnClicked;

/**
 * 点击空白处隐藏，按需要添加，默认不添加点击空白隐藏
 */
- (void)addTapSpaceGesture:(JK_BaseCustomAlertViewTapSpaceBlock)tapSpaceBlock;
@end

