//
//  HLBaseTableViewCell.m
//  demo
//
//  Created by Zhl on 2017/4/14.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import "HLBaseTableViewCell.h"

@implementation HLBaseTableViewCell
+(HLBaseTableViewCell *)cellWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath reuseIdentify:(NSString *)reuseIdentify{
    HLBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentify];
    if (cell == nil) {
        cell = [[HLBaseTableViewCell alloc] init];
    }
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
