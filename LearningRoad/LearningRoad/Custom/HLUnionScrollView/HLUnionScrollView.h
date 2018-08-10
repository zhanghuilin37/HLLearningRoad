//
//  UnionScrollView.h
//  ScrollViewDemo
//
//  Created by Zhl on 16/6/15.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLSegmentControl.h"
//#import "ContentView.h"


@interface ContentView : UIView
@property(nonatomic,strong)UITableView *tableView;
@end


@protocol HLUnionScrollViewDelegate <NSObject>

/**第几个标题被选中时*/
-(void)ct_titleSegmentDidClickIndex:(NSInteger)index curentView:(ContentView*)currentView;
@end




@interface HLUnionScrollView : UIScrollView

@property(nonatomic,strong)UIView *headerView;

@property(nonatomic,assign)id<HLUnionScrollViewDelegate> hlDelegate;
+(instancetype)hlUnionScrollViewWithFrame:(CGRect)frame andItems:(NSArray *)items;
- (instancetype)initWithFrame:(CGRect)frame andItems:(NSArray *)items;
/**在第index个contentView上添加控件*/
-(void)hl_currentViewAddView:(UIView*)view withIndex:(NSInteger)index;
/**在所有的contentView上相同的位置同时添加控件*/
-(void)hl_allViewAddView:(UIView*)view;
/**给contentView添加tableview并且指定tableview的代理*/
-(void)hl_currentViewAddContentTableView:(id<UITableViewDataSource,UITableViewDelegate>)tableViewDelegate firstTag:(NSInteger)firstTag;
@end
