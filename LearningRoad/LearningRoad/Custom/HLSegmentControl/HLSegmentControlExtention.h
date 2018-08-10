//
//  HLSegmentControlExtention.h
//  LearningRoad
//
//  Created by Zhl on 2017/6/2.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLSegmentControl.h"

@protocol HLSegmentControlExtentionDelegate;

@interface HLSegmentControlExtention : UIView

@property (nonatomic,weak)HLSegmentControl *segmentControl;
@property(nonatomic,assign)id<HLSegmentControlExtentionDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame itemArr:(NSArray*)itemArr;

@end
@protocol HLSegmentControlExtentionDelegate <NSObject>
@optional
-(void)hlSegmentControlExtention:(HLSegmentControlExtention*)segExtention ClickedAtIndex:(NSInteger)index;

@end
