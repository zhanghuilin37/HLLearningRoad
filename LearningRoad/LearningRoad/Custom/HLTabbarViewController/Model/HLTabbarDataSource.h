//
//  HLTabbarDataSource.h
//  HLTabbarDemo
//
//  Created by Zhl on 2017/3/13.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HLTabbarItemModel.h"

/**
 * HLTabBar的数据源单例
 */
@interface HLTabbarDataSource : NSObject
@property (nonatomic,strong) NSMutableArray *dataArr;
+(HLTabbarDataSource*)sharedInstance;
@end
