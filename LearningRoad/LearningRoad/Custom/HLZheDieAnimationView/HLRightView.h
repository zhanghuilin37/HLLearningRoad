//
//  HLRightView.h
//  AnimationDemo
//
//  Created by Zhl on 2017/3/23.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLRightView : UIView
@property (nonatomic,copy)void(^rightItemClickedAtIndex)(NSInteger  index);
@end
