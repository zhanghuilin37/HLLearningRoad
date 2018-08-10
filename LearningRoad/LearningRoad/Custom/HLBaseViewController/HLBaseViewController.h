//
//  HLBaseViewController.h
//  BaiDuDemo
//
//  Created by CH10 on 16/1/15.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLBaseTableView.h"
@interface HLBaseViewController : UIViewController
-(void)setNavItemWithImage:(NSString *)imageName isLeft:(BOOL)isLeft Target:(NSObject*)objc Sel:(SEL)selector;
-(void)setNavItemWithTitle:(NSString*)title Color:(UIColor*)color IsLeft:(BOOL)isLeft Target:(NSObject*)objc Sel:(SEL)selector;
-(void)initUI;
-(void)setBackNav;
-(void)titleBtnClick;
-(void)leftClick:(UIButton*)btn;
-(void)rightClick:(UIButton*)btn;
@end
