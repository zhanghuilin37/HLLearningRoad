//
//  UILabel+CTPackage.h
//  LearningRoad
//
//  Created by ZHL on 16/3/24.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//
/*=======================================================
 1、段前段后和缩进不能同时设置（以 后执行的为准）
 2、首行缩进和悬挂缩进不能同时设置 同上
 *=======================================================*/
#import <UIKit/UIKit.h>

@interface UILabel (CTPackage)
/**
 *  设置字体大小
 */
-(void)ct_setTextFont:(UIFont*)font Range:(NSRange)range;
/**
 * 设置字体颜色
 */
-(void)ct_setTextColor:(UIColor*)textColor Range:(NSRange)range;
/**
 * 字符间距
 */
-(void)ct_setTextKern:(CGFloat)pextKern;

#pragma mark - 段落样式
/**
 * 行间距
 */
-(void)ct_setParagraphLineSpaceing:(CGFloat)paragraphLineSpaceing;
/**
 * 悬挂缩进
 */
-(void)ct_setParagraphHeadIndent:(CGFloat)paragraphHeadIndent;
/**
 * 首行缩进
 */
-(void)ct_setParagraphFirstLineHeadIndent:(CGFloat)paragraphFirstLineHeadIndent;
/**
 * 段前
 */
-(void)ct_setParagraphSpacingBefore:(CGFloat)paragraphSpacingBefore;
/**
 * 段后
 */
-(void)ct_setParagraphSpacing:(CGFloat)paragraphSpacing;


#pragma mark - 下划线

/**
 * 下划线类型
 */
-(void)ct_setUnderLineStyle:(NSUnderlineStyle)underLineStyle;
-(void)ct_setUnderLineStyle:(NSUnderlineStyle)underLineStyle Range:(NSRange)range;
/**
 * 下划线颜色
 */
-(void)ct_setUnderLineColor:(UIColor *)underLineColor;


-(UILabel *)initWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont*)font textColor:(UIColor*)textColor;
+(UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont*)font textColor:(UIColor*)textColor;

/**-----------------------宽高是否自适应
 *cw:宽度是否自适应
 *ch:高度是否自适应
 *size:计算自适应宽高的标准
 */
-(CGSize)customHeightWithSize:(CGSize)size;

@end
