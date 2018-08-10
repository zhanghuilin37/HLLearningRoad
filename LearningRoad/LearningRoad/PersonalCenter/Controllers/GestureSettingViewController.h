//
//  GestureSettingViewController.h
//  demo
//
//  Created by Zhl on 16/10/24.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import "HLBaseViewController.h"
#import "HLGestureLockView.h"
@interface GestureSettingViewController : HLBaseViewController
@property (nonatomic,copy)NSString *stitle;
/**
 *  0 输入密码      1设置密码
 */
@property (nonatomic,assign)NSInteger type;
@end
