//
//  JK_BaseCustomAlertView.m
//  AskPlate
//
//  Created by 张会林 on 2018/4/17.
//  Copyright © 2018年 cheng. All rights reserved.
//

#import "JK_BaseCustomAlertView.h"
#import "AppDelegate.h"
@interface JK_BaseCustomAlertView ()<UIGestureRecognizerDelegate>

@property (nonatomic,copy)   JK_BaseCustomAlertViewConfirmBlock  confirmblock;
@property (nonatomic,copy)   JK_BaseCustomAlertViewCancelBlock   cancelBlock;
@property (nonatomic,copy)   JK_BaseCustomAlertViewTapSpaceBlock tapSpaceBlock;
//是否已添加点击空白处隐藏弹框手势
@property (nonatomic,assign) BOOL hasAddTapSpaceGesture;
@end
@implementation JK_BaseCustomAlertView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.frame = [UIScreen mainScreen].bounds;
        self.hasAddTapSpaceGesture = NO;
        self.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
        [self addSubview:self.contentView];
    }
    return self;
}
- (void)createSubViews {
   
}
/**
 * 显示弹框 （只有取消按钮 的回调）
 * alertClass   : 子类的类型
 * block        : 取消按钮回调
 *
 */
+ (instancetype)showAlertWithAlertClass:(Class)alertClass Tag:(NSInteger)tag CancelClick:(JK_BaseCustomAlertViewCancelBlock)block {
    return [JK_BaseCustomAlertView showAlertWithAlertClass:alertClass Tag:tag ConfirmClick:nil CancelClick:block];
}
/**
 * 显示弹框
 * confirmBlock : 确定按钮回调
 * cancelBlock  : 取消按钮回调
 */
+ (instancetype)showAlertWithAlertClass:(Class)alertClass Tag:(NSInteger)tag  ConfirmClick:(JK_BaseCustomAlertViewConfirmBlock)confirmBlock CancelClick:(JK_BaseCustomAlertViewCancelBlock)cancelBlock {
    UIWindow *window = ((AppDelegate*)[UIApplication sharedApplication].delegate).window;
    UIView *view = [window viewWithTag:tag];
    if (!view) {
        JK_BaseCustomAlertView *alert = [[alertClass  alloc] init];
        alert.tag = tag;
        [alert createSubViews];
        alert.confirmblock = confirmBlock;
        alert.cancelBlock  = cancelBlock;
        [alert showAlertView];
        [window addSubview:alert];
        return alert;
    }else{
        return (JK_BaseCustomAlertView *)view;
    }
}

/**
 * 隐藏弹框
 */
+ (void)hiddenAlertWithTag:(NSInteger)tag {
    UIWindow *window = ((AppDelegate*)[UIApplication sharedApplication].delegate).window;
    UIView *view = [window viewWithTag:tag];
    if ([view isKindOfClass:[JK_BaseCustomAlertView class]]) {
        JK_BaseCustomAlertView *alertView = (JK_BaseCustomAlertView *)view;
        [alertView hiddenAlertView];
    }
}
/**
 * 隐藏弹框动画，动画结束移除弹框
 */
- (void)hiddenAlertView {
    self.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    [UIView animateWithDuration:0.25 animations:^{
        self.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    }completion:^(BOOL finished) {
        if (finished == YES) {
            [self removeFromSuperview];
        }
    }];
    
}
/**
 * 显示弹框内容动画
 */
- (void)showAlertView {
    self.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.0, 0.0);
    [UIView animateWithDuration:0.25 animations:^{
        self.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    }];
}
/**
 * 点击空白处隐藏，按需要添加，默认不添加点击空白隐藏
 */
- (void)addTapSpaceGesture:(JK_BaseCustomAlertViewTapSpaceBlock)tapSpaceBlock {
    
    UITapGestureRecognizer *tapGuesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGuestureAction:)];
    tapGuesture.delegate = self;
    [self addGestureRecognizer:tapGuesture];
    self.hasAddTapSpaceGesture = YES;
    self.tapSpaceBlock = tapSpaceBlock;
}
#pragma mark - Actions
//点击空白处
- (void)tapGuestureAction:(UITapGestureRecognizer *)guesture {
    if (guesture.state == UIGestureRecognizerStateEnded) {
        if (self.tapSpaceBlock) {
            self.tapSpaceBlock(self);
        }
    }
}
/**
 * 确定按钮被点击
 */
- (void)confirmBtnClicked {
    NSLog(@"确定");
    if (self.confirmblock) {
        self.confirmblock(self);
    }
}
/**
 * 取消按钮被点击
 */
- (void)cancelBtnClicked {
    NSLog(@"取消");
    if (self.cancelBlock) {
        self.cancelBlock(self);
    }
}

#pragma mark - Getter Methods

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn addTarget:self action:@selector(confirmBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}
#pragma mark - < UIGestureRecognizerDelegate >
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (self.hasAddTapSpaceGesture) {
        CGPoint point = [touch locationInView:self];
        //    NSLog(@"%@",NSStringFromCGPoint(point));
        CGFloat left  = self.contentView.frame.origin.x;
        CGFloat right = self.contentView.frame.origin.x+self.contentView.frame.size.width;
        CGFloat up = self.contentView.frame.origin.y;
        CGFloat down = self.contentView.frame.origin.y +self.contentView.frame.size.height;
        if (point.x>=left&&point.x<=right&&point.y>=up&&point.y<=down) {
            return NO;
        }else{
            return YES;
        }
    }
    return NO;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

