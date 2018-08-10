//
//  HLGetHBAlertView.m
//  demo
//
//  Created by Zhl on 16/10/27.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import "HLGetHBAlertView.h"
#import "UIImageView+WebCache.h"




@interface HLGetHBAlertView ()<CAAnimationDelegate>
@property (nonatomic,weak)UIControl *control;
@property (nonatomic,weak)UIView *contentView;
@property (nonatomic,weak)UIImageView *bgImgV;
@property (nonatomic,weak)UIImageView * userIconImgV;
@property (nonatomic,weak)UILabel *nickNameL;
@property (nonatomic,weak)UILabel *messageL;
@property (nonatomic,weak)UIButton *openBtn;
@property (nonatomic,weak)UIButton *cancleBtn;
@property (nonatomic,weak)UIButton *seeLuckyBtn;
@end

@implementation  HLGetHBAlertView
+(instancetype)hlGetHBAlertViewWithDelegate:(id<HLGetHBAlertViewDelegate>)delegate{
    HLGetHBAlertView *alertView = [[HLGetHBAlertView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    alertView.delegate = delegate;
    return alertView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIControl *control = [[UIControl alloc] initWithFrame:frame];
        [control addTarget:self action:@selector(spaceControlAction) forControlEvents:UIControlEventTouchUpInside];
        control.backgroundColor = rgb(0, 0, 0, 0.3);
        _control = control;
        [self addSubview:_control];
        
        UIImage *img = [UIImage imageNamed:@"redBag_bgWithCancle"];
        CGFloat x,y,w,h;
        w = img.size.width;   h = img.size.height;   x = (SCREEN_WIDTH-w)/2.0;  y = (SCREEN_HEIGHT-h)/2.0;
        
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        contentView.backgroundColor = rgb(200, 200, 200, 1);
        contentView.layer.cornerRadius = 8;
        contentView.layer.masksToBounds = YES;
        _contentView = contentView;
        [self addSubview:_contentView];
        
        UIImageView *bgImgV = [[UIImageView alloc] initWithFrame:contentView.bounds];
        bgImgV.userInteractionEnabled = YES;
        bgImgV.image = img;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [bgImgV addGestureRecognizer:tap];
        _bgImgV = bgImgV;
        
        x = 0;  y = 0;  w = 60;  h = 60;
        UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancleBtn.frame = ccr(x, y, w, h);
        cancleBtn.backgroundColor = [UIColor clearColor];
        [cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _cancleBtn = cancleBtn;
        
        w = 58;  h = w;  x = (_contentView.width-w)/2.0;  y = 60;
        UIView *iconBgView = [[UIView alloc] initWithFrame:ccr(x, y, w, h)];
        iconBgView.backgroundColor = rgb(185, 188, 188, 1);
        iconBgView.layer.cornerRadius = h/2.0;
        iconBgView.layer.masksToBounds = YES;
        [_bgImgV addSubview:iconBgView];
        
        w = 54;  h = w;  x = iconBgView.left+2;  y = iconBgView.top+2;
        UIImageView *userIconImgV = [[UIImageView alloc] initWithFrame:ccr(x, y, w, h)];
        userIconImgV.image = [UIImage imageNamed:@"redBag_ask"];
        userIconImgV.layer.cornerRadius = h/2.0;
        userIconImgV.layer.masksToBounds = YES;
        _userIconImgV = userIconImgV;
        
        
        w = 200;  h = 20;  x = (_contentView.width-w)/2.0;  y = _userIconImgV.bottom+10;
        UILabel *nickNameL = [[UILabel alloc] initWithFrame:ccr(x, y, w, h)];
        nickNameL.text = @"昵称";
        nickNameL.textAlignment = NSTextAlignmentCenter;
        nickNameL.font = [UIFont systemFontOfSize:15];
        nickNameL.textColor = rgb(100, 25, 35, 1);
        [nickNameL adjustsFontSizeToFitWidth];
        _nickNameL = nickNameL;
        
        w = contentView.width;  h = 40;  x = 0;  y = _nickNameL.bottom+10;
        UILabel *messageL = [[UILabel alloc] initWithFrame:ccr(x, y, w, h)];
        messageL.textAlignment = NSTextAlignmentCenter;
        messageL.font = [UIFont systemFontOfSize:15];
        messageL.textColor = rgb(100, 25, 35, 1);
        messageL.text = @"手慢,红包抢完了";
        _messageL = messageL;
        
        img = [UIImage imageNamed:@"redBag_open"];
        w = img.size.width;  h = img.size.height;x = (_contentView.width-w)/2.0;  y = (_contentView.height-100 - 98/2.0);
        UIButton *openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        openBtn.frame = ccr(x, y, w, h);
        [openBtn setImage:img forState:UIControlStateNormal];
        [openBtn addTarget:self action:@selector(openBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _openBtn = openBtn;
        
        w = 200;  h = 25;  x = (_contentView.width-w)/2.0;  y = _contentView.height-h-10;
        UIButton *seeLuckyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        seeLuckyBtn.frame = ccr(x, y, w, h);
        seeLuckyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [seeLuckyBtn setTitle:@"查看大家的手气>" forState:UIControlStateNormal];
        [seeLuckyBtn addTarget:self action:@selector(seeLuckyBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [seeLuckyBtn setTitleColor:rgb(250, 205, 137, 1) forState:UIControlStateNormal];
        _seeLuckyBtn = seeLuckyBtn;
        
        [_contentView addSubview:_bgImgV];
        [_bgImgV addSubview:_cancleBtn];
        [_bgImgV addSubview:_userIconImgV];
        [_bgImgV addSubview:_nickNameL];
        [_bgImgV addSubview:_messageL];
        [_bgImgV addSubview:_openBtn];
        [_bgImgV addSubview:_seeLuckyBtn];
    }
    return self;
}
#pragma mark - Actions
-(void)tapAction:(UITapGestureRecognizer*)tap{
    if (tap.state == UIGestureRecognizerStateEnded) {
        [self hlGetHBAlertViewHidden];
    }
}
-(void)spaceControlAction{
    [self hlGetHBAlertViewHidden];
}
-(void)openBtnClick{
    _openBtn.userInteractionEnabled = NO;
    if ([self.delegate respondsToSelector:@selector(hlGetHBAlertViewOpenBtnClicked)]) {
        [self.delegate hlGetHBAlertViewOpenBtnClicked];
    }

    [_openBtn setImage:[UIImage imageNamed:@"redBag_ask"] forState:UIControlStateNormal];
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    ani.duration = 0.5;
    ani.byValue = @(M_PI * 2);
    ani.delegate = self;
    [_openBtn.layer addAnimation:ani forKey:nil];
}
-(void)cancleBtnClick{
    [self hlGetHBAlertViewHidden];
}
-(void)seeLuckyBtnClick{
    [self hlGetHBAlertViewHidden];
    if ([self.delegate respondsToSelector:@selector(hlGetHBAlertViewSeeLuckyBtnClicked)]) {
        [self.delegate hlGetHBAlertViewSeeLuckyBtnClicked];
    }
}
#pragma mark - public methods
-(void)hlGetHBAlertViewShowInWindowWithType:(NSString *)type{
    if ([type isEqualToString:@"0"]) {
        _messageL.text = @"发了一个红包";
        _openBtn.hidden = NO;
        _seeLuckyBtn.hidden = YES;
    }else if ([type isEqualToString:@"1"]){
        _messageL.text = @"手慢,红包抢完了";
        _openBtn.hidden = YES;
        _seeLuckyBtn.hidden = NO;
    }else if ([type isEqualToString:@"2"]){
        _messageL.text = @"该红包已过期";
        _openBtn.hidden = YES;
        _seeLuckyBtn.hidden = NO;
    }
    self.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.000001, 0.000001);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
        [NSTimer scheduledTimerWithTimeInterval:10 target:self
                                       selector:@selector(hlGetHBAlertViewHidden) userInfo:nil repeats:NO];
    }];
}
/**
 *  @param type 0:开   1：手慢红包以抢完   2：红包过期
 */
-(void)hlGetHBAlertViewShowWithType:(NSString *)type inView:(UIView *)view{
    if ([type isEqualToString:@"0"]) {
        _messageL.text = @"发了一个红包";
        _openBtn.hidden = NO;
        _seeLuckyBtn.hidden = YES;
    }else if ([type isEqualToString:@"1"]){
        _messageL.text = @"手慢,红包抢完了";
        _openBtn.hidden = YES;
        _seeLuckyBtn.hidden = NO;
    }else if ([type isEqualToString:@"2"]){
        _messageL.text = @"该红包已过期";
        _openBtn.hidden = YES;
        _seeLuckyBtn.hidden = NO;
    }
    [view addSubview:self];
}
#pragma mark - CAAnimationDelegate
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{

    [_openBtn setImage:[UIImage imageNamed:@"redBag_open"] forState:UIControlStateNormal];
    NSLog(@"动画完成");
    [_openBtn.layer removeAnimationForKey:@"transform"];
    [self hlGetHBAlertViewHidden];
}
-(void)hlGetHBAlertViewHidden{
    CGPoint center = self.center;
    //    center.y +=SCREEN_HEIGHT/2.0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        self.contentView.transform = CGAffineTransformMakeScale(0.000001, 0.000001);
        self.contentView.center = center;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
