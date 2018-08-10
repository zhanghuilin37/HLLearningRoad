//
//  HLAlertView.h
//  LearningRoad
//
//  Created by CH10 on 16/3/14.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HLAlertViewDelegate;
@interface HLAlertView : UIView

@property (nonatomic,assign)id<HLAlertViewDelegate>delegate;
@property (nonatomic,weak) UIView *contentView;
/**
 *底部按钮的背景颜色
 */
@property (nonatomic,weak) UIColor *btnBgColor;
/**
 *底部按钮标题颜色
 */
@property (nonatomic,weak) UIColor *btnTextColor;
/**
 *底部按钮背景框颜色
 */
@property (nonatomic,weak) UIColor *rectColor;

//alertview的显示和隐藏
-(void)alertShow;
-(void)alertHidden;
-(void)alertShowInView:(UIView *)view;
/**
 *frame:这里的frame是contentView的frame
 *delegate:
 *btnHeight:下部按钮的高度
 *cancleBtnTitle:取消按钮的标题
 *otherBtnTitles:其他按钮的标题，数组类型
 *return:HLAlertView
 */
-(instancetype)initWithFrame:(CGRect)frame delegate:(id<HLAlertViewDelegate>)delegate btnHeight:(CGFloat)btnHeight cancleBtnTitle:(NSString*)cancleBtnTitle otherBtnTitle:(NSArray *)otherBtnTitles;
+(instancetype)hlAlertWithFrame:(CGRect)frame delegate:(id<HLAlertViewDelegate>)delegate btnHeight:(CGFloat)btnHeight cancleBtnTitle:(NSString*)cancleBtnTitle otherBtnTitle:(NSArray *)otherBtnTitles;
+(instancetype)hlAlertWithFrame:(CGRect)frame delegate:(id<HLAlertViewDelegate>)delegate btnHeight:(CGFloat)btnHeight title:(NSString*)title message:(NSString*)message cancleBtnTitle:(NSString*)cancleBtnTitle otherBtnTitle:(NSArray *)otherBtnTitles;
@end


@protocol HLAlertViewDelegate <NSObject>
@optional
/**
 *index: 0 取消、1 2 3 other
 */
-(void)hlAlertView:(HLAlertView *)alertView didClickedBtnAtIndex:(NSInteger)index;

@end
