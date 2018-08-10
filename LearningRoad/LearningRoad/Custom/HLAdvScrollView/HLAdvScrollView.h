//
//  HLAdvScrollView.h
//  codeDemo
//
//  Created by Zhl on 16/7/6.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//
/*---------------------------------------------------------
 * 使用时注意：
 *     -(void)viewWillAppear:(BOOL)animated 
 *      方法中要重启定时器 [_adv hl_resumeTime];
 *
 *     -(void)viewWillDisappear:(BOOL)animated 
 *      方法中要暂停定时器 [_adv hl_pauseTimer];
 ---------------------------------------------------------*/
#import <UIKit/UIKit.h>
@protocol HLAdvScrollViewDelegate;
@interface HLAdvScrollView : UIView
@property (nonatomic,assign) id<HLAdvScrollViewDelegate> delegate;
/**
 *  构造方法
 *
 *  @param frame           frame
 *  @param images          图片数组《imageNameStr》
 *  @param timesInterval   换页时间间隔
 *  @param animateDuration 换页动画时长
 *  @param isYesOrNo       是否把定时器加入到runloop中(YES 加入后当HLAdvScrollView的实
 *                         例作为tableview的头部视图出现时，tableview的滚动不影响adv
 *                         的滚动；NO tableview的滚动时adv不会滚动)
 *  @return HLAdvScrollView
 */
- (instancetype)initWithFrame:(CGRect)frame images:(NSArray*)images timesInterval:(NSInteger)timesInterval andAnimateDureation:(NSInteger)animateDuration addToRunloop:(BOOL)isYesOrNo delegate:(id<HLAdvScrollViewDelegate>)delegate;
-(void)hl_pauseTimer;
-(void)hl_resumeTime;
@end
@protocol HLAdvScrollViewDelegate <NSObject>
@optional
-(void)hlAdvScrollView:(HLAdvScrollView*)scrollView ClickedImgVAtIndex:(NSInteger)index;

@end
