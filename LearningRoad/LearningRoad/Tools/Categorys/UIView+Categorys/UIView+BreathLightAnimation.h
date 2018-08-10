//
//  UIView+BreathLightAnimation.h
//  AnimationDemo
//
//  Created by Zhl on 2017/3/27.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BreathLightAnimation)
//添加呼吸灯动画
-(void)addBreathLightAnimationWithTime:(CGFloat)time andKey:(NSString *)key;
//删除呼吸灯动画
-(void)removeBreathLightAnimationWithKey:(NSString *)key;
@end
