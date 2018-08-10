//
//  FaceView.h
//  BBSDemo
//
//  Created by Zhl on 2017/9/4.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FacePageView.h"
#import "CustomKeyboardConst.h"
@interface FaceView : UIView
+(instancetype)faceViewWithPoint:(CGPoint)point andDelegate:(id<FaceViewDelegate>)delegate;
//当首次弹出表情view时加载第一页图片,滚动导致页数发生变化时加载当前页
-(void)setImgsWithPage:(NSInteger)page;
@end
