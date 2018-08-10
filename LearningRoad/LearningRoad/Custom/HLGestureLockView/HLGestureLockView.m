//
//  HLGestureLockView.m
//  codeDemo
//
//  Created by Zhl on 16/7/11.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import "HLGestureLockView.h"
#import "HLLockGesture.h"
@interface HLGestureLockView ()
@property (nonatomic,weak)UIView *hlView;
/**
 *  输入密码
 */
@property (nonatomic,copy)NSString *psStr;

/**
 *  设置密码1
 */
@property (nonatomic,copy)NSString *settingPsStr;
/**
 *  设置密码2（确认）
 */
@property (nonatomic,copy)NSString *confirmPsStr;

@property(nonatomic,assign)NSInteger psErrorCount;
@end

@implementation HLGestureLockView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat w1 = frame.size.width;
        for (int i = 0; i<9; i++) {
            CGFloat w=(w1-120)/3.0,h=w,
            x =20+i/3*w+(i/3)*40,
            y =20+i%3*w+(i%3)*40;
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
            
            view.layer.cornerRadius = h/2.0;
            view.layer.masksToBounds = YES;
            view.layer.borderColor = [UIColor redColor].CGColor;
            view.layer.borderWidth = 3;
            [self addSubview:view];
        }
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
        view.layer.borderWidth = 1;
        view.layer.borderColor = [UIColor grayColor].CGColor;
        view.layer.cornerRadius = (w1-120)/6.0;
        view.layer.masksToBounds = YES;
        [self addSubview:view];
        self.hlView = view;
        view.backgroundColor = [UIColor clearColor];
        HLLockGesture *gesture = [[HLLockGesture alloc] initWithTarget:self action:@selector(lockGestureAction:)];
        [self.hlView addGestureRecognizer:gesture];
        self.psErrorCount  = 0;
        self.isSetPs = NO;
    }
    return self;
}

-(void)lockGestureAction:(HLLockGesture*)gesture{
    if (gesture.state == UIGestureRecognizerStateEnded) {
        if (self.isSetPs) {//设置密码
            
            if (!self.settingPsStr.length) {//设置密码1
                self.settingPsStr =[NSString stringWithString:gesture.finalPassWordStr];
                self.state = HLGestureLockViewInputStateSetPS;
            }else{//设置密码2（确认）
                self.confirmPsStr =[NSString stringWithString:gesture.finalPassWordStr];
                self.state = HLGestureLockViewInputStateSetPSConfirm;
                if ([self.confirmPsStr isEqualToString:self.settingPsStr]) {
                    [LRTools hl_showAlertViewWithString:@"设置成功"];
                    if ([self.delegate respondsToSelector:@selector(hlGestureLockView:didSettedPassowrd:)]) {
                        [self.delegate hlGestureLockView:self didSettedPassowrd:self.confirmPsStr];
                    }
                }else{
                    [LRTools hl_showAlertViewWithString:@"两次输入不一致请重新输入"];
                }
            }
        }else{//输入密码
            self.psStr = [NSString stringWithString:gesture.finalPassWordStr];
            self.state = HLGestureLockViewInputStateInputPs;
            if ([self.delegate respondsToSelector:@selector(hlGestureLockView:didInputPassowrd:)]) {
                [self.delegate hlGestureLockView:self didInputPassowrd:self.psStr];
            }
        }
    }
    if (gesture.state == UIGestureRecognizerStateCancelled) {

    }
}
-(void)setState:(HLGestureLockViewInputState)state{
    _state = state;
    if (self.gestureLockState) {
        self.gestureLockState(_state);
    }
}
@end
