//
//  GuidePageViewCtrl.h
//  LearningRoad
//
//  Created by Zhl on 2017/6/2.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import "HLBaseViewController.h"

@interface GuidePageViewCtrl : HLBaseViewController
@property (nonatomic,copy)void(^guideComplete)(BOOL flag);
@end
