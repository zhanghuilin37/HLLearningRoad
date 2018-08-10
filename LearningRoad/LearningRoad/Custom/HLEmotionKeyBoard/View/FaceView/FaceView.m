//
//  FaceView.m
//  demo
//
//  Created by Zhl on 16/9/26.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import "FaceView.h"
#import "ReadLocalData.h"
#import "FacePageView.h"
#import "FacePackageView.h"
#define FaceImgCellIdentifier @"FaceImgCellIdentifier"
#define FaceViewHeight
#define cellSpaceWidth 5
#define cellWidth ([UIScreen mainScreen].bounds.size.width-40)/7.0
@interface FaceView ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView *faceScrollView;
@property (nonatomic,strong)UIPageControl *pageControl;
@property (nonatomic,strong)FacePackageView *facePackageView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger packageIndex;
@end

@implementation FaceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.faceScrollView];
        [self addSubview:self.pageControl];
        [self addSubview:self.facePackageView];
        self.packageIndex = 0;
    }
    return self;
}
#pragma mark - setter and getter methods
-(void)setPackageIndex:(NSInteger)packageIndex{
    if (packageIndex == 0) {
        for (int i = 0; i<self.dataArray.count; i++) {
            CGFloat x=self.width*i,y=0,w=self.width,h=self.height-10;
            CGRect frame = CGRectMake(x, y, w, h);
            NSArray *arr = [self.dataArray objectAtIndex:i];
            FacePageView *fpView = [[FacePageView alloc] initWithFrame:frame FaceImgArray:arr];
            __weak FaceView *this = self;
            [fpView setFaceDic:^(NSDictionary *faceDic) {
                if (this.faceName!=nil) {
                    NSString *str = [faceDic objectForKey:@"chs"];
                    this.faceName(str);
                }
            }];
            [fpView setFaceDeleteClick:^{
                if (this.faceDeleteClick!=nil) {
                    this.faceDeleteClick();
                }
            }];
            [_faceScrollView addSubview:fpView];
        }
    }else{
        for (UIView *view in self.faceScrollView.subviews) {
            if ([view isKindOfClass:[FacePageView class]]) {
                [view removeFromSuperview];
            }
        }
    }
}
-(UIScrollView *)faceScrollView{
    if (_faceScrollView == nil) {
        _faceScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height-20-40)];
        _faceScrollView.delegate = self;
        _faceScrollView.contentSize = CGSizeMake(self.width*self.dataArray.count, 0);
        _faceScrollView.bounces = NO;
        _faceScrollView.pagingEnabled = YES;
    }
    return _faceScrollView;
}
-(FacePackageView *)facePackageView{
    if (_facePackageView == nil) {
        _facePackageView = [[FacePackageView alloc] initWithFrame:CGRectMake(0, self.pageControl.bottom, self.width, 40)];
        __weak FaceView *this = self;
        [_facePackageView setPackageClickedIndex:^(NSInteger index) {
            this.packageIndex = index;
        }];
    }
    return _facePackageView;
}
-(UIPageControl *)pageControl{
    if (_pageControl == nil) {
        CGFloat w = self.width,h=20,x=0,y=self.height-h-40;
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _pageControl.numberOfPages = self.dataArray.count;
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    }
    return _pageControl;
}
-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        ReadLocalData *readLocalData = [ReadLocalData defaultReadLocalData];
        _dataArray = [[NSMutableArray alloc] initWithArray:[readLocalData getGroupedFaceImgArray]];
    }
    return _dataArray;
}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger page = (NSInteger)scrollView.contentOffset.x/scrollView.width;
    self.pageControl.currentPage = page;
}
@end
