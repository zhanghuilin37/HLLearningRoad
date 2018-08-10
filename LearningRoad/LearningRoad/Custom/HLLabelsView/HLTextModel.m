//
//  HLTextModel.m
//  RunLoopDemo
//
//  Created by Zhl on 2017/9/12.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import "HLTextModel.h"
#import <UIKit/UIKit.h>
@implementation HLTextModel
-(void)setText:(NSString *)text{
    if (text.length) {
        _text = text;
        CGSize textSize = [_text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_fontPointSize]} context:nil].size;
        _textSize = CGSizeMake(textSize.width, textSize.height);
    }
    
}
@end
