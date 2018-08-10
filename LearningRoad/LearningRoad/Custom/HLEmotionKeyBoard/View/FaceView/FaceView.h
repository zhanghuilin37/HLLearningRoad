//
//  FaceView.h
//  demo
//
//  Created by Zhl on 16/9/26.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  表情
 */
@interface FaceView : UIView
/**
 *  获取被点击的表情名
 */
@property (nonatomic,copy)void(^faceName)(NSString*nameStr);
/**
 *  表情键盘上删除按钮被点击时
 */
@property (nonatomic,copy)void(^faceDeleteClick)();
@end
