//
//  PersonalCenterCell.m
//  LearningRoad
//
//  Created by Zhl on 2017/6/2.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import "PersonalCenterCell.h"
#import "SDImageCache.h"
@interface PersonalCenterCell ()
{
    //    UIView *_upLine;
    UIView *_downLine;
}
@end

@implementation PersonalCenterCell
+(PersonalCenterCell *)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentify = [PersonalCenterCell getIdentifyWithIndex:indexPath];
    PersonalCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = [[PersonalCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }


    if (indexPath.row == 1) {
        NSInteger size = [[SDImageCache sharedImageCache] getSize];
        CGFloat fSize = size/1024.0/1024.0;
        cell.rightLabel.text = [NSString stringWithFormat:@"%.3fM",fSize];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _downLine = [[UIView alloc] initWithFrame:ccr(0, cellHeight-1, SCREEN_WIDTH, 1)];
        _downLine.backgroundColor = [UIColor grayColor];
        
        [self.contentView addSubview:[self getTitleLabel]];
        [self.contentView addSubview:[self getRightImgV]];
        if ([reuseIdentifier isEqualToString:@"SettingCellIdentifyGesture"]) {
            [self.contentView addSubview:[self getOpenGesture]];
        }else if ([reuseIdentifier isEqualToString:@"SettingCellIdentifyClearCache"]){
            [self.contentView addSubview:[self getRightLabel]];
        }
        [self.contentView addSubview:_downLine];
    }
    return self;
}
+(NSString *)getIdentifyWithIndex:(NSIndexPath*)indexPath{
    static NSString *identify = nil;
    switch (indexPath.row) {
        case 0:
            identify = @"SettingCellIdentifyGesture";
            break;
        case 1:
            identify = @"SettingCellIdentifyClearCache";
            break;
        default:
            identify = @"SettingCellIdentify";
            break;
    }
    return identify;
}
#pragma mark - getter methods
-(UILabel*)getTitleLabel{
    //titleLabel
    CGFloat x,y,w,h;
    x = 10,  y = 0,  w = 100,   h = cellHeight;
    UILabel *label = [[UILabel alloc] initWithFrame:ccr(x, y, w, h) text:@"" font:[UIFont systemFontOfSize:15] textColor:[UIColor blackColor]];
    self.titleLabel = label;
    return self.titleLabel;
}
-(UILabel*)getRightLabel{
    //rightLabel
    CGFloat x,y,w,h;
    x = self.rightImgV.left-100-10,  y = 0,  w = 100,   h = cellHeight;
    UILabel *label = [[UILabel alloc] initWithFrame:ccr(x, y, w, h) text:@"" font:[UIFont systemFontOfSize:13] textColor:[UIColor grayColor]];
    label.textAlignment = NSTextAlignmentRight;
    self.rightLabel = label;
    return self.rightLabel;
}
-(UIImageView*)getRightImgV{
    //rightImgV
    CGFloat x,y,w,h;
    x = SCREEN_WIDTH-10-10,  y = (cellHeight-11.5/7*10)/2.0,  w = 10,   h = 11.5/7*10;
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:ccr(x, y, w, h)];
    imgV.image = [UIImage imageNamed:@"cellRight"];
    self.rightImgV = imgV;
    return self.rightImgV;
}
-(UISwitch*)getOpenGesture{
    //openGesture
    CGFloat x,y,w,h;
    x = self.rightImgV.left-50-10,  y = 0,  w = 50,   h = 40;
    UISwitch *openGesture = [[UISwitch alloc] initWithFrame:ccr(x, y, w, h)];
    CGPoint center = openGesture.center;
    center.y = cellHeight/2.0;
    center.x = self.rightImgV.left - 10- openGesture.width/2.0;
    openGesture.center = center;
    openGesture.on = [[UserManager sharedInstance] getLoginUser].isGestureLock;
    [openGesture addTarget:self action:@selector(openGestureValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.openGesture = openGesture;
    return self.openGesture;
}
-(void)openGestureValueChanged:(UISwitch*)swi{
    if (swi.on==NO) {//关闭手势密码
        UserModel *model = [[UserManager sharedInstance] getLoginUser];
        model.isGestureLock = NO;
        model.gesturePsword = nil;
        [[UserManager sharedInstance] setLoginUser:model];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
