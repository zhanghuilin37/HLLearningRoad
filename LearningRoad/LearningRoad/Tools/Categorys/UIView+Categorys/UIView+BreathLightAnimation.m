//
//  UIView+BreathLightAnimation.m
//  AnimationDemo
//
//  Created by Zhl on 2017/3/27.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import "UIView+BreathLightAnimation.h"

@implementation UIView (BreathLightAnimation)
-(void)addBreathLightAnimationWithTime:(CGFloat)time andKey:(NSString *)key{
    [self.layer addAnimation:[self AlphaLight:1.5] forKey:key];
}
-(void)removeBreathLightAnimationWithKey:(NSString *)key{
    [self.layer removeAnimationForKey:key];
}
-(CABasicAnimation *) AlphaLight:(float)time
{
    CABasicAnimation *animation =[CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.5f];//这是透明度。
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    
    return animation;
}
@end
