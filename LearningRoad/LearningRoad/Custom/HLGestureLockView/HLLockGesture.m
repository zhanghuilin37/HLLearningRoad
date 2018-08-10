//
//  HLGestureLock.m
//  codeDemo
//
//  Created by Zhl on 16/7/8.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import "HLLockGesture.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface HLLockGesture ()

@end

@implementation HLLockGesture
{
    BOOL isFirstDraw;
    BOOL one;
    BOOL two;
    BOOL three;
    BOOL four;
    BOOL five;
    BOOL six;
    BOOL seven;
    BOOL enight;
    BOOL nine;
    CGRect oneF;
    CGRect twoF;
    CGRect threeF;
    CGRect fourF;
    CGRect fiveF;
    CGRect sixF;
    CGRect sevenF;
    CGRect enightF;
    CGRect nineF;
    
    CGPoint oneCenter;
    CGPoint twoCenter;
    CGPoint threeCenter;
    CGPoint fourCenter;
    CGPoint fiveCenter;
    CGPoint sixCenter;
    CGPoint sevenCenter;
    CGPoint enightCenter;
    CGPoint nineCenter;
    
    CGPoint beforePoint;
    NSMutableString *passWordStr;
    
    
}
-(instancetype)initWithTarget:(id)target action:(SEL)action{
    self = [super initWithTarget:target action:action];
    if (self) {

        
    }
    return self;
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    self.finalPassWordStr = [[NSMutableString alloc] initWithString:passWordStr];
    [self clearlineLayer];
    [self setState:UIGestureRecognizerStateEnded];
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    self.finalPassWordStr = [[NSMutableString alloc] initWithString:passWordStr];
    [self clearlineLayer];
    [self setState:UIGestureRecognizerStateCancelled];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    //区域
    CGFloat jian = 40;
    CGFloat width =(self.view.frame.size.width-jian*3)/3.0;
    CGFloat w = jian+width;
    oneF    = CGRectMake(20,     20,     width, width);
    twoF    = CGRectMake(20+w,   20,     width, width);
    threeF  = CGRectMake(20+w*2, 20,     width, width);
    fourF   = CGRectMake(20,     20+w,   width, width);
    fiveF   = CGRectMake(20+w,   20+w,   width, width);
    sixF    = CGRectMake(20+w*2, 20+w,   width, width);
    sevenF  = CGRectMake(20,     20+w*2, width, width);
    enightF = CGRectMake(20+w,   20+w*2, width, width);
    nineF   = CGRectMake(20+w*2, 20+w*2, width, width);
    
    //中心点
    oneCenter    = CGPointMake(oneF.origin.x    + width/2.0,    oneF.origin.y+width/2.0);
    twoCenter    = CGPointMake(twoF.origin.x    + width/2.0,    twoF.origin.y+width/2.0);
    threeCenter  = CGPointMake(threeF.origin.x  + width/2.0,  threeF.origin.y+width/2.0);
    fourCenter   = CGPointMake(fourF.origin.x   + width/2.0,   fourF.origin.y+width/2.0);
    fiveCenter   = CGPointMake(fiveF.origin.x   + width/2.0,   fiveF.origin.y+width/2.0);
    sixCenter    = CGPointMake(sixF.origin.x    + width/2.0,    sixF.origin.y+width/2.0);
    sevenCenter  = CGPointMake(sevenF.origin.x  + width/2.0,  sevenF.origin.y+width/2.0);
    enightCenter = CGPointMake(enightF.origin.x + width/2.0, enightF.origin.y+width/2.0);
    nineCenter   = CGPointMake(nineF.origin.x   + width/2.0,   nineF.origin.y+width/2.0);

    
    //重置数据
    [self resetData];
    //获取多点触碰点钟的任意一个触碰点
    UITouch *touch = [touches anyObject];
    //获取触碰点在self.view中的坐标
    CGPoint point = [touch locationInView:self.view];
    [self getNumWithPoint:point isFirst:YES];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    //获取触碰点在self.view中的坐标
    CGPoint point = [touch locationInView:self.view];
    [self getNumWithPoint:point isFirst:NO];
}
//
-(BOOL)judgePoint:(CGPoint)point InRect:(CGRect)rect{
    CGFloat px = point.x,py = point.y;
    CGFloat minRx = rect.origin.x,maxRx = rect.origin.x+rect.size.width,
            minRy = rect.origin.y,maxRy = rect.origin.y+rect.size.height;
    if (px>=minRx&&px<maxRx&&py>=minRy&&py<maxRy) {
        return YES;
    }
    return NO;
}

-(void)getNumWithPoint:(CGPoint)point isFirst:(BOOL)isFirst{
    if (passWordStr.length) {
        
    }else{
        passWordStr = [[NSMutableString alloc] init];
    }
    if (passWordStr.length>=9) {
        self.finalPassWordStr = [[NSMutableString alloc] initWithString:passWordStr];
        [self clearlineLayer];
        self.state = UIGestureRecognizerStateEnded;
    }
    if ([self judgePoint:point InRect:oneF]) {
        if (one) {
            return;
        }
        if (isFirst) {
            beforePoint = CGPointMake(oneCenter.x, oneCenter.y);
        }else{
            [self drawLineToPoint:oneCenter];
        }
        one = YES;
        [passWordStr appendString:@"1"];
    }else if ([self judgePoint:point InRect:twoF]){
        if (two) {
            return;
        }
        if (isFirst) {
            beforePoint = CGPointMake(twoCenter.x, twoCenter.y);
        }else{
            [self drawLineToPoint:twoCenter];
        }
        two = YES;
        [passWordStr appendString:@"2"];
    }else if ([self judgePoint:point InRect:threeF]){
        if (three) {
            return;
        }
        if (isFirst) {
            beforePoint = CGPointMake(threeCenter.x, threeCenter.y);
        }else{
            [self drawLineToPoint:threeCenter];
        }
        three = YES;
        [passWordStr appendString:@"3"];
    }else if ([self judgePoint:point InRect:fourF]){
        if (four) {
            return;
        }
        if (isFirst) {
            beforePoint = CGPointMake(fourCenter.x, fourCenter.y);
        }else{
            [self drawLineToPoint:fourCenter];
        }
        four = YES;
        [passWordStr appendString:@"4"];
    }else if ([self judgePoint:point InRect:fiveF]){
        if (five) {
            return;
        }
        if (isFirst) {
            beforePoint = CGPointMake(fiveCenter.x, fiveCenter.y);
        }else{
            [self drawLineToPoint:fiveCenter];
        }
        five = YES;
        [passWordStr appendString:@"5"];
    }else if ([self judgePoint:point InRect:sixF]){
        if (six) {
            return;
        }
        if (isFirst) {
            beforePoint = CGPointMake(sixCenter.x, sixCenter.y);
        }else{
            [self drawLineToPoint:sixCenter];
        }
        six = YES;
        [passWordStr appendString:@"6"];
    }else if ([self judgePoint:point InRect:sevenF]){
        if (seven) {
            return;
        }
        if (isFirst) {
            beforePoint = CGPointMake(sevenCenter.x, sevenCenter.y);
        }else{
            [self drawLineToPoint:sevenCenter];
        }
        seven = YES;
        [passWordStr appendString:@"7"];
    }else if ([self judgePoint:point InRect:enightF]){
        if (enight) {
            return;
        }
        if (isFirst) {
            beforePoint = CGPointMake(enightCenter.x, enightCenter.y);
        }else{
            [self drawLineToPoint:enightCenter];
        }
        enight = YES;
        [passWordStr appendString:@"8"];
    }else if ([self judgePoint:point InRect:nineF]){
        if (nine) {
            return;
        }
        if (isFirst) {
            beforePoint = CGPointMake(nineCenter.x, nineCenter.y);
        }else{
            [self drawLineToPoint:nineCenter];
        }
        nine = YES;
        [passWordStr appendString:@"9"];
    }
    NSLog(@"%@",passWordStr);
}
-(void)resetData{
    isFirstDraw = YES;
    one = NO;
    two = NO;
    three = NO;
    four = NO;
    five = NO;
    six = NO;
    seven = NO;
    enight = NO;
    nine = NO;
    if (passWordStr.length) {
        [passWordStr setString:@""];
    }
    [self clearlineLayer];
}
-(void)clearlineLayer{
    NSArray *layers =[[NSArray alloc] initWithArray:self.view.layer.sublayers];
    for (int i = 0; i<layers.count; i++) {
        CALayer *layer = [layers objectAtIndex:i];
        [layer removeFromSuperlayer];
    }
}
-(void)drawLineToPoint:(CGPoint)currentCenterPoint{
    CGRect lineRect = self.view.bounds;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineRect];
    [shapeLayer setPosition:CGPointMake(lineRect.size.width/2.0, lineRect.size.height/2.0)];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    
    // 设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:[[UIColor greenColor] CGColor]];
    [shapeLayer setFillColor:[UIColor greenColor].CGColor];
    // 0.2f设置虚线的宽度（粗细）
    [shapeLayer setLineWidth:4.0f];
    
    // 3=线的宽度 1=每条线的间距
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:7],
      [NSNumber numberWithInt:0],nil]];
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, beforePoint.x, beforePoint.y);
    if (isFirstDraw) {
        // x/y 圆心
        // radius 半径
        // startAngle 开始的弧度
        // endAngle 结束的弧度
        // clockwise 画圆弧的方向 (0 顺时针, 1 逆时针)
        CGPathAddArc(path, &CGAffineTransformIdentity, beforePoint.x, beforePoint.y, 10, 0, 2*M_PI, NO);
        CGPathCloseSubpath(path);
        isFirstDraw = NO;
    }
    CGPathAddLineToPoint(path, NULL, currentCenterPoint.x,currentCenterPoint.y);
    // x/y 圆心
    // radius 半径
    // startAngle 开始的弧度
    // endAngle 结束的弧度
    // clockwise 画圆弧的方向 (0 顺时针, 1 逆时针)
    CGPathMoveToPoint(path, NULL, currentCenterPoint.x, currentCenterPoint.y);
    CGPathAddArc(path, &CGAffineTransformIdentity, currentCenterPoint.x, currentCenterPoint.y, 10, 0, 2*M_PI, NO);
    CGPathCloseSubpath(path);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    [self.view.layer addSublayer:shapeLayer];
    beforePoint = CGPointMake(currentCenterPoint.x, currentCenterPoint.y);
    
}
@end
