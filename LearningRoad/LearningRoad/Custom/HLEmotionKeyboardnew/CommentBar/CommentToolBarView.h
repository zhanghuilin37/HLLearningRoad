//
//  CommentToolBarView.h
//  BBSDemo
//
//  Created by Zhl on 2017/9/4.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomKeyboardConst.h"
@protocol CommentToolBarViewDelegate;
@interface CommentToolBarView : UIView
@property (nonatomic, weak) UITextView    *inputTextView;

//当选择表情后更改textview的text
-(void)changeTextWithFaceSelectedName:(NSString*)nameStr;
//单表情中的删除被点击时调用删除
- (void)faceDeleteClick;
//获取当前toolbar和标准toolbar（CommentNormalToolBarHeight）的高度差
- (CGFloat)getDHeight;
//表情/键盘切换
-(void)setFaceBtnSelected:(BOOL)isSelected;
//隐藏提示
-(void)setPlaceHolderLabelHidden:(BOOL)isHidden;
//隐藏唤醒键盘的开关
-(void)setEditingSwitchHidden:(BOOL)isHidden;
//发送按钮是否可用点击发送时禁用，发送成功后打开禁用
-(void)setSendBtnEnable:(BOOL)isEnable;
+(instancetype)commentToolBarViewWithPoint:(CGPoint)point AndDelegate:(id<CommentToolBarViewDelegate>)delegate;
@end


@protocol CommentToolBarViewDelegate <NSObject>
@optional
//当输入内容时动态更新父控件的frame
-(void)updateToolBarSuperViewFrame;
//表情/键盘被点击
-(void)faceBtnClick:(UIButton*)btn;
//发送按钮被点击
-(void)sendBtnClick:(UIButton*)btn;
//唤醒键盘
-(void)editingSwitchClick;
@end
