//
//  HLNumberKeyBoardView.h
//  HLCalculator
//
//  Created by 张会林 on 2017/10/20.
//  Copyright © 2017年 张会林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLNumberKeyBoardView : UIView
//隐藏键盘 duration:动画时长
- (void)hideNumberKeyBoardDuration:(CGFloat)duration;
//弹出键盘 duration:动画时长
- (void)showNumberKeyBoardDuration:(CGFloat)duration;
//选择主键盘上的数字（0-9，外加00，0000）
@property (nonatomic,copy)   void(^numberKeyBoardViewSelectedMainNumber)(NSString*numberStr);
//选择特殊键盘上的数字（100，500，1000）
@property (nonatomic,copy)   void(^numberKeyBoardViewSelectedSpecialNumber)(NSString*numberStr);
//键盘上删除按钮被点击
@property (nonatomic,copy)   void(^numberKeyBoardViewDeleteBtnClick)(void);
//键盘上的确定按钮被点击
@property (nonatomic,copy)   void(^numberKeyBoardViewConfirmBtnClick)(void);

@end
