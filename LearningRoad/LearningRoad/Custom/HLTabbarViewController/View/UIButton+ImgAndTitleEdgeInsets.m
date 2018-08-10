//
//  UIButton+ImgAndTitleEdgeInsets.m
//  HLTabbarDemo
//
//  Created by Zhl on 2017/3/17.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import "UIButton+ImgAndTitleEdgeInsets.h"

@implementation UIButton (ImgAndTitleEdgeInsets)
-(void)setImageEdgeInsets:(UIEdgeInsets)imageEdgeInsets andTitleEdgeInsetsWithBtnLeftEdge:(UIEdgeInsets)titleEdgeInsets andSpace:(CGFloat)space{
    CGSize imgSize = self.imageView.image.size;
    CGSize btnSize = self.frame.size;
    CGSize labSize = [self.titleLabel sizeThatFits:self.bounds.size];
    CGSize contentSize = CGSizeMake(imgSize.width>labSize.width?imgSize.width:labSize.width, imgSize.height+labSize.height+space);
    
    CGFloat top,left,bottom,right;
    left   = (btnSize.width-imgSize.width)/2.0       + imageEdgeInsets.left;
    right  = btnSize.width-imgSize.width-left        + imageEdgeInsets.right;
    top    = (btnSize.height-contentSize.height)/2.0 + imageEdgeInsets.top;
    bottom = btnSize.height -top-imgSize.height      + imageEdgeInsets.bottom;
    self.imageEdgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
    
    left   = -(left +imgSize.width)                  + titleEdgeInsets.left;
    right  = left +imgSize.width                     + titleEdgeInsets.right;
    top    = top + imgSize.height+space              + titleEdgeInsets.top;
    bottom = btnSize.height-top-labSize.height       + titleEdgeInsets.bottom;
    self.titleEdgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
}
@end
