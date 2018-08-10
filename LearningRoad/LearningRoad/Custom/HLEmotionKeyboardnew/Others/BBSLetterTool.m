//
//  BBSLetterTool.m
//  HandicapWin
//
//  Created by CH10 on 16/4/1.
//  Copyright © 2016年 张金鹏. All rights reserved.
//

#import "BBSLetterTool.h"
#define kiOS9Later (kSystemVersion >= 9)
#define letterFont 17


@implementation WBTextLinePositionModifier

- (instancetype)init {
    self = [super init];
    
    _lineHeightMultiple = 1.34;
    return self;
}

- (void)modifyLines:(NSArray *)lines fromText:(NSAttributedString *)text inContainer:(YYTextContainer *)container {
    //CGFloat ascent = _font.ascender;
    CGFloat ascent = _font.pointSize*0.16;
    
    CGFloat lineHeight = _font.pointSize * _lineHeightMultiple;
    for (YYTextLine *line in lines) {
        CGPoint position = line.position;
        position.y = _paddingTop + ascent + line.row  * lineHeight;
        line.position = position;
    }
}

- (id)copyWithZone:(NSZone *)zone {
    WBTextLinePositionModifier *one = [self.class new];
    one->_font = _font;
    one->_paddingTop = _paddingTop;
    one->_paddingBottom = _paddingBottom;
    one->_lineHeightMultiple = _lineHeightMultiple;
    return one;
}
//行高15*1.34 = 20.1
- (CGFloat)heightForLineCount:(NSUInteger)lineCount {
    if (lineCount == 0) return 0;
    CGFloat ascent = _font.pointSize*0.84;
    CGFloat descent = _font.pointSize*0.16;
    CGFloat lineHeight = _font.pointSize * _lineHeightMultiple;
    return _paddingTop + _paddingBottom + ascent + descent + (lineCount-1) * lineHeight;
}

@end


@implementation BBSLetterTool

//处理字符串
+(NSMutableAttributedString*)manageBBSLetterStr:(NSString *)str WithDelegate:(id<BBSLetterToolDelegate>)delegate{
    
    BBSLetterTool *tool = [[BBSLetterTool alloc] init];
    NSArray *arr = [tool getBBSLetterSubStrRangeArrWithStr:str];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange strRange = {0,str.length};
    [string addAttribute:NSForegroundColorAttributeName value:rgb(58, 58, 58, 1) range:strRange];

    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:letterFont] range:strRange];
    for (NSInteger i = arr.count-1; i>=0; i--) {
        NSTextCheckingResult *result = [arr objectAtIndex:i];
        NSString *str1 = [str substringWithRange:result.range];
        NSLog(@"%@",str1);
        NSRange range = result.range;
        if ([str1 hasPrefix:@"["]) {//表情
            NSMutableAttributedString *attachText = nil;
            //添加静态表情
            NSDictionary *dic = [BBSLetterTool getFaceStrDict];
            attachText = [tool addStaticEmotionWithImageName:[dic valueForKey:str1]];
            [string deleteCharactersInRange:range];
            [string insertAttributedString:attachText atIndex:range.location];
            
        }
        else if ([str1 hasPrefix:@"@"]){
            [string yy_setTextHighlightRange:range
                                       color:[LRTools hl_colorWithHexString:@"5f7ea3"]
                             backgroundColor:[UIColor grayColor]
                                   tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                                       if ([delegate respondsToSelector:@selector(letterClickedLinkStr:)]){
                                           [delegate letterClickedLinkStr:[text.string substringWithRange:range]];
                                       }
                                       
                                   }];
            
        }
        else if ([str1 hasPrefix:@"#"]){
                    //236 117 38
                    [string yy_setTextHighlightRange:range
                                               color:rgb(236, 117, 38, 1)
                                     backgroundColor:[UIColor grayColor]
                                           tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                                               if([delegate respondsToSelector:@selector(letterClickedLinkStr:)]){
                                                   [delegate letterClickedLinkStr:[text.string substringWithRange:range]];
                                               }
                                           }];
                }
    }
    if (string.length) {
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = [UIFont systemFontOfSize:letterFont].pointSize * 0.14;
        NSRange range = {0,string.string.length};
        [string addAttribute:NSParagraphStyleAttributeName value:style range:range];
        [string addAttribute:NSBackgroundColorAttributeName value:[UIColor grayColor] range:range];
    }
    return string;
}
/**
 *获取处理后的文本高度
 */
+ (CGFloat)getLetterHeight:(NSString*)str  padd:(CGFloat)pad WithWidth:(CGFloat)width{
    NSMutableAttributedString *text = [BBSLetterTool manageBBSLetterStr:str WithDelegate:nil];
    
    if (text.length==0) {
        return 0.000001;
    }
    WBTextLinePositionModifier *modifier = [WBTextLinePositionModifier new];
    modifier.font = [UIFont systemFontOfSize:letterFont];
    modifier.paddingTop = pad;
    modifier.paddingBottom = pad;
    
    YYTextContainer *container = [YYTextContainer new];
    container.size = CGSizeMake(width, HUGE);
    container.linePositionModifier = modifier;
    
    YYTextLayout *textLayout = [YYTextLayout layoutWithContainer:container text:text];
    
    CGFloat textHeight = [modifier heightForLineCount:textLayout.rowCount];
    
    return textHeight;
    
    
//    NSRange range = {0,text.string.length};
//    NSDictionary *attDict = [text attributesAtIndex:0 effectiveRange:&range];
//    
//    CGSize sizeResult = [text.string boundingRectWithSize:CGSizeMake(width, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attDict context:nil].size;
//    
//    return sizeResult.height;
//    NSLog(@"%@",attDict);
//    CGFloat width = cw ? sizeResult.width : self.frame.size.width;
//    CGFloat height = ch ? sizeResult.height : self.frame.size.height;
//    self.numberOfLines = 0;
//    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, height);
    
}
/**
 *获取本地表情数组
 */
+ (NSArray *)getFaceImgArray
{
    static NSArray *faceImgArray;
    
    if (nil == faceImgArray) {
        //读取表情字典
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"faceInfo" ofType:@"plist"];
        NSDictionary *faceDictionary = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        
        faceImgArray = [faceDictionary objectForKey:@"emoticon_group_emoticons"];
    }
    
    return faceImgArray;
}
/**
 *获取本地表情字典
 */
+ (NSDictionary *)getFaceStrDict
{
    static NSDictionary *faceStrDict;
    if (nil == faceStrDict) {
        //读取解析表情的字典
        NSString *jieXiplistPath = [[NSBundle mainBundle] pathForResource:@"jieXiFaceInfo" ofType:@"plist"];
        
        faceStrDict = [[NSDictionary alloc] initWithContentsOfFile:jieXiplistPath];
    }
    return faceStrDict;
}





/**
 *获取需要处理的子字符串和子串的range
 */
-(NSArray *)getBBSLetterSubStrRangeArrWithStr:(NSString *)str{
    //[...]表情
    //@"\\[[a-zA-Z\\u4e00-\\u9fa5]+\\]"
    NSString *emopattern=@"\\[[\u4e00-\u9fa5\\w]+\\]" ;
    //#...#话题
    //@"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#"
//   @"#[\u4e00-\u9fa5\\w\\s]+#";
    NSString *toppattern =  @"#[^#]+#";
    //@...@
    //@"@[0-9a-zA-Z\\U4e00-\\u9fa5]+"
    NSString *atpattern = @"@[\u4e00-\u9fa5\\w]+";
    //url
    //@"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))"
    //@"http://[-a-zA-Z0-9+&@#/%?=~_|!:,.;]*[-a-zA-Z0-9+&@#/%=~_|]"
    NSString *urlpattern = @"http://[-a-zA-Z0-9+&@#/%?=~_|!:,.;]*[-a-zA-Z0-9+&@#/%=~_|]";
    NSString *urlpattern1 = @"https://[-a-zA-Z0-9+&@#/%?=~_|!:,.;]*[-a-zA-Z0-9+&@#/%=~_|]";
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@|%@",emopattern,toppattern,atpattern,urlpattern,urlpattern1];
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *results = [regular matchesInString:str options:0 range:NSMakeRange(0, str.length)];
    
    return results;
}

//添加静态表情
-(NSMutableAttributedString*)addStaticEmotionWithImageName:(NSString*)imgName{
    
    UIImage *image = [UIImage imageNamed:imgName];
    //3
    CGFloat scale = image.size.width/letterFont*2-0.68;
    image = [UIImage imageWithCGImage:image.CGImage scale:scale orientation:UIImageOrientationUp];
    NSMutableAttributedString *attachment = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:[UIFont systemFontOfSize:letterFont] alignment:YYTextVerticalAlignmentCenter];
    return attachment;
}
//添加动态表情
//-(NSMutableAttributedString *)addAnimationEmotionWithPath:(NSString*)path{
//    {
//        
//        NSData *data = [NSData dataWithContentsOfFile:path];
//        YYImage *image = [YYImage imageWithData:data scale:2];
//        image.preloadAllAnimatedImageFrames = YES;
//        YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
//        NSMutableAttributedString *attachText  = [NSMutableAttributedString attachmentStringWithContent:imageView contentMode:UIViewContentModeCenter attachmentSize:imageView.size alignToFont:[UIFont systemFontOfSize:25.59/2.0] alignment:YYTextVerticalAlignmentCenter];
//        return attachText;
//    }
//    
//}


@end
