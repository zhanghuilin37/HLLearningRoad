//
//  AddView.m
//  demo
//
//  Created by Zhl on 16/9/26.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import "AddView.h"

@implementation AddView
- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    NSArray *arr = @[@"照片",@"拍摄",@"小视频",@"语音聊天",@"红包",@"个人名片",@"位置",@"收藏"];
    if (self) {
        for (int i = 0; i<2; i++) {
            for (int j = 0; j<4; j++) {
                CGFloat x = (SCREEN_WIDTH/4-50)/2.0+SCREEN_WIDTH/4*j,y=SCREEN_WIDTH/4*i+(SCREEN_WIDTH/4-50)/2.0,w=50,h=50;
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(x, y, w, h);
                btn.layer.borderWidth = 1;
                btn.layer.borderColor = [UIColor blackColor].CGColor;
                btn.titleLabel.font = [UIFont systemFontOfSize:12];
                [btn setTitle:[arr objectAtIndex:i*4+j] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                btn.tag = i*4+j;
                [self addSubview:btn];
            }
        }
    }
    return self;
}
-(void)btnClick:(UIButton*)btn{
    if (self.AddViewBtnClicked) {
        self.AddViewBtnClicked((AddViewBtnTag)btn.tag);
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
