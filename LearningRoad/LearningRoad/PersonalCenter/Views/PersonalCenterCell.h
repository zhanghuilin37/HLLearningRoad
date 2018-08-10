//
//  PersonalCenterCell.h
//  LearningRoad
//
//  Created by Zhl on 2017/6/2.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import "HLBaseTableViewCell.h"
#import "UserManager.h"
#define cellHeight 44
@interface PersonalCenterCell : UITableViewCell
@property (nonatomic,weak)UILabel *titleLabel;
@property (nonatomic,weak)UILabel *rightLabel;
@property (nonatomic,weak)UIImageView *rightImgV;
@property (nonatomic,weak)UISwitch *openGesture;

+(NSString *)getIdentifyWithIndex:(NSIndexPath*)indexPath;
+(PersonalCenterCell *)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
@end
