//
//  HLBaseTableViewCell.h
//  demo
//
//  Created by Zhl on 2017/4/14.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLBaseTableViewCell : UITableViewCell
+(HLBaseTableViewCell *)cellWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath reuseIdentify:(NSString*)reuseIdentify;
@end
