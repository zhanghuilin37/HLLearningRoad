//
//  HLTestAlertView.m
//  LearningRoad
//
//  Created by 张会林 on 2018/7/31.
//  Copyright © 2018年 LearningRoad. All rights reserved.
//

#import "HLTestAlertView.h"

@implementation HLTestAlertView
-(void)createSubViews{
    self.contentView.frame = CGRectMake(SCREEN_WIDTH/2.0-160, SCREEN_HEIGHT/2.0-150, 320, 300);
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.cornerRadius = 6;
    self.contentView.layer.masksToBounds = YES;
    
    self.cancelBtn.frame = CGRectMake(0, self.contentView.height-30, self.contentView.width/2.0, 30);
    [self.contentView addSubview:self.cancelBtn];
    self.confirmBtn.frame = CGRectMake(self.cancelBtn.right, self.contentView.height-30, self.contentView.width/2.0, 30);
    [self.contentView addSubview:self.confirmBtn];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
