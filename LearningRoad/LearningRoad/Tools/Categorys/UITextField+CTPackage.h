//
//  UITextField+CTPackage.h
//  LearningRoad
//
//  Created by Zhl on 16/6/30.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (CTPackage)
-(instancetype)initWithFrame:(CGRect)frame hasToolBar:(BOOL)hasToolBar hasDelete:(BOOL)hasDeleteBtn;
-(void)setLeftViewWithImgName:(NSString *)leftImgName;
-(void)setRightViewWithImgName:(NSString *)rightImgName;
@end
