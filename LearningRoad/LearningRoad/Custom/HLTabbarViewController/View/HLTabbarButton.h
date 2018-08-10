//
//  HLTabbarButton.h
//  HLTabbarDemo
//
//  Created by Zhl on 2017/3/13.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLTabbarItemModel.h"
#import "UIButton+ImgAndTitleEdgeInsets.h"
@interface HLTabbarButton : UIButton
@property (nonatomic,strong) HLTabbarItemModel *model;
/**
 *小红点（默认隐藏）
 */
@property (nonatomic,strong) UIView *badgeView;
/**
 * 创建Custom类型的按钮，同时改变按钮内部图片和标题的布局为 上图下文 模式 而非默认的左图右文
 *
 * frame:
 * model: button的数据源模型获取 图片 标题 颜色 类型 等信息
 */
+(instancetype)createTabbarButtonWithFrame:(CGRect)frame Model:(HLTabbarItemModel*)model;
@end
