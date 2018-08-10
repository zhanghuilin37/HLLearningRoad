//
//  NSTimer+CTPackage.h
//  codeDemo
//
//  Created by Zhl on 16/7/6.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (CTPackage)
//暂停定时器
-(void)ct_pauseTimer;

//立即停止定时器
-(void)ct_resumeTimer;
//固定时间后重启定时器
- (void)ct_resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

@end
