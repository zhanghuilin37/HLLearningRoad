//
//  HLBaseTableView.m
//  HLBaseTableViewDemo
//
//  Created by Zhl on 16/7/4.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import "HLBaseTableView.h"
#import "UIView+MJExtension.h"
#import "MJRefresh.h"
@interface HLBaseTableView()

@end
@implementation HLBaseTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style hasFooter:(BOOL)hasFooter{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self createRefreshHeaderView];
        [self createRefreshFooterView];
        self.hasFooter = hasFooter;
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self createRefreshHeaderView];
    [self createRefreshFooterView];
}
-(void)createRefreshHeaderView{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 隐藏时间
//    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 隐藏状态
//    header.stateLabel.hidden = YES;
    
    // 设置文字
    [header setTitle:@"下拉加载更多" forState:MJRefreshStateIdle];
    [header setTitle:@"松手开始刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];

    // 设置颜色
    header.stateLabel.textColor = [UIColor grayColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor grayColor];


    // 马上进入刷新状态
    self.mj_header = header;
    [self.mj_header beginRefreshing];
}
-(void)createRefreshFooterView{
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    
    
    // 设置文字
    [footer setTitle:@"Click or drag up to refresh" forState:MJRefreshStateIdle];
    [footer setTitle:@"Loading more ..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"No more data" forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:17];
    
    // 设置颜色
    footer.stateLabel.textColor = [UIColor grayColor];
    //禁止自动加载
//    footer.automaticallyHidden = NO;

    
    // 设置footer
    self.mj_footer = footer;
}
#pragma mark - 数据处理相关
#pragma mark 下拉刷新数据
- (void)loadNewData
{
    _isRefresh = YES;
    if ([self.refreshDelegate respondsToSelector:@selector(hlBaseTableViewDidPullDownRefreshed:)]) {
        [self.refreshDelegate hlBaseTableViewDidPullDownRefreshed:self];
    }
}
#pragma mark 上拉加载更多数据
- (void)loadMoreData
{
    if ([self.refreshDelegate respondsToSelector:@selector(hlBaseTableViewDidPullUpRefreshed:)]) {
        [self.refreshDelegate hlBaseTableViewDidPullUpRefreshed:self];
    }
}
-(void)setHasFooter:(BOOL)hasFooter{
    _hasFooter = hasFooter;
    self.mj_footer.hidden = !_hasFooter;
}
-(void)setHasLoadAllData:(BOOL)hasLoadAllData{
    _hasLoadAllData = hasLoadAllData;
    if (_hasLoadAllData) {
        [self.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.mj_footer beginRefreshing];
    }
    
}
-(void)beginRefreshing{
    [self.mj_header beginRefreshing];
}
-(void)reloadDeals{
    [self.mj_header endRefreshing];
    _isRefresh = NO;
    [self.mj_footer endRefreshing];
}
@end
