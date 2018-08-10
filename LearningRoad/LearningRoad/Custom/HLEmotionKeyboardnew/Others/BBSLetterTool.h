//
//  BBSLetterTool.h
//  HandicapWin
//
//  Created by CH10 on 16/4/1.
//  Copyright © 2016年 张金鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYText.h"
@protocol BBSLetterToolDelegate <NSObject>
@optional
/**
 链接文本被点击
 */
-(void)letterClickedLinkStr:(NSString *)linkStr;
@end

@interface BBSLetterTool : NSObject
@property (nonatomic,assign)id<BBSLetterToolDelegate>delegate;
/**
 *处理str为图文混排并且带连接的属性文本
 */
+(NSMutableAttributedString*)manageBBSLetterStr:(NSString *)str WithDelegate:(id<BBSLetterToolDelegate>)delegate;
/**
 *获取处理后的文本的高度
 */
//+ (CGFloat)getLetterHeight:(NSString*)str padd:(CGFloat)pad;
+ (CGFloat)getLetterHeight:(NSString*)str  padd:(CGFloat)pad WithWidth:(CGFloat)width;
@end







/**
 文本 Line 位置修改
 将每行文本的高度和位置固定下来，不受中英文/Emoji字体的 ascent/descent 影响
 */
@interface WBTextLinePositionModifier : NSObject <YYTextLinePositionModifier>

@property (nonatomic, strong) UIFont *font; // 基准字体 (例如 Heiti SC/PingFang SC)
@property (nonatomic, assign) CGFloat paddingTop; //文本顶部留白
@property (nonatomic, assign) CGFloat paddingBottom; //文本底部留白
@property (nonatomic, assign) CGFloat lineHeightMultiple; //行距倍数
- (CGFloat)heightForLineCount:(NSUInteger)lineCount;

@end

