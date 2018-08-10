//
//  FacePackageViewCell.m
//  demo
//
//  Created by Zhl on 16/10/10.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import "FacePackageViewCell.h"

@implementation FacePackageViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, frame.size.width-10, frame.size.height-10)];
        self.imgV = imgV;
        [self.contentView addSubview:self.imgV];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width-0.5, 5, 0.5, self.height-10)];
        line.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:line];
        

        self.backgroundColor = [UIColor whiteColor];
        
        UIView *view =[[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = [UIColor colorWithRed:240/256.0 green:240/256.0 blue:240/256.0 alpha:1];
        self.selectedBackgroundView = view;
    }
    return self;
}

@end
