//
//  HLNumberTextView.h
//  HLCalculator
//
//  Created by 张会林 on 2017/10/24.
//  Copyright © 2017年 张会林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLNumberTextViewConst.h"
#import "HLNumberKeyBoardView.h"
@protocol HLNumberTextViewDelegate;


@interface HLNumberTextView : UIView

@property (nonatomic,weak)  id<HLNumberTextViewDelegate> delegate;
@property (nonatomic,copy)  NSString *text;
//弹出键盘
- (void)showNumberKeyBoard;
//收起键盘
- (void)hideNumberKeyBoard;
@end


@protocol HLNumberTextViewDelegate <NSObject>
@optional
//当textView的text发生改变时调用
- (void)hlNumberTextViewTextDidChange:(NSString*)text;
@end
