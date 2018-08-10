//
//  HLZheDieView.h
//  AnimationDemo
//
//  Created by Zhl on 2017/3/24.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLAnimationView.h"
#import "HLRightView.h"

typedef enum {
    HLZheDieViewAnimationSate_zhankai = 0,
    HLZheDieViewAnimationSate_shouqi
}HLZheDieViewAnimationSate;

@protocol HLZheDieViewDelegate <NSObject>

@optional
-(void)HLZheDieViewItemClickedAtIndex:(NSInteger)index;
@end

@interface HLZheDieView : UIView<UIScrollViewDelegate>
@property (nonatomic,assign) id<HLZheDieViewDelegate> delegate;

@property (nonatomic,weak) HLAnimationView *aniView;
@property (nonatomic,weak) UIScrollView    *scrollView;
@property (nonatomic,weak) HLRightView     *rightView;
@property (nonatomic,weak) UIButton        *switchStateBtn;
@property (nonatomic,weak) UIView          *backGroundView;
@property (nonatomic,assign) CGFloat offsetY;




@property (nonatomic,assign)HLZheDieViewAnimationSate state;
@end
