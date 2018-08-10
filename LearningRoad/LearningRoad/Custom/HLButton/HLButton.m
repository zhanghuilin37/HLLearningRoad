//
//  HLButton.m
//  demo
//
//  Created by 张会林 on 2018/1/23.
//  Copyright © 2018年 LearningRoad. All rights reserved.
//

#import "HLButton.h"
@interface HLButton ()
@property (nonatomic)UIColor *backgroundColor_default;
@property (nonatomic)UIColor *backgroundColor_stateNormal;
@property (nonatomic)UIColor *backgroundColor_stateSelected;
@property (nonatomic)UIColor *backgroundColor_stateDisabled;

@end
@implementation HLButton
+ (instancetype)buttonWithType:(UIButtonType)buttonType HLButtonType:(HLButtonType)hlButtonType Frame:(CGRect)frame{
    HLButton *button = [super buttonWithType:buttonType];
    button.frame = frame;
    button.hl_type = hlButtonType;
    return button;
}
- (void)hl_setBackgroundColor:(UIColor *)color forState:(UIControlState)state {
    switch (state) {
        case UIControlStateNormal:{
            self.backgroundColor_stateNormal   = color;
        }break;
        case UIControlStateSelected:{
            self.backgroundColor_stateSelected = color;
        }break;
        case UIControlStateDisabled:{
            self.backgroundColor_stateDisabled = color;
        }break;
        default:{
            self.backgroundColor_default       = color;
        }break;
    }
}
- (void)setHl_type:(HLButtonType)hl_type {
    _hl_type = hl_type;
    [self layoutSubviews];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat sumHeight = self.titleLabel.height + self.imageView.height;
    CGFloat sumWidth  = self.titleLabel.width  + self.imageView.width;
    if (self.hl_type == HLButtonTypeImgRightAndTitleLeft) {//左文右图
        self.titleLabel.left =(self.width-sumWidth)/2.0-_hl_spaceBetweenTitleAndImg/2.0;
        self.imageView.left = CGRectGetMaxX(self.titleLabel.frame)+_hl_spaceBetweenTitleAndImg;
    } else if (self.hl_type == HLButtonTypeImgUpAndTitleDown) {//上图下文
        self.imageView.top = (self.height-sumHeight)/2.0-_hl_spaceBetweenTitleAndImg/2.0;
        self.titleLabel.top = CGRectGetMaxY(self.imageView.frame)+_hl_spaceBetweenTitleAndImg;
        self.imageView.centerX = self.width/2.0;
        self.titleLabel.centerX = self.imageView.centerX;
    } else if (self.hl_type == HLButtonTypeImgDownAndTitleUp) {//下图上文
        self.titleLabel.top = (self.height-sumHeight)/2.0-_hl_spaceBetweenTitleAndImg/2.0;
        self.imageView.top = CGRectGetMaxY(self.titleLabel.frame)+_hl_spaceBetweenTitleAndImg;
        self.titleLabel.centerX = self.width/2.0;
        self.imageView.centerX = self.titleLabel.centerX;
    } else if(self.hl_type == HLBuutonTypeCustomSubViwsFrame) {
        self.titleLabel.frame = _hl_titleLabelFrame;
        self.imageView.frame = _hl_imgViewFrame;
    } else{//左图右文

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
