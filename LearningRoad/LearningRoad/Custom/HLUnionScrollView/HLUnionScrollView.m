//
//  UnionScrollView.m
//  ScrollViewDemo
//
//  Created by Zhl on 16/6/15.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import "HLUnionScrollView.h"
#define HLUnionScrollViewItemWidth (([UIScreen mainScreen].bounds.size.width+4)/4.0)
#define HLUnionScrollViewTitleSegHeight 40
#define HLUnionScrollViewSeparateLienHeight 5
@interface HLUnionScrollView ()<UIScrollViewDelegate,HLSegmentControlDelegate>
{
    NSInteger maxIndex;
    NSInteger minIndex;
    NSInteger showNum;
}
@property (nonatomic,weak)HLSegmentControl *segmentControl;
@property (nonatomic,weak)UIScrollView *titleScrollView;
@property (nonatomic,weak)UIScrollView *scrollView;
@property (nonatomic,assign)NSInteger itemCount;
@property (nonatomic,assign)NSInteger currentIndex;
@end

@implementation HLUnionScrollView

+(instancetype)hlUnionScrollViewWithFrame:(CGRect)frame andItems:(NSArray *)items{
    HLUnionScrollView *uniScrollView = [[HLUnionScrollView alloc] initWithFrame:frame andItems:items];
    return uniScrollView;
}
- (instancetype)initWithFrame:(CGRect)frame andItems:(NSArray *)items
{
    self = [super initWithFrame:frame];
    if (self) {
        _itemCount =items.count;
        CGFloat x = 0,y=0,w=frame.size.width,h=HLUnionScrollViewTitleSegHeight+HLUnionScrollViewSeparateLienHeight;
        //titleScrollView
        UIScrollView *titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        titleScrollView.delegate = self;
        titleScrollView.contentSize = CGSizeMake(HLUnionScrollViewItemWidth*_itemCount, 0);
        titleScrollView.showsHorizontalScrollIndicator = NO;
        titleScrollView.bounces = NO;
        _titleScrollView = titleScrollView;
        [self addSubview:_titleScrollView];

        //
        w=HLUnionScrollViewItemWidth*_itemCount;
        h=HLUnionScrollViewTitleSegHeight;
        HLSegmentControl *segmentControl = [HLSegmentControl HLSegmentControlWithFrame:CGRectMake(x, y, w,h) andItems:items andItemFont:[UIFont systemFontOfSize:14]];
        segmentControl.delegate =self;
        segmentControl.selectedIndex = 0;
        segmentControl.displayRect = YES;
        segmentControl.rectColor = [UIColor grayColor];
        _segmentControl = segmentControl;
        [_titleScrollView addSubview:segmentControl];
        
        UIView *separateView = [[UIView alloc] initWithFrame:CGRectMake(0, h, self.frame.size.width, HLUnionScrollViewSeparateLienHeight)];
        separateView.backgroundColor = [self rgb:220 g:221 b:221 a:1.0];
        [self addSubview:separateView];
        [_titleScrollView addSubview:segmentControl];
        
        y=HLUnionScrollViewTitleSegHeight+HLUnionScrollViewSeparateLienHeight,h=frame.size.height-HLUnionScrollViewTitleSegHeight-HLUnionScrollViewSeparateLienHeight,w=frame.size.width;
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        scrollView.contentSize = CGSizeMake(w*_itemCount, h);
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        scrollView.delegate = self;
        _scrollView = scrollView;
        [self addSubview:scrollView];
        
        for (int i = 0; i<_itemCount; i++) {
            x=i*frame.size.width,y=0,w=frame.size.width,h=frame.size.height-HLUnionScrollViewTitleSegHeight-HLUnionScrollViewSeparateLienHeight;
            ContentView *view = [[ContentView alloc] initWithFrame:CGRectMake(x, y, w, h)];
            view.backgroundColor = [UIColor colorWithRed:arc4random()%255/256.0 green:arc4random()%255/256.0 blue:arc4random()%255/256.0 alpha:1];
            [scrollView addSubview:view];
            view.tag = 3100+i;
        }
        NSInteger w1 = (NSInteger)self.frame.size.width;
        NSInteger w2 = (NSInteger)HLUnionScrollViewItemWidth;
        showNum = w1%w2>0?w1/w2+1:w1/w2;
        minIndex = 0;
        maxIndex = showNum-1;
    }
    return self;
}
-(void)setHeaderView:(UIView *)headerView{
    _headerView = headerView;
    _headerView.frame = CGRectMake(0, 0, headerView.frame.size.width, headerView.frame.size.height);
    [self addSubview:_headerView];
    self.contentSize = CGSizeMake(0, self.frame.size.height+headerView.frame.size.height);
    //headerView
    CGFloat x,y,w,h;
    x = 0,  y = 0,  w = SCREEN_WIDTH,   h = headerView.frame.size.height;
    y += h;
    
    CGRect frame = _titleScrollView.frame;
    frame.origin.y = y;
    _titleScrollView.frame = frame;
    
    h=frame.size.height,
    y+=h;
    frame = _scrollView.frame;
    frame.origin.y = y;
    _scrollView.frame = frame;
}
-(void)segmentControlDidSelectedIndex:(NSInteger)index{
    self.currentIndex = index;
}
-(void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    if (_currentIndex==maxIndex&&maxIndex<_itemCount-1) {
        maxIndex++;
        minIndex++;
        [self.titleScrollView setContentOffset:CGPointMake(minIndex*HLUnionScrollViewItemWidth, 0) animated:YES];
    }else if (_currentIndex == minIndex&&minIndex>0){
        minIndex--;
        maxIndex--;
        [self.titleScrollView setContentOffset:CGPointMake(minIndex*HLUnionScrollViewItemWidth, 0) animated:YES];
    }
    CGFloat w = self.frame.size.width;
    [self.scrollView setContentOffset:CGPointMake(w*_currentIndex, 0) animated:YES];
//    NSLog(@"_itemCount = %ld",_itemCount);
//    NSLog(@"showNum = %ld",showNum);
//    NSLog(@"max = %ld",maxIndex);
//    NSLog(@"min = %ld",minIndex);
    ContentView *view = (ContentView*)[_scrollView viewWithTag:3100+_currentIndex];
    if ([self.hlDelegate respondsToSelector:@selector(ct_titleSegmentDidClickIndex:curentView:)]) {
        [self.hlDelegate ct_titleSegmentDidClickIndex:_currentIndex curentView:view];
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == _scrollView) {
        NSInteger index = scrollView.contentOffset.x/self.frame.size.width;
        CGFloat tempF = 0;
        if (index>_currentIndex) {//左滑
            maxIndex = index>maxIndex?index:maxIndex;
            minIndex = maxIndex-showNum+1;
        }else if(index<_currentIndex){//右滑
            minIndex = index<minIndex?index:minIndex;
            maxIndex = minIndex+showNum-1;
        }else{
            
        }
        CGFloat temp= minIndex*HLUnionScrollViewItemWidth+tempF;
        [_titleScrollView setContentOffset:CGPointMake(temp, 0)];
        self.currentIndex = index;
        _segmentControl.selectedIndex = _currentIndex;
        
    }else if(scrollView==_titleScrollView){
        NSInteger  w1 = (NSInteger)scrollView.contentOffset.x;
        NSInteger  w2 = (NSInteger)HLUnionScrollViewItemWidth;
        if (_itemCount-minIndex>showNum) {
            minIndex = w1%w2>0?w1/w2+1:w1/w2;
            maxIndex = minIndex+showNum-1;
        }
        
    }
    NSLog(@"_itemCount = %ld",_itemCount);
    NSLog(@"showNum = %ld",showNum);
    NSLog(@"max = %ld",maxIndex);
    NSLog(@"min = %ld",minIndex);
}





-(void)hl_currentViewAddView:(UIView *)view withIndex:(NSInteger)index{

    ContentView *currentView = (ContentView*)[_scrollView viewWithTag:3100+index];
    [currentView addSubview:view];
}
-(void)hl_currentViewAddContentTableView:(id<UITableViewDataSource,UITableViewDelegate>)tableViewDelegate firstTag:(NSInteger)firstTag{
    for (int i =0; i<_itemCount; i++) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-45) style:UITableViewStylePlain];
        tableView.delegate = tableViewDelegate;
        tableView.dataSource = tableViewDelegate;
        tableView.tag = firstTag+i;
        tableView.backgroundColor = [UIColor clearColor];
        ContentView *currentView = (ContentView*)[_scrollView viewWithTag:3100+i];
        currentView.tableView = tableView;
        [currentView addSubview:tableView];
    }
}
-(void)hl_allViewAddView:(UIView *)view{
    for (int i = 0; i < _itemCount; i++) {
        [self hl_currentViewAddView:[self duplicate:view] withIndex:i];
    }
}
//实现对象的copy，由原对象生成新对象
- (UIView*)duplicate:(UIView*)view
{
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}
-(UIColor*)rgb:(NSInteger)r g:(NSInteger)g b:(NSInteger)b a:(CGFloat)alpha{
   return [UIColor colorWithRed:r%256/256.0 green:g%256/256.0 blue:b%256/256.0 alpha:alpha];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
@implementation ContentView


@end
