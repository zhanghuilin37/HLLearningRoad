//
//  NSTimer+CTPackage.m
//  codeDemo
//
//  Created by Zhl on 16/7/6.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import "NSTimer+CTPackage.h"

@implementation NSTimer (CTPackage)
//暂停定时器
-(void)ct_pauseTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
}

//立即停止定时器
-(void)ct_resumeTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate date]];
}
//固定时间后重启定时器
- (void)ct_resumeTimerAfterTimeInterval:(NSTimeInterval)interval
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

@end
