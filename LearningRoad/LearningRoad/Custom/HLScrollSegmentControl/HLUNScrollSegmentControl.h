//
//  HLUNScrollSegmentControl.h
//  LearningRoad
//
//  Created by Zhl on 2017/7/25.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HLUNScrollSegmentControlDelegate;

@interface HLUNScrollSegmentControl : UIView

/**
 * 是否显示标题下方滑动条
 */
@property (nonatomic,assign) BOOL showSlider;
/**
 * 是否开启滑块滑动动画
 */
@property (nonatomic,assign) BOOL moveAnimation;
/**
 * 当前选中的item
 */
@property (nonatomic,assign) NSInteger selectedIndex;
/**
 * 代理
 */
@property (nonatomic,weak) id<HLUNScrollSegmentControlDelegate> delegate;

/**
 * 显示相应item的小红点
 * index:
 */

-(void)showRoundBadgeAtIndex:(NSInteger)index;

/**
 * 初始化方法
 * frame    :
 * items    : 标题数组
 * textFont : 标题的字体
 * delegate : 代理
 */
-(instancetype)initWithFrame:(CGRect)frame Items:(NSArray<NSString*> *)items TextFont:(UIFont*)textFont AndDelegate:(id<HLUNScrollSegmentControlDelegate>)delegate;


@end

@protocol HLUNScrollSegmentControlDelegate <NSObject>
@optional
//当前选中的index
-(void)hlScrollSegmentControl:(HLUNScrollSegmentControl*)segControl SelectedIndex:(NSInteger)selectedIndex;
@end
