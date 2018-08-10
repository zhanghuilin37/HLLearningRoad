//
//  HLGestureLockView.h
//  codeDemo
//
//  Created by Zhl on 16/7/11.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    HLGestureLockViewInputStateSetPS = 2000,//设置密码
    HLGestureLockViewInputStateSetPSConfirm,//确认设置密码
    HLGestureLockViewInputStateInputPs//输入密码
}HLGestureLockViewInputState;
@protocol HLGestureLockViewDelegate;

@interface HLGestureLockView : UIView
@property(nonatomic,assign)id<HLGestureLockViewDelegate> delegate;
@property(nonatomic,copy)void(^passWordStrBlock)(NSString*passWordStr);
@property(nonatomic,copy)void(^gestureLockState)(HLGestureLockViewInputState state);
@property(nonatomic,assign)HLGestureLockViewInputState state;
@property(nonatomic,assign)BOOL isSetPs;
@end

@protocol HLGestureLockViewDelegate <NSObject>
@optional
-(void)hlGestureLockView:(HLGestureLockView*)hlGLView didSettedPassowrd:(NSString*)passowrdStr;
-(void)hlGestureLockView:(HLGestureLockView *)hlGLView didInputPassowrd:(NSString *)inputStr;
@end
