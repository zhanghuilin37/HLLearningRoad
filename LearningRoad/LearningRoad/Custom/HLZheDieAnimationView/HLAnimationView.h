//
//  HLAnimationView.h
//  AnimationDemo
//
//  Created by Zhl on 2017/3/22.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLAnimationView : UIView

@property (nonatomic,copy)void(^ItemClickedAtIndex)(NSInteger index);

- (instancetype)initWithFrame:(CGRect)frame andImgNames:(NSArray*)imgNames;
-(void)update3DTransationWithOffsetX:(CGFloat)offsetX;

@end
