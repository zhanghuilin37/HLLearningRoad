//
//  NSSkyDouble.m
//  demo
//
//  Created by Zhl on 16/9/1.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import "NSSkyDouble.h"

@implementation NSSkyDouble
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.iDoubleValue = 0.0f;
    }
    return self;
}

- (instancetype)initWithDouble:(double) value
{
    self = [self init];
    if (self) {
        self.iDoubleValue = value;
    }
    return self;
}
@end
