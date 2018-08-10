//
//  HLZheDieView.m
//  AnimationDemo
//
//  Created by Zhl on 2017/3/24.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import "HLZheDieView.h"

@interface HLZheDieView ()
@property (nonatomic,weak) UIView *switchBgView;
@end

@implementation HLZheDieView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.state = HLZheDieViewAnimationSate_zhankai;
        UIView *backGroundView = [[UIView alloc] init];
        backGroundView.backgroundColor = [UIColor blackColor];
        backGroundView.alpha   = 0;
        backGroundView.frame   = self.bounds;
        self.backGroundView    = backGroundView;
        [self addSubview:self.backGroundView];
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollView.delegate      = self;
        scrollView.contentSize   = CGSizeMake(frame.size.width*2, 0);
        scrollView.pagingEnabled = YES;
        scrollView.bounces       = NO;
        self.scrollView = scrollView;
        
        [self addSubview:self.scrollView];
        
        
        NSArray *imgNames = @[@"test",@"test2",@"test",@"test2",@"test"];
        
        __weak HLZheDieView *weakThis = self;
        CGFloat x,y,w,h;
        x = 0,  h = frame.size.width/(imgNames.count-0.5),  y = frame.size.height-h,  w = frame.size.width;
        HLAnimationView *aniView = [[HLAnimationView alloc] initWithFrame:CGRectMake(x, y, w, h) andImgNames:imgNames];
        
        //item（0-4）被点击回调
        [aniView setItemClickedAtIndex:^(NSInteger index) {
            if ([weakThis.delegate respondsToSelector:@selector(HLZheDieViewItemClickedAtIndex:)]) {
                [weakThis.delegate HLZheDieViewItemClickedAtIndex:index];
            }
        }];
        aniView.backgroundColor = [UIColor greenColor];
        self.aniView = aniView;
        [self.scrollView addSubview:self.aniView];
        
        x=frame.size.width,w=frame.size.width,h=frame.size.height,y=(frame.size.height-h)/2.0;
        HLRightView *rightView = [[HLRightView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        //rightItem(4----)被点击回调
        [rightView setRightItemClickedAtIndex:^(NSInteger index) {
            if ([weakThis.delegate respondsToSelector:@selector(HLZheDieViewItemClickedAtIndex:)]) {
                [weakThis.delegate HLZheDieViewItemClickedAtIndex:index];
            }
        }];
        rightView.backgroundColor = [UIColor clearColor];
        self.rightView = rightView;
        [self.scrollView addSubview:self.rightView];
        
        UIView *switchBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 30)];
        switchBgView.backgroundColor = [UIColor redColor];
        switchBgView.alpha           = 0;
        
        UIButton *switchStateBtn     = [UIButton buttonWithType:UIButtonTypeCustom];
        switchStateBtn.backgroundColor = [UIColor cyanColor];
        switchStateBtn.frame = CGRectMake(0, 0, frame.size.width, 30);
        switchStateBtn.alpha = 0;
        [switchStateBtn setTitle:@"-- 点击发现更多精彩 --" forState:UIControlStateNormal];
        [switchStateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [switchStateBtn addTarget:self action:@selector(switchStateBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        self.switchStateBtn = switchStateBtn;
        self.switchBgView   = switchBgView;
        [self addSubview:switchBgView];
        [self addSubview:switchStateBtn];
        
        
    }
    return self;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x>0) {
        self.frame = CGRectMake(0, self.superview.frame.size.height-250-_offsetY, self.frame.size.width, 250);
    }else{
        self.frame = CGRectMake(0, (self.superview.frame.size.height) -self.frame.size.width/4.5-_offsetY, self.frame.size.width, self.frame.size.width/4.5);
    }
    [self updateFrame];
    [self.aniView update3DTransationWithOffsetX:scrollView.contentOffset.x];
    self.backGroundView.alpha = scrollView.contentOffset.x/scrollView.frame.size.width*0.6;
    
}
-(void)updateFrame{
    
    self.backGroundView.frame = self.bounds;
    self.scrollView.frame = self.bounds;
    
    CGFloat x,y,w,h;

    w = self.scrollView.frame.size.width,
    h = self.scrollView.frame.size.width/4.5,
    x = 0,
    y = self.scrollView.frame.size.height-h;
    self.aniView.frame = CGRectMake(x, y, w, h);
 
    w=self.scrollView.frame.size.width,
    h=self.scrollView.frame.size.height,
    x=self.scrollView.frame.size.width,
    y=(self.scrollView.frame.size.height-h)/2.0;
    self.rightView.frame = CGRectMake(x, y, w, h);
    
    self.switchStateBtn.frame = CGRectMake(0, 0, self.frame.size.width, 30);
}
-(void)setState:(HLZheDieViewAnimationSate)state{
    if (_state != state) {
        _state = state;
        
        if (state == HLZheDieViewAnimationSate_zhankai) {
            [self.switchStateBtn.layer removeAnimationForKey:@"aAlpha"];
            [UIView animateWithDuration:0.25 animations:^{
                self.switchStateBtn.alpha = 0;
                self.switchBgView.alpha = 0;
                self.frame = CGRectMake(0, (self.superview.frame.size.height) -self.frame.size.width/4.5-_offsetY, self.frame.size.width, self.frame.size.width/4.5);
                [self updateFrame];
            } completion:^(BOOL finished) {
                
            }];
            
        }else if (state == HLZheDieViewAnimationSate_shouqi){
            
            [UIView animateWithDuration:0.25 animations:^{
                self.switchStateBtn.alpha = 1;
                self.switchBgView.alpha = 1;
                self.frame = CGRectMake(0, (self.superview.frame.size.height) -30-_offsetY, self.frame.size.width, 30);
                [self updateFrame];
            } completion:^(BOOL finished) {
                self.scrollView.contentOffset = CGPointMake(0, 0);
                self.frame = CGRectMake(0, (self.superview.frame.size.height) -30-_offsetY, self.frame.size.width, 30);
                [self.switchStateBtn.layer addAnimation:[self AlphaLight:1.5] forKey:@"aAlpha"];
            }];
        }
    }
}
-(void)switchStateBtnClicked:(UIButton*)btn{
    self.state = HLZheDieViewAnimationSate_zhankai;
}
//添加呼吸灯动画
-(CABasicAnimation *) AlphaLight:(float)time
{
    CABasicAnimation *animation =[CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue   = [NSNumber numberWithFloat:0.5f];//这是透明度。
    animation.autoreverses = YES;
    animation.duration     = time;
    animation.repeatCount  = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    return animation;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
