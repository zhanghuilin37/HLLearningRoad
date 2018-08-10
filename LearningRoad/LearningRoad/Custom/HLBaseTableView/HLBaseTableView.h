//
//  HLBaseTableView.h
//  HLBaseTableViewDemo
//
//  Created by Zhl on 16/7/4.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
@class HLBaseTableView;

@protocol HLBaseTableViewDelegate <NSObject>

@optional
//下拉刷新
- (void)hlBaseTableViewDidPullDownRefreshed:(HLBaseTableView *)tableView;

//上拉加载更多
- (void)hlBaseTableViewDidPullUpRefreshed:(HLBaseTableView *)tableView;

@end

@interface HLBaseTableView : UITableView
//
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style hasFooter:(BOOL)hasFooter;
@property (nonatomic,assign) id<HLBaseTableViewDelegate> refreshDelegate;
@property (nonatomic,assign) BOOL hasFooter;    //是否添加上拉加载视图
@property (nonatomic,assign) BOOL hasLoadAllData;//已加载全部数据
@property (nonatomic,assign) BOOL isRefresh;
// 开始刷新
- (void)beginRefreshing;
//结束刷新状态，请求结束时调用
- (void)reloadDeals;
@end

