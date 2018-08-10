//
//  HLLabelsView.m
//  RunLoopDemo
//
//  Created by Zhl on 2017/9/12.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import "HLLabelsView.h"
#import "UIColor+Hex.h"
#define Hspace 5                //标签水平间距
#define Vspace 5                //标签垂直间距
#define LeftAndRightEdge 5      //标签相对view自身左右边距
#define UpAndDownEdge 5         //标签相对view自身上下边距
#define TextLeftAndRightEdge 5  //标签中text和矩形框的左右边距
#define TextUpAndDownEdge 2     //标签中text和矩形框的上下边距
#define TextRectCornerRadius 4  //标签矩形的圆角大小

@interface HLLabelsView()
@property (nonatomic,strong) NSMutableArray *textArr;
@end

@implementation HLLabelsView
+(CGFloat)getLabelsViewHeightWithTextModelArr:(NSArray *)textArr andWidth:(CGFloat)width{
    CGFloat x = LeftAndRightEdge,y=UpAndDownEdge,h=0;
    for (HLTextModel *model in textArr) {
        CGFloat rectWidth  = 0;
        CGFloat rectHeight = model.textSize.height+2*TextUpAndDownEdge;
        if ([model.hasRect isEqualToString:@"0"]) {
            rectWidth  = model.textSize.width;
        }else{
            rectWidth  = model.textSize.width +2*TextLeftAndRightEdge;
        }
        if (x+rectWidth+LeftAndRightEdge>width) {
            x=LeftAndRightEdge;
            y+=(rectHeight+Vspace);
        }
        x+=(rectWidth+Hspace);
        h=y+rectHeight+UpAndDownEdge;
    }
    
    return h;
}
+(instancetype)hlLabelsViewWithFrame:(CGRect)frame andTextModels:(NSArray *)models{
    HLLabelsView *view = [[HLLabelsView alloc] initWithFrame:frame andTextModels:models];
    return view;
}
- (instancetype)initWithFrame:(CGRect)frame andTextModels:(NSArray*)models
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textArr = [models mutableCopy];
    }
    return self;
}
-(void)drawRect:(CGRect)rect{
    
    CGFloat x = LeftAndRightEdge,y=UpAndDownEdge;
    for (HLTextModel *model in _textArr) {
        CGContextRef context = UIGraphicsGetCurrentContext();

        UIColor *tintColor   = [UIColor colorWithHexString:model.colorHexStr];
        CGFloat rectWidth  = model.textSize.width +2*TextLeftAndRightEdge;
        CGFloat rectHeight = model.textSize.height+2*TextUpAndDownEdge;
        if ([model.hasRect isEqualToString:@"0"]) {
            rectWidth  = model.textSize.width;
        }
        if (x+rectWidth+LeftAndRightEdge>rect.size.width) {
            x=LeftAndRightEdge,
            y+=(rectHeight+Vspace);
        }
        if ([model.hasRect isEqualToString:@"1"]) {
            //绘制圆角边框
            CGRect LineRect = CGRectMake(x, y, rectWidth, rectHeight);
            CGPathRef patch = CGPathCreateWithRoundedRect(LineRect, TextRectCornerRadius, TextRectCornerRadius, &CGAffineTransformIdentity);
            CGContextAddPath(context, patch);
            [tintColor setStroke];
            CGContextStrokePath(context);
            
            //绘制文字
            CGRect textRect = CGRectMake(x+TextLeftAndRightEdge, y+TextUpAndDownEdge, model.textSize.width, model.textSize.height);
            NSDictionary *attDic = @{NSFontAttributeName:[UIFont systemFontOfSize:model.fontPointSize],NSForegroundColorAttributeName:tintColor};
            [model.text drawInRect:textRect withAttributes:attDic];
            x+=(rectWidth+Hspace);
        }else{
            //绘制文字
            CGRect textRect = CGRectMake(x, y+TextUpAndDownEdge, model.textSize.width, model.textSize.height);
            NSDictionary *attDic = @{NSFontAttributeName:[UIFont systemFontOfSize:model.fontPointSize],NSForegroundColorAttributeName:tintColor};
            [model.text drawInRect:textRect withAttributes:attDic];
            x+=(rectWidth+Hspace);
        }
        
        CGContextStrokePath(context);
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
