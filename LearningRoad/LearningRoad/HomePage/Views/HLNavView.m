//
//  HLNavView.m
//  LearningRoad
//
//  Created by Zhl on 2017/6/2.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import "HLNavView.h"

@implementation HLNavView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
        bgView.backgroundColor = [LRTools hl_colorWithHexString:@"fc6633"];
        bgView.alpha = 0;
        self.bgView = bgView;
        [self addSubview:bgView];
        
        UILabel *titleL = [[UILabel alloc] initWithFrame:ccr(37, 20, SCREEN_WIDTH-74, 44)];
        titleL.textColor = [UIColor whiteColor];
        titleL.font = [UIFont boldSystemFontOfSize:20];
        titleL.textAlignment = NSTextAlignmentCenter;
        self.titleLabel = titleL;
        [self.bgView addSubview:self.titleLabel];
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = ccr(7, 27, 30, 30);
        [leftBtn setImage:[UIImage imageNamed:@"homeLeftNav"] forState:UIControlStateNormal];
        self.leftBtn = leftBtn;
        [self addSubview:self.leftBtn];
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = ccr(SCREEN_WIDTH - 37, 27, 30, 30);
        [rightBtn setImage:[UIImage imageNamed:@"homeLeftNav"] forState:UIControlStateNormal];
        self.rightBtn = rightBtn;
        [self addSubview:self.rightBtn];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
