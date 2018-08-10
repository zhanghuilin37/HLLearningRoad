//
//  UILabel+CustomPackaging.m
//  LearningRoad
//
//  Created by ZHL on 16/3/24.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import "UILabel+CTPackage.h"

@implementation UILabel (CTPackage)
/**设置字体大小*/
-(void)ct_setTextFont:(UIFont *)font Range:(NSRange)range{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    
    [attStr addAttribute:NSFontAttributeName value:font range:range];
    self.attributedText = attStr;
}
/**设置字体颜色*/
-(void)ct_setTextColor:(UIColor*)textColor Range:(NSRange)range{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];

    [attStr addAttribute:NSForegroundColorAttributeName value:textColor range:range];
    self.attributedText = attStr;
}

/**字符间距*/
-(void)ct_setTextKern:(CGFloat)ctTextKern{
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange range = {0,attStr.length};
    NSNumber *kern = [NSNumber numberWithFloat:ctTextKern];
    [attStr addAttribute:NSKernAttributeName value:kern range:range];
    self.attributedText = attStr;
}
/**行间距*/
-(void)ct_setParagraphLineSpaceing:(CGFloat)paragraphLineSpaceing{

    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange range = {0,attStr.length};
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = paragraphLineSpaceing;
    [attStr addAttribute:NSParagraphStyleAttributeName value:paragraph range:range];
    self.attributedText = attStr;
}

/**悬挂缩进*/
-(void)ct_setParagraphHeadIndent:(CGFloat)paragraphHeadIndent{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange range = {0,attStr.length};
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.headIndent = paragraphHeadIndent;
    [attStr addAttribute:NSParagraphStyleAttributeName value:paragraph range:range];
    self.attributedText = attStr;
}

/**首行缩进*/
-(void)ct_setParagraphFirstLineHeadIndent:(CGFloat)paragraphFirstLineHeadIndent{

    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange range = {0,attStr.length};
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.firstLineHeadIndent = paragraphFirstLineHeadIndent;
    [attStr addAttribute:NSParagraphStyleAttributeName value:paragraph range:range];
    self.attributedText = attStr;
}

/**段前*/
-(void)ct_setParagraphSpacingBefore:(CGFloat)paragraphSpacingBefore{

    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange range = {0,attStr.length};
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.paragraphSpacingBefore = paragraphSpacingBefore;
    [attStr addAttribute:NSParagraphStyleAttributeName value:paragraph range:range];
    self.attributedText = attStr;
}

/**段后*/
-(void)ct_setParagraphSpacing:(CGFloat)paragraphSpacing{

    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange range = {0,attStr.length};
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.paragraphSpacing = paragraphSpacing;
    [attStr addAttribute:NSParagraphStyleAttributeName value:paragraph range:range];
    self.attributedText = attStr;
}
#pragma mark - 下划线
/**下划线*/
-(void)ct_setUnderLineStyle:(NSUnderlineStyle)underLineStyle{

    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange range = {0,attStr.length};
    [attStr addAttribute:NSUnderlineStyleAttributeName value:@(underLineStyle) range:range];
    self.attributedText = attStr;
}
-(void)ct_setUnderLineStyle:(NSUnderlineStyle)underLineStyle Range:(NSRange)range{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [attStr addAttribute:NSUnderlineStyleAttributeName value:@(underLineStyle) range:range];
    self.attributedText = attStr;
}
/**下划线颜色*/
-(void)ct_setUnderLineColor:(UIColor *)underLineColor{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange range = {0,attStr.length};
    [attStr addAttribute:NSUnderlineColorAttributeName value:underLineColor range:range];
    self.attributedText = attStr;
}




-(UILabel *)initWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont*)font textColor:(UIColor*)textColor{
    self = [[UILabel alloc] initWithFrame:frame];
    if (self) {
        
        self.text = text;
        self.font = font;
        self.textColor = textColor;
        
    }
    return self;
}
+(UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor{
    UILabel *label = [[UILabel alloc] initWithFrame:frame text:text font:font textColor:textColor];
    return label;
}
-(CGSize)customHeightWithSize:(CGSize)size{
    NSRange range = {0,self.text.length};
    NSLog(@"length ==== %ld",self.text.length);
    NSDictionary *attDict = [self.attributedText attributesAtIndex:0 effectiveRange:&range];
    
    
    CGSize sizeResult = [self.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attDict context:nil].size;
    
    NSLog(@"%@",attDict);
    CGFloat width =  self.frame.size.width;
    CGFloat height =  sizeResult.height;
    self.numberOfLines = 0;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, height);
    return sizeResult;
}
@end
