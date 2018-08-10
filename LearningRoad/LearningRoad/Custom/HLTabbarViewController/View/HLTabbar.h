//
//  HLTabbar.h
//  HLTabbarDemo
//
//  Created by Zhl on 2017/3/3.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLTabbarDataSource.h"
#import "HLTabbarButton.h"
@interface HLTabbar : UIView

@property (nonatomic,strong) NSArray *sourceArr;

//背景图片 高度49
@property (nonatomic,strong) UIImageView  *backgroundImgV;
//分割线
@property (nonatomic,strong) UIImageView  *shadowImgV;
//当前被选中的btn
@property (nonatomic,weak) HLTabbarButton *selBtn;
//当前被选中的index
@property (nonatomic,assign) NSInteger     selectedIndex;
//是否开启选中按钮的动画，默认开启
@property (nonatomic,assign) BOOL selItemAnimation;
//title的默认颜色
@property (nonatomic)UIColor *tintColor;
//title被选中时的颜色
@property (nonatomic)UIColor *selectedItemColor;



//选中的item发生改变时 的回调
@property (nonatomic,copy)void(^tabbarClickedAtIndex)(NSInteger index);


/**
 *
 */
+(HLTabbar*)createHLTabbarWithFrame:(CGRect)frame andArr:(NSArray<HLTabbarItemModel*>*)arr;
/**
 * 显示第 index   item的小红点
 */
- (void)showBadgeAtIndex:(NSInteger)index;
/**
 * 隐藏第 index   item的小红点
 */
- (void)hiddeBadgeAtIndex:(NSInteger)index;

@end
