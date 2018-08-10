//
//  HLTabbarButton.m
//  HLTabbarDemo
//
//  Created by Zhl on 2017/3/13.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import "HLTabbarButton.h"

@implementation HLTabbarButton
+(instancetype)createTabbarButtonWithFrame:(CGRect)frame Model:(HLTabbarItemModel*)model{
    
    HLTabbarButton *btn = [HLTabbarButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.frame = frame;
    if (btn.badgeView == nil) {
        UIView *badgeView = [[UIView alloc] init];
        badgeView.backgroundColor = [UIColor redColor];
        badgeView.hidden = YES;
        btn.badgeView = badgeView;
        [btn addSubview:btn.badgeView];
    }
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn setImage:[UIImage imageNamed:model.imgName]    forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:model.imgName]    forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:model.selImgName] forState:UIControlStateSelected];
    
    [btn setTitleColor:model.normalColor forState:UIControlStateNormal];
    [btn setTitleColor:model.normalColor forState:UIControlStateHighlighted];
    [btn setTitleColor:model.selColor    forState:UIControlStateSelected];
    
    if (model.type == HLTabBarItemType_wordsAndImgs) {
        
        [btn setTitle:model.itemTitle forState:UIControlStateNormal];
        
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) andTitleEdgeInsetsWithBtnLeftEdge:UIEdgeInsetsMake(0, 0, 0, 0)andSpace:0];
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        NSLog(@"%f,%f",btn.intrinsicContentSize.width,btn.intrinsicContentSize.height);
        
    }else if (model.type == HLTabBarItemType_wordsAndImgs_big){
        
        [btn setTitle:model.itemTitle forState:UIControlStateNormal];
        btn.contentEdgeInsets = UIEdgeInsetsMake(-8, 0, 8, 0);
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) andTitleEdgeInsetsWithBtnLeftEdge:UIEdgeInsetsMake(5.0, 0, -5.0, 0)andSpace:0];
        
        
    }else if (model.type == HLTabBarItemType_imgs){
        
        CGRect newFrame       = btn.frame;
        newFrame.origin.y    -= 15;
        newFrame.size.height += 15;
        
        CGFloat titleHeight  = 0.0;
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, titleHeight, 0);
        
    }else if (model.type == HLTabBarItemType_imgs_big){

        btn.imageEdgeInsets = UIEdgeInsetsMake(-6, 0, 6, 0);
    }

    return btn;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat x,y,w,h;
    x = self.bounds.size.width*2/3,  y = 3,  w = 7,   h = 7;
    self.badgeView.frame = CGRectMake(x, y, w, h);
    self.badgeView.layer.cornerRadius = h/2.0;
    self.badgeView.layer.masksToBounds = YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
