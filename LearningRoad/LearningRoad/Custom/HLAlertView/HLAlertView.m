//
//  CTAlertView.m
//  LearningRoad
//
//  Created by CH10 on 16/3/14.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "HLAlertView.h"
@interface HLAlertView ()<UIGestureRecognizerDelegate>
@property (nonatomic,weak)   UIView         * bgView;
@property (nonatomic,weak)   UIView         * alertBgView;
@property (nonatomic,weak)   UIView         * btnBgView;

@property (nonatomic,weak)   UILabel        * titleL;
@property (nonatomic,weak)   UILabel        * messageL;

@property (nonatomic,weak)   UIButton       * cancleBtn;
@property (nonatomic,strong) NSMutableArray * otherBtnTitles;
@property (nonatomic,assign) CGFloat          btnHeight;
@property (nonatomic,assign) CGFloat          messageHeight;

@end


@implementation HLAlertView

-(void)setBtnBgColor:(UIColor *)btnBgColor{
    _btnBgColor = btnBgColor;
    _btnBgView.backgroundColor = _btnBgColor;
}
-(void)setBtnTextColor:(UIColor *)btnTextColor{
    _btnTextColor = btnTextColor;
    for (UIView *line in _btnBgView.subviews) {
        if([line isKindOfClass:[UIButton class]]){
            [(UIButton*)line setTitleColor:_btnTextColor forState:UIControlStateNormal];
        }
    }
}
-(void)setRectColor:(UIColor *)rectColor{
    _rectColor = rectColor;
    for (UIView *line in _btnBgView.subviews) {
        if(![line isKindOfClass:[UIButton class]]){
            line.backgroundColor = _rectColor;
        }
    }
}
-(void)dealloc{
    [_bgView removeFromSuperview];
    [_alertBgView removeFromSuperview];
    _bgView = nil;
    
    _alertBgView = nil;
}
+(instancetype)hlAlertWithFrame:(CGRect)frame delegate:(id<HLAlertViewDelegate>)delegate btnHeight:(CGFloat)btnHeight cancleBtnTitle:(NSString*)cancleBtnTitle otherBtnTitle:(NSArray *)otherBtnTitles{
    HLAlertView *alert = [[HLAlertView alloc] initWithFrame:frame delegate:delegate btnHeight:btnHeight cancleBtnTitle:cancleBtnTitle otherBtnTitle:otherBtnTitles];
    return alert;
}
+(instancetype)hlAlertWithFrame:(CGRect)frame delegate:(id<HLAlertViewDelegate>)delegate btnHeight:(CGFloat)btnHeight title:(NSString*)title message:(NSString *)message cancleBtnTitle:(NSString *)cancleBtnTitle otherBtnTitle:(NSArray *)otherBtnTitles{
    HLAlertView *alert = [[HLAlertView alloc] initWithFrame:frame delegate:delegate btnHeight:btnHeight title:title message:message cancleBtnTitle:cancleBtnTitle otherBtnTitle:otherBtnTitles];
    return alert;
}
-(instancetype)initWithFrame:(CGRect)frame delegate:(id<HLAlertViewDelegate>)delegate btnHeight:(CGFloat)btnHeight cancleBtnTitle:(NSString*)cancleBtnTitle otherBtnTitle:(NSArray *)otherBtnTitles{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.delegate = delegate;
        self.btnHeight = btnHeight;
        otherBtnTitles = otherBtnTitles;
        [self createUIWithFrame:frame andBtnHeight:btnHeight];
        [self createBtnWithCancleBtnTitle:cancleBtnTitle andOtherBtnTitles:otherBtnTitles];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame delegate:(id<HLAlertViewDelegate>)delegate btnHeight:(CGFloat)btnHeight title:(NSString*)title message:(NSString *)message cancleBtnTitle:(NSString*)cancleBtnTitle otherBtnTitle:(NSArray *)otherBtnTitles{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.delegate = delegate;
        self.btnHeight = btnHeight;
        otherBtnTitles = otherBtnTitles;
        [self createUIWithFrame:frame andBtnHeight:btnHeight];
        
        [self createTitleLWithTitle:title andMessageLabelWithMessage:message];
        
        [self createBtnWithCancleBtnTitle:cancleBtnTitle andOtherBtnTitles:otherBtnTitles];
        
    }
    return self;
}
-(void)createTitleLWithTitle:(NSString*)title andMessageLabelWithMessage:(NSString*)message{

    CGFloat x,y,w,h;
    if (title.length) {
        x=5;y=5;w=self.contentView.frame.size.width-10;h = 30;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h) text:title font:[UIFont systemFontOfSize:20] textColor:[UIColor blackColor]];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleL = titleLabel;
        [self.contentView addSubview:_titleL];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, _titleL.frame.size.height-1, _titleL.frame.size.width, 1)];
        line.backgroundColor = [UIColor grayColor];
        [_titleL addSubview:line];
        x = 5;  y += h;  w = self.contentView.frame.size.width-10;   h = self.contentView.frame.size.height-10-h;
    }else{
        x = 5;  y = 5;  w = self.contentView.frame.size.width-10;   h = self.contentView.frame.size.height-10;
    }
    
    //messageLabel
    UILabel *messageL = [[UILabel alloc] initWithFrame:ccr(x, y, w, h) text:message font:[UIFont systemFontOfSize:15] textColor:[UIColor blackColor]];
    messageL.numberOfLines = 0;
    self.messageL = messageL;
    [self.contentView addSubview:messageL];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _otherBtnTitles = [[NSMutableArray alloc] init];
    }
    return self;
}
//创建蒙版，alertBgView，btnBgView
-(void)createUIWithFrame:(CGRect)frame andBtnHeight:(CGFloat)btnHeight{
    
    self.backgroundColor = [UIColor clearColor];
    UIView *tBgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    tBgView.backgroundColor = [UIColor blackColor];
    tBgView.alpha = 0.7;
    _bgView = tBgView;
    [self addSubview:_bgView];
    
    UIView *tAlertBgView = [[UIView alloc] initWithFrame:frame];
    tAlertBgView.center = _bgView.center;
    tAlertBgView.backgroundColor = [UIColor whiteColor];
    tAlertBgView.layer.cornerRadius = 6;
    tAlertBgView.layer.masksToBounds = YES;
    _alertBgView = tAlertBgView;
    [self addSubview:_alertBgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [_bgView addGestureRecognizer:tap];
    
    UIView *tContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-btnHeight)];
    _contentView = tContentView;
    [_alertBgView addSubview:_contentView];
    
    UIView *tBtnBgView = [[UIView alloc] initWithFrame:CGRectMake(0, _alertBgView.height-btnHeight, _alertBgView.width, btnHeight)];
    _btnBgView = tBtnBgView;
    [_alertBgView addSubview:tBtnBgView];
}
//创建btn
-(void)createBtnWithCancleBtnTitle:(NSString *)cancleBtnTitle andOtherBtnTitles:(NSArray*)otherBtnTitles{
    if (otherBtnTitles.count) {
        [self createCancleBtnWithFrame:CGRectMake(0, 0, _btnBgView.width/(otherBtnTitles.count+1), _btnBgView.height) title:cancleBtnTitle];
        [self createOtherBtnWithTitles:otherBtnTitles];
    }else{
        [self createCancleBtnWithFrame:CGRectMake(0, 0, _btnBgView.width, _btnBgView.height) title:cancleBtnTitle];
    }
    UIView *hLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _alertBgView.width, 1)];
    hLine.backgroundColor = rgb(160, 160, 160, 1);
    [_btnBgView addSubview:hLine];
    
}
//创建取消按钮
-(void)createCancleBtnWithFrame:(CGRect)frame title:(NSString *)title{
    UIButton *tCancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tCancleBtn.frame = frame;
    tCancleBtn.tag = 12000;
    tCancleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [tCancleBtn setTitle:title forState:UIControlStateNormal];
    [tCancleBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [tCancleBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.cancleBtn = tCancleBtn;
    [_btnBgView addSubview:tCancleBtn];
}
//创建其他按钮
-(void)createOtherBtnWithTitles:(NSArray *)otherBtnTitles{
    for (int i = 0; i < otherBtnTitles.count; i++) {
        
        UIButton *otherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        otherBtn.frame = CGRectMake(_btnBgView.width/(otherBtnTitles.count+1)*(i+1), 0, _btnBgView.width/(otherBtnTitles.count+1), _btnBgView.height);
        [otherBtn setTitle:[otherBtnTitles objectAtIndex:i] forState:UIControlStateNormal];
        [otherBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        otherBtn.tag = 12001+i;
        
        [otherBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_btnBgView addSubview:otherBtn];
        
        UIView *vline = [[UIView alloc] initWithFrame:CGRectMake(otherBtn.left-1, 0, 1, _btnHeight)];
        vline.backgroundColor = rgb(160, 160, 160, 1);
        [_btnBgView addSubview:vline];
        
    }
}


//alert显示和隐藏
-(void)alertShow{
    [[UIApplication sharedApplication].delegate.window addSubview:self];
}
-(void)alertHidden{
    [self removeFromSuperview];
}
-(void)alertShowInView:(UIView *)view{
    [view addSubview:self];
}
//按钮点击事件
-(void)btnClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(hlAlertView:didClickedBtnAtIndex:)]) {
        [self.delegate hlAlertView:self didClickedBtnAtIndex:btn.tag-12000];
    }
    [self alertHidden];
}
//点击蒙版隐藏
-(void)tapClick:(UITapGestureRecognizer *)tap{
    [self alertHidden];
}
@end
