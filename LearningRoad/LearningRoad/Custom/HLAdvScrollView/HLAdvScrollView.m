//
//  HLAdvScrollView.m
//  codeDemo
//
//  Created by Zhl on 16/7/6.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import "HLAdvScrollView.h"
#import "NSTimer+CTPackage.h"
@interface HLAdvScrollView ()<UIScrollViewDelegate>
@property(nonatomic,weak)UIScrollView *scrollView;
@property(nonatomic,assign)NSInteger currentPage;
@property(nonatomic,assign)NSInteger count;
@property(nonatomic,strong)NSTimer *timmer;
@property (nonatomic,weak)UIPageControl *pageControl;
@property (nonatomic,weak) UIControl *control;
/**
 *  换页时间间隔
 */
@property(nonatomic,assign)NSInteger timesInterval;
/**
 *  换页动画执行时间
 */
@property(nonatomic,assign)NSInteger animateDuration;
@end

@implementation HLAdvScrollView
-(void)dealloc{
    [_timmer invalidate];
    _timmer = nil;
}
- (instancetype)initWithFrame:(CGRect)frame images:(NSArray*)images timesInterval:(NSInteger)timesInterval andAnimateDureation:(NSInteger)animateDuration addToRunloop:(BOOL)isYesOrNo delegate:(id<HLAdvScrollViewDelegate>)delegate;
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = delegate;
        self.timesInterval = timesInterval;
        self.animateDuration = animateDuration;
        CGFloat x=0,y=0,w=self.frame.size.width,h=self.frame.size.height;
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        scrollView.delegate = self;
        w=(images.count+2)*w,h=0;
        self.currentPage = 0;
        self.count = images.count;
        scrollView.contentSize = CGSizeMake(w, 0);
        scrollView.pagingEnabled = YES;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        for (int i = 0; i<images.count+2; i++) {
            UIImage *img = nil;
            w=self.frame.size.width,h=self.frame.size.height,y=0,x=w*(i-1);;
            if (i==0) {
                x=-w;
                img = [UIImage imageNamed:[images lastObject]];
            }else if (i==images.count+1){
                img = [UIImage imageNamed:[images firstObject]];
            }else{
                img = [UIImage imageNamed:[images objectAtIndex:i-1]];
            }
            
            UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
            imgV.userInteractionEnabled = YES;
            imgV.image = img;
            [self.scrollView addSubview:imgV];
            
            UIControl *control = [[UIControl alloc] initWithFrame:imgV.bounds];
            [control addTarget:self action:@selector(imgVClicked:) forControlEvents:UIControlEventTouchUpInside];
            control.tag = 3500+i;
            [imgV addSubview:control];
        }

        w=200,h=10,x=self.frame.size.width/2.0-w/2.0,
        y=self.frame.size.height-h-10;
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.frame = CGRectMake(x, y, w, h);
        pageControl.currentPage = 0;
        pageControl.numberOfPages = self.count;
        pageControl.backgroundColor = [UIColor clearColor];
        pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        [self addSubview:pageControl];
        _pageControl = pageControl;
        _timmer = [NSTimer scheduledTimerWithTimeInterval:self.timesInterval target:self selector:@selector(changePage) userInfo:nil repeats:YES];
        if (isYesOrNo) {
            [[NSRunLoop currentRunLoop] addTimer:_timmer forMode:NSRunLoopCommonModes];
        }
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat x=0,y=0,w=self.frame.size.width,h=self.frame.size.height;
    self.scrollView.frame = ccr(x, y, w, h);
    for (UIView *view in self.scrollView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            CGRect frame = view.frame;
            frame.size.height = _scrollView.height;
            view.frame = frame;
        }
    }
    w=200,h=10,x=self.frame.size.width/2.0-w/2.0,
    y=self.frame.size.height-h-10;
    _pageControl.frame = ccr(x, y, w, h);
}

-(void)imgVClicked:(UIControl*)control{
    if ([self.delegate respondsToSelector:@selector(hlAdvScrollView:ClickedImgVAtIndex:)]) {
        NSLog(@"%ld",control.tag);
        [self.delegate hlAdvScrollView:self ClickedImgVAtIndex:control.tag-3500];
    }
}





-(void)changePage{
    _currentPage++;
    
    if (_currentPage==_count) {
        [self.scrollView setContentOffset:CGPointMake(-self.frame.size.width, 0)];
        _currentPage=0;
    }
    _pageControl.currentPage = _currentPage;
    CGFloat x = _currentPage*self.frame.size.width,y=0;
    [UIView animateWithDuration:_animateDuration animations:^{
        [self.scrollView setContentOffset:CGPointMake(x, y)];
    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x<0) {
        _currentPage = _count-1;
        self.scrollView.contentOffset = CGPointMake(_count*self.frame.size.width, 0);
    }

}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_timmer ct_pauseTimer];
}
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    [_timmer ct_resumeTimerAfterTimeInterval:_timesInterval];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    _currentPage = (NSInteger)(scrollView.contentOffset.x/self.frame.size.width);
    if (_currentPage >= _count) {
        _currentPage = 0;
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }
    _pageControl.currentPage = _currentPage;
}
-(void)hl_pauseTimer{
    [_timmer ct_pauseTimer];
}
-(void)hl_resumeTime{
    [_timmer ct_resumeTimerAfterTimeInterval:_timesInterval];
}

@end
