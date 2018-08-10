//
//  CTPhotoModel.m
//  HandicapWin
//
//  Created by Zhl on 16/5/25.
//  Copyright © 2016年 赢盘. All rights reserved.
//

#import "CTPhotoModel.h"

@implementation CTPhotoModel
+(CTPhotoModel*)getRedBagModel{
    CTPhotoModel *model = [[CTPhotoModel alloc] init];
    model.thumbnailImage = [UIImage imageNamed:@"redbag"];
    model.deleteBtnHidden = YES;
    model.type = @"1";
    model.isAdd = NO;
    model.isRedBag = YES;
    return model;
}
+(CTPhotoModel*)getAddModel{
    CTPhotoModel *model = [[CTPhotoModel alloc] init];
    model.thumbnailImage = [UIImage imageNamed:@"imgGroupAdd"];
    model.deleteBtnHidden = YES;
    model.type = @"1";
    model.isAdd = YES;
    model.isRedBag = NO;
    return model;
}
@end
