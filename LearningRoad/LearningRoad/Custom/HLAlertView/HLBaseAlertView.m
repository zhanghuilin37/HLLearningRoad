//
//  HLBaseAlertView.m
//  LearningRoad
//
//  Created by 张会林 on 2018/7/31.
//  Copyright © 2018年 LearningRoad. All rights reserved.
//

#import "HLBaseAlertView.h"
#import "AppDelegate.h"
@interface HLBaseAlertView ()<UIGestureRecognizerDelegate>
//是否已添加点击空白处隐藏弹框手势
@property (nonatomic,assign) BOOL hasAddTapSpaceGesture;
@end
@implementation HLBaseAlertView
+ (instancetype)showWithDelegate:(id<HLBaseAlertViewDelegate>)delegate Tag:(NSInteger)tag {
    HLBaseAlertView *alert = [[HLBaseAlertView alloc] initWithDelegate:delegate Tag:tag];
    return alert;
}
- (instancetype)initWithDelegate:(id<HLBaseAlertViewDelegate>)delegate Tag:(NSInteger)tag{
    self = [super init];
    if (self) {
        
        self.delegate = delegate;
        self.tag = tag;
        
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        
        self.hasAddTapSpaceGesture = NO;
        [self addSubview:self.contentView];
        [self createSubViews];
    }
    return self;
}
- (void)createSubViews{
    
}
- (void)confirmBtnClicked {
    if ([self.delegate respondsToSelector:@selector(hlAlertView:clickedInedx:)]) {
        [self.delegate hlAlertView:self clickedInedx:1];
    }
}
- (void)cancelBtnClicked {
    [self hidden];
    if ([self.delegate respondsToSelector:@selector(hlAlertView:clickedInedx:)]) {
        [self.delegate hlAlertView:self clickedInedx:0];
    }
}
//点击空白处
- (void)tapGuestureAction:(UITapGestureRecognizer *)guesture {
    if (guesture.state == UIGestureRecognizerStateEnded) {
        [self hidden];
        if ([self.delegate respondsToSelector:@selector(hlAlertViewTapSpace)]) {
            [self.delegate hlAlertViewTapSpace];
        }
    }
}
/**
 * 点击空白处，按需要添加，默认不添加点击空白隐藏
 */
- (void)addTapSpaceGesture {
    [self hidden];
    UITapGestureRecognizer *tapGuesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGuestureAction:)];
    tapGuesture.delegate = self;
    [self addGestureRecognizer:tapGuesture];
    self.hasAddTapSpaceGesture = YES;
}

- (void)show {
    
    UIWindow *window = ((AppDelegate*)[UIApplication sharedApplication].delegate).window;
    [window addSubview:self];
    
    self.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.0, 0.0);
    [UIView animateWithDuration:0.25 animations:^{
        self.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    }];
}

- (void)hidden {
    self.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    [UIView animateWithDuration:0.25 animations:^{
        self.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    }completion:^(BOOL finished) {
        if (finished == YES) {
            [self removeFromSuperview];
        }
    }];
}


#pragma mark - GetterMethods
- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}
- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor colorWithRed:50.0/256.0 green:50.0/256.0 blue:200/256.0 alpha:1.0] forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(confirmBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}
-(UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor colorWithRed:50.0/256.0 green:50.0/256.0 blue:200/256.0 alpha:1.0] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
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
