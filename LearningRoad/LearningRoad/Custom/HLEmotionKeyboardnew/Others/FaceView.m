//
//  FaceView.m
//  BBSDemo
//
//  Created by Zhl on 2017/9/4.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import "FaceView.h"

#import "ReadLocalData.h"
@interface FaceView ()<UIScrollViewDelegate,FaceViewDelegate>{
    NSInteger _numberOfPages;//总页数
}
@property (nonatomic,weak) UIScrollView *contentView;
@property (nonatomic,weak) UIPageControl *pageControl;
@property (nonatomic,weak) id<FaceViewDelegate> delegate;
@end

@implementation FaceView
+ (instancetype)faceViewWithPoint:(CGPoint)point andDelegate:(id<FaceViewDelegate>)delegate {
    FaceView *faceView = [[FaceView alloc] initWithFrame:CGRectMake(point.x, point.y, [UIScreen mainScreen].bounds.size.width, FaceViewHeight)];
    faceView.delegate = delegate;
    return faceView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        ReadLocalData *dataUtil = [ReadLocalData defaultReadLocalData];
        
        //异步读取图片并存储
        [dataUtil initImgsArr];
        
        //计算表情总页数
        NSInteger faceImgArrayCount = [dataUtil getFaceImgArray].count;
        _numberOfPages = faceImgArrayCount%20 == 0 ? faceImgArrayCount/20 : faceImgArrayCount/20 + 1;
        
        [self p_createSubViews];
    }
    return self;
}

//当首次弹出表情view时加载第一页图片
- (void)setImgsWithPage:(NSInteger)page {
    FacePageView *pageView = [_contentView viewWithTag:1000+page];
    [pageView setImgsWithPage:page];
}


#pragma mark - Private Methods
//创建子空间
- (void)p_createSubViews {
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.showsHorizontalScrollIndicator = NO;
    contentView.pagingEnabled = YES;
    contentView.delegate=self;
    contentView.delegate = self;
    self.contentView = contentView;
    [self addSubview:_contentView];
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl=[[UIPageControl alloc] init];
    pageControl.numberOfPages = _numberOfPages;
    pageControl.pageIndicatorTintColor = rgb(175, 175, 175, 1);
    pageControl.currentPageIndicatorTintColor = rgb(116, 116, 116, 1);
    pageControl.backgroundColor = [UIColor clearColor];
    [pageControl addTarget:self action:@selector(pageControlClick:) forControlEvents:UIControlEventTouchUpInside];
    self.pageControl = pageControl;
    [self addSubview:_pageControl];
    
    self.contentView.frame = CGRectMake(0, self.frame.size.height - FaceViewHeight, self.frame.size.width, FaceViewHeight);
    self.contentView.contentSize = CGSizeMake(_numberOfPages*self.contentView.frame.size.width, 0);
    CGFloat x,y,w,h;
    x = 0; y = 20; h = 160;w=self.contentView.frame.size.width;
    for (int i = 0; i < _numberOfPages; i++) {
        x = i * w;
        FacePageView *pageView = [[FacePageView alloc] initWithFrame:ccr(x, y, w, h) withPage:i];
        pageView.tag = i+1000;
        pageView.delegate = self;
        [_contentView addSubview:pageView];
    }
    self.pageControl.frame = CGRectMake((self.frame.size.width-120)/2.0, 180, 120, 24);
}


#pragma mark - Actions
- (void)pageControlClick:(UIPageControl*)pageControl {
    NSInteger page = pageControl.currentPage;
    [_contentView setContentOffset:CGPointMake(_contentView.frame.size.width*page, 0) animated:YES];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x/scrollView.frame.size.width;
    _pageControl.currentPage = page;
    if (page<_numberOfPages) {
        [self setImgsWithPage:page];
    }
}


#pragma mark -- FacePageView delegate
- (void)controlScroll:(NSInteger)curIndex {
    if (curIndex == 1) {
        _contentView.scrollEnabled = YES;
    } else {
        _contentView.scrollEnabled = NO;
    }
}

- (void)faceSelectedName:(NSString *)nameStr {
    if ([self.delegate respondsToSelector:@selector(faceSelectedName:)]) {
        [self.delegate faceSelectedName:nameStr];
    }
}

//代理里面的删除函数
- (void)faceDeleteClick {
    if ([self.delegate respondsToSelector:@selector(faceDeleteClick)]) {
        [self.delegate faceDeleteClick];
    }
}
@end
