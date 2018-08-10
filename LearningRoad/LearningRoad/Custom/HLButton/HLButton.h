//
//  HLButton.h
//  demo
//
//  Created by 张会林 on 2018/1/23.
//  Copyright © 2018年 LearningRoad. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HLButtonType) {
    HLButtonTypeDefault,             //图片左,文字右
    HLButtonTypeImgRightAndTitleLeft,//图片右，文字左
    
    HLButtonTypeImgUpAndTitleDown,   //图片上，文字下
    HLButtonTypeImgDownAndTitleUp,   //图片下，文字上
    HLBuutonTypeCustomSubViwsFrame   //自定义图片和titleLabel的frame
};

@interface HLButton : UIButton
@property (nonatomic,assign)   HLButtonType hl_type;
@property (nonatomic,assign)   CGFloat      hl_spaceBetweenTitleAndImg;
@property (nonatomic)          CGRect       hl_imgViewFrame;
@property (nonatomic)          CGRect       hl_titleLabelFrame;
- (void)hl_setBackgroundColor:(UIColor *)color forState:(UIControlState)state;
+ (instancetype)buttonWithType:(UIButtonType)buttonType HLButtonType:(HLButtonType)hlButtonType Frame:(CGRect)frame;
@end
