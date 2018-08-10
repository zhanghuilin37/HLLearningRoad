//
//  HLLabelsView.h
//  RunLoopDemo
//
//  Created by Zhl on 2017/9/12.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLTextModel.h"
@interface HLLabelsView : UIView
+ (CGFloat)getLabelsViewHeightWithTextModelArr:(NSArray *)textArr andWidth:(CGFloat)width;
+ (instancetype)hlLabelsViewWithFrame:(CGRect)frame andTextModels:(NSArray*)models;
- (instancetype)initWithFrame:(CGRect)frame andTextModels:(NSArray*)models;
@end
