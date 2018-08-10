//
//  FacePackageView.h
//  demo
//
//  Created by Zhl on 16/10/10.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FacePackageView : UIView
@property (nonatomic,copy)void(^packageClickedIndex)(NSInteger index);
@end
