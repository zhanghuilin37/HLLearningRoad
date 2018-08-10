//
//  BBSEditingViewController.h
//  HandicapWin
//
//  Created by CH10 on 16/4/26.
//  Copyright © 2016年 赢盘. All rights reserved.
//

#import "HLBaseViewController.h"
@interface BBSEditingViewController : HLBaseViewController
@property (nonatomic, weak) UITextView *inputView;
@property (nonatomic,copy)void(^sendSuccess)(NSString *letter);
@end
