//
//  UITabBar+badge.m
//  YOUXINBAO
//
//  Created by zjp on 16/2/17.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "UITabBar+badge.h"


#define TabbarItemNums 5.0    //tabbar的数量 如果是5个设置为5.0

@implementation UITabBar (badge)

//显示小红点
- (void)showBadgeOnItemIndex:(NSInteger)index number:(NSInteger)number{
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    
//    UnReadBubbleView *badgeView =[[UnReadBubbleView alloc] init];
//    badgeView.showGameCenterAnimation = NO;
//    badgeView.viscosity  = 55;

    
    //新建小红点
    UILabel *badgeView = [[UILabel alloc]init];
    badgeView.tag = 888 + index;
//    badgeView.layer.borderWidth = SINGLE_LINE_WIDTH*2;
//    badgeView.layer.borderColor = [UIColor whiteColor].CGColor;

    badgeView.layer.cornerRadius = SCREEN_WIDTH/320*6.5;//圆形
    badgeView.layer.masksToBounds = YES;
    badgeView.backgroundColor = [UIColor redColor];//颜色：红色
    badgeView.textColor = [UIColor whiteColor];
    badgeView.textAlignment = NSTextAlignmentCenter;
    badgeView.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:SCREEN_WIDTH/320*9];
    CGRect tabFrame = self.frame;
    
    if (number > 99) {
        badgeView.text = @"99+";
    }else {
        badgeView.text = [NSString stringWithFormat:@"%ld",(long)number];
    }
    if (number == 0) {
        badgeView.text = @"";
    }

    
    //确定小红点的位置
    float percentX = (index +0.6) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, SCREEN_WIDTH/320*13, SCREEN_WIDTH/320*13);//圆形大小为10
    CGFloat ww = [LRTools hl_getFontSizeWithString:badgeView.text font:badgeView.font constrainSize:CGSizeMake(100000, SCREEN_WIDTH/320*13)].width;
    if (ww <= SCREEN_WIDTH/320*13) {
        badgeView.width = SCREEN_WIDTH/320*13;
    }else {
        badgeView.width = ww+5;
    }
    
    if (index == 4) {
        badgeView.size = CGSizeMake(SCREEN_WIDTH/320*8, SCREEN_WIDTH/320*8);
        badgeView.layer.cornerRadius = SCREEN_WIDTH/320*4;//圆形
        badgeView.layer.masksToBounds = YES;
    }

    [self addSubview:badgeView];
}

//隐藏小红点
- (void)hideBadgeOnItemIndex:(NSInteger)index{
    //移除小红点
    [self removeBadgeOnItemIndex:index];
}

//移除小红点
- (void)removeBadgeOnItemIndex:(NSInteger)index{
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}

@end
