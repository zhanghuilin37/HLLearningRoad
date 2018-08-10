//
//  HLNumberTextViewConst.h
//  HLCalculator
//
//  Created by 张会林 on 2017/10/20.
//  Copyright © 2017年 张会林. All rights reserved.
//

#ifndef HLNumberTextViewConst_h
#define HLNumberTextViewConst_h

//主键和特殊键的高度
#define KeyBoardItemHeight          54.0
//主键和特殊键的宽度
#define KeyBoardItemWidth           ([UIScreen mainScreen].bounds.size.width/5.0)
//数字键盘的高度
#define NumberKeyBoardViewHeight    (KeyBoardItemHeight*4.0+k_X_HomeSafeArea_H)


#define KeyBoardSeparatorLineWidth  1.0  //数字键盘上分割线的宽度

#define KeyBoardMainkeyColor        @"#FFFFFF" //主键颜色
#define KeyBoardSpecialKeyColor     @"#E0E0E0" //特殊键色
#define KeyBoardDeleteKeyColor      @"#C1C1C1" //删除键颜色
#define KeyBoardConfirmKeyColor     @"#006CFF" //确认键颜色
#define KeyBoardSeparateLineColor   @"#CACACA" //分割线颜色

#define NumberToolViewPlaceHolder   @"0"     //text默认显示

#define KeyBoardSpaceControlTag 2100 //空白处control的tag值
#define keyBoardFloadAnimationDuration 0.25 //键盘 弹出/收起 动画时长
#endif /* HLNumberInputConst_h */
