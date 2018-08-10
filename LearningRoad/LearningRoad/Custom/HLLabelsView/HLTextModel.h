//
//  HLTextModel.h
//  RunLoopDemo
//
//  Created by Zhl on 2017/9/12.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
@interface HLTextModel : NSObject

@property (nonatomic,copy)NSString *text;
@property (nonatomic,copy)NSString *colorHexStr;
@property (nonatomic,copy)NSString *hasRect;
@property (nonatomic) CGSize textSize;
@property (nonatomic) CGFloat fontPointSize;
@end
