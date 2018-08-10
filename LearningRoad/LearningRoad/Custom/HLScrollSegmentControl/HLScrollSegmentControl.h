//
//  HLScrollSegmentControl.h
//  demo3
//
//  Created by Zhl on 2017/7/5.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HLScrollSegmentControlDelegate;
/**
 * 1》本控件的标题宽度会根据标题自适应宽度；
 * 2》item之间间距相等；
 * 3》当控件宽度超出屏幕宽度后可以滚动显示；
 * 4》带有小红点（消息提示）默认隐藏
 */
@interface HLScrollSegmentControl : UIView
/** 是否显示标题下方的滑块 */
@property (nonatomic,assign) BOOL showSlider;
/** 是否显示左右侧的指示块 */
@property (nonatomic,assign) BOOL showIndicator;
/** 是否开启滑动动画 */
@property (nonatomic,assign) BOOL moveAnimation;
/** 选中的index */
@property (nonatomic,assign) NSInteger selectedIndex;
/** 滑块的的宽度 */
@property (nonatomic,assign) CGFloat sliderWidth;
/** 代理 */
@property (nonatomic,weak) id<HLScrollSegmentControlDelegate> delegate;

/**
 * 初始化方法
 * frame      : frame
 * items      : 标题数组
 * textFont   : 标题字体
 * spaceWidth : item之间的空隙宽度
 * delegate   : 代理
 */
-(instancetype)initWithFrame:(CGRect)frame Items:(NSArray<NSString *> *)items TextFont:(UIFont*)textFont SpaceWidth:(CGFloat)spaceWidth AndDelegate:(id<HLScrollSegmentControlDelegate>)delegate;
/**
 * 显示相应item上的小红点
 * index :
 */
- (void)showRoundBadgeAtIndex:(NSInteger)index;

/**
 * 隐藏相应item上的小红点
 * index :
 */
- (void)hideRoundBadageAtIndex:(NSInteger)index;
@end





@protocol HLScrollSegmentControlDelegate <NSObject>
@optional
-(void)hlScrollSegmentControl:(HLScrollSegmentControl*)segControl SelectedIndex:(NSInteger)index;
-(void)setBasicPropertyOfHLScrollSegmentControl:(HLScrollSegmentControl*)control;
-(void)setBasicPropertyOfLeftIndicator:(UIView*)leftIndicator RightIndicator:(UIView*)rightIndicator;
-(void)setBasicPropertyOfBottomSlider:(UIView*)sliderView;
-(void)setBasicPropertyOfBtnItem:(UIButton*)btnItem;
@end
