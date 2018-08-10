//
//  CommentInputBar.h
//  LotteryApp
//
//  Created by Feili on 13-9-4.
//  Copyright (c) 2013年 windo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomKeyboardConst.h"

@protocol CommentInputBarDelegate;

@interface CommentInputBar : UIView

//清空text ( 发送成功后可能需要清空 )
- (void)clearText;

//开始编辑（显示系统键盘）
- (void)startEditing;

////放弃第一响应者身份（收起键盘）
- (void)giveUpFirstResponder;

//发送按钮是否可用 ( 点击发送时禁用，发送成功后打开禁用 )
- (void)setSendBtnEnable:(BOOL)isEnable;
/**
 * point 工具栏的初始位置xy坐标
 * delegate 代理
 */
+ (instancetype)commentInputBarWithPoint:(CGPoint)point AndDelegate:(id<CommentInputBarDelegate>)delegate;

@end

@protocol CommentInputBarDelegate <NSObject>
@optional
- (void)sendBtnClickedWithText:(NSString *)text;
@end
