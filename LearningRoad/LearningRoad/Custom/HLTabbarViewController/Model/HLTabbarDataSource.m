//
//  HLTabbarDataSource.m
//  HLTabbarDemo
//
//  Created by Zhl on 2017/3/13.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import "HLTabbarDataSource.h"
#import "HomePageViewCtrl.h"
#import "IndicatorViewCtrl.h"
#import "PersonalCenterViewCtrl.h"
@implementation HLTabbarDataSource
+(HLTabbarDataSource*)sharedInstance{
    static HLTabbarDataSource *dataSource = nil;
    if (dataSource == nil) {
        dataSource = [[HLTabbarDataSource alloc] init];
        dataSource.dataArr = [[NSMutableArray alloc] init];
        
        
        NSArray *selImgNames = @[@"tab_c0",@"tab_c3",@"tab_c4"];
        NSArray *imgNames    = @[@"tab_0",@"tab_3",@"tab_4"];
        NSArray *itemTitles  = @[@"首页",@"指示",@"我的"];
        NSArray *classNames  = @[NSStringFromClass([HomePageViewCtrl class]),NSStringFromClass([IndicatorViewCtrl class]),NSStringFromClass([PersonalCenterViewCtrl class])];
        
        for (int i = 0; i < selImgNames.count; i++) {
            
            HLTabbarItemModel *item = [[HLTabbarItemModel alloc] init];
            item.selImgName = [selImgNames objectAtIndex:i];
            item.imgName    = [imgNames    objectAtIndex:i];
            item.itemTitle  = [itemTitles  objectAtIndex:i];
            item.className  = [classNames  objectAtIndex:i];
            item.selColor   = [UIColor redColor];
            item.normalColor= [UIColor grayColor];
            item.type       = HLTabBarItemType_wordsAndImgs;
            [dataSource.dataArr addObject:item];
        }
    }
    return dataSource;
}
@end



















