//
//  HLTabbarItemModel.h
//  HLTabbarDemo
//
//  Created by Zhl on 2017/3/7.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//item的类型
typedef enum {
    HLTabBarItemType_wordsAndImgs = 0,//图片+文字
    HLTabBarItemType_wordsAndImgs_big,//图片+文字（放大模式）
    HLTabBarItemType_imgs,            //纯图片
    HLTabBarItemType_imgs_big         //纯图片（放大模式）
}HLTabBarItemType;



@interface HLTabbarItemModel : NSObject
/**
 *选中状态的图片
 */
@property (nonatomic,copy)NSString *selImgName;
/**
 * 默认状态图片
 */
@property (nonatomic,copy)NSString *imgName;

/**
 * 标题
 */
@property (nonatomic,copy)NSString *itemTitle;

/**
 * 类名
 */
@property (nonatomic,copy)NSString *className;

/**
 * 选中标题颜色
 */
@property (nonatomic)UIColor *selColor;
/**
 * 默认标题颜色
 */
@property (nonatomic)UIColor *normalColor;

/**
 0: words + img
 1: words + img(放大)
 2: img
 3: img(放大)
 */
@property (nonatomic,assign)HLTabBarItemType type;
@end
