//
//  EditingInputBar.m
//  HandicapWin
//
//  Created by CH10 on 16/4/27.
//  Copyright © 2016年 赢盘. All rights reserved.
//

#import "EditingInputBar.h"
#import "ReadLocalData.h"
#import "FacePageView.h"

@interface EditingInputBar () <UIScrollViewDelegate, FaceViewDelegate> {
    UIScrollView    *_scrollView;
    UIPageControl   *_pageControl;
}

@property (nonatomic, strong) NSMutableArray       *faceImgArray;

@end

@implementation EditingInputBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = kRGB(54, 56, 60);
        self.backgroundColor = rgb(250, 250, 250, 1);
        ReadLocalData *dataUtil = [ReadLocalData defaultReadLocalData];
        _faceImgArray = [[dataUtil getFaceImgArray] mutableCopy];
        
        [self initialize];
    }
    return self;
}


-(void) hideAtBtn {
    self.atBtn.hidden = YES;
}

- (void)initialize
{
    CGFloat x = 10, y = 2, w = PostingBarHeight, h = PostingBarHeight;

    UIButton *albumsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    albumsBtn.frame = ccr(x, y, w, h);
    UIImage *img = [UIImage imageNamed:@"keyboard_Picture"];
    [albumsBtn setImage:img forState:UIControlStateNormal];
    [albumsBtn addTarget:self action:@selector(albumsBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:albumsBtn];
    
    x = albumsBtn.frame.origin.x + albumsBtn.frame.size.width + 10;
    UIButton *faceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    faceBtn.frame = ccr(x, y, w, h);
    img = [UIImage imageNamed:@"smile"];
    [faceBtn setImage:img forState:UIControlStateNormal];
    img = [UIImage imageNamed:@"keyboard"];
    [faceBtn setImage:img forState:UIControlStateSelected];
    [faceBtn addTarget:self action:@selector(faceBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:faceBtn];
    
    self.faceBtn = faceBtn;
    
    x = faceBtn.frame.origin.x + faceBtn.frame.size.width + 10;
    UIButton *atBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    atBtn.frame = ccr(x, y, w, h);
    img = [UIImage imageNamed:@"keyBoard_At"];
    [atBtn setImage:img forState:UIControlStateNormal];
//    img = [UIImage imageNamed:@"keyboard_btn.png"];
    [atBtn setImage:img forState:UIControlStateSelected];
    [atBtn addTarget:self action:@selector(atBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:atBtn];
    self.atBtn = atBtn;
    
    x = atBtn.frame.origin.x+faceBtn.frame.size.width+10;
    UIButton *walletBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    walletBtn.frame = ccr(x, y, w, h);
    img = [UIImage imageNamed:@"keyboard_wallet"];
    [walletBtn setImage:img forState:UIControlStateNormal];
    //    img = [UIImage imageNamed:@"keyboard_btn.png"];
    [walletBtn setImage:img forState:UIControlStateSelected];
    [walletBtn addTarget:self action:@selector(walletBtnClicked) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:walletBtn];
    self.walletBtn = walletBtn;
    
    UIView *hline1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    UIView *hline2 = [[UIView alloc] initWithFrame:CGRectMake(0, walletBtn.bottom+2, SCREEN_WIDTH, 0.5)];
    hline1.backgroundColor = rgb(220, 221, 221, 1);
    hline2.backgroundColor = rgb(220, 221, 221, 1);
    [self addSubview:hline1];
    [self addSubview:hline2];
    NSInteger page = [self.faceImgArray count]%20 == 0 ? [self.faceImgArray count]/20 : [self.faceImgArray count]/20 + 1;
    
    x = 0, y = PostingBarHeight, w = self.frame.size.width, h = FaceViewHeight;
    _scrollView=[[UIScrollView alloc] initWithFrame:ccr(x, y, w, h)];
    [_scrollView setContentSize:CGSizeMake(page*w, h)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate=self;
    _scrollView.backgroundColor = [UIColor clearColor];
    [self addSubview:_scrollView];
    
    y = 20, h = 160;
    for (int k = 0; k < page; k++) {
        x = k * w;
        FacePageView *pageView = [[FacePageView alloc] initWithFrame:ccr(x, y, w, h) withPage:k];
        pageView.delegate = self;
        pageView.tag = 1000+k;
        [_scrollView addSubview:pageView];
    }
    x = (SCREEN_WIDTH-120)/2.0, y = y + h + 30, w = 120, h = 24;
    _pageControl=[[UIPageControl alloc] initWithFrame:ccr(x, y, w, h)];
    _pageControl.numberOfPages = page;
    _pageControl.pageIndicatorTintColor = rgb(175, 175, 175, 1);
    _pageControl.currentPageIndicatorTintColor = rgb(116, 116, 116, 1);
    _pageControl.backgroundColor = [UIColor clearColor];
    [_pageControl addTarget:self action:@selector(pageControlClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_pageControl];
}

- (void)albumsBtnClicked
{
    
//    [self editingBarMoveToBottom];
    [self.delegate goAlbum];
}


-(void) atBtnClicked {
    [self.delegate goAtFriends];
}

- (void)faceBtnClicked
{
    self.faceBtn.selected = !self.faceBtn.selected;
    [self.delegate faceBtnClicked:self.faceBtn];
}
-(void)walletBtnClicked{
    
}
- (void)setImgs {
    NSInteger page = [self.faceImgArray count]%20 == 0 ? [self.faceImgArray count]/20 : [self.faceImgArray count]/20 + 1;
    for (int i = 0; i < page; i++) {
        
        FacePageView *pageView = [_scrollView viewWithTag:1000+i];
        [pageView setImgsWithPage:i];
    }
}
#pragma mark - UIScrollView Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [_pageControl setCurrentPage:scrollView.contentOffset.x/scrollView.frame.size.width];
}

#pragma mark - UIPageControl Delegate

- (void)pageControlClick:(UIPageControl *)pageControl
{
    NSInteger page = pageControl.currentPage;
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width*page, 0) animated:YES];
}


#pragma mark -- faceView delegate
- (void)controlScroll:(NSInteger)curIndex
{
    if (curIndex == 1) {
        _scrollView.scrollEnabled = YES;
    }else{
        _scrollView.scrollEnabled = NO;
    }
}

- (void)faceSelectedName:(NSString *)nameStr
{
    [self.delegate faceWasSelectedName:nameStr];
}


//代理里面的删除函数

- (void)faceDeleteClick
{
    [self.delegate deleteBtnClicked];
}
-(void)editingBarMoveToBottom{
    [self.inputView resignFirstResponder];
    CGRect frame = self.frame;
    frame.origin.y = SCREEN_WIDTH-64;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = frame;
    } completion:^(BOOL finished) {
        //        _editingSwitch.hidden = NO;
        //        [self setNeedsLayout];
    }];
}
@end
