//
//  UIView+DashLine.m
//  AnimationDemo
//
//  Created by Zhl on 2017/3/27.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import "UIView+DashLine.h"

@implementation UIView (DashLine)
/**
 *  在View上添加虚线（横向或纵向）
 *
 *  @param point 起始点
 *  @param size  size.width:虚线的 宽度      size.height:线粗
 *  @param isHorizontal 是否是水平方向
 */
-(void)drawDashLinefromPoint:(CGPoint)point LineSize:(CGSize)size  LineColor:(UIColor*)color AndIsHorizontal:(BOOL)isHorizontal{
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(point.x, point.y, size.width, size.height)];
    line.clipsToBounds = YES;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:line.bounds];
    [shapeLayer setPosition:CGPointMake(line.bounds.size.width/2.0, line.bounds.size.height/2.0)];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    
    // 设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:[color CGColor]];
    
    // 0.2f设置虚线的宽度（粗细）
    [shapeLayer setLineWidth:2.0f];
    
    // 3=线的宽度 1=每条线的间距
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:2],
      [NSNumber numberWithInt:2],nil]];
    
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    if (isHorizontal) {
        CGPathAddLineToPoint(path, NULL, line.frame.size.width,0);
    }else{
        CGPathAddLineToPoint(path, NULL, 0, line.frame.size.height);
    }
    [shapeLayer setPath:path];
    CGPathRelease(path);
    shapeLayer.masksToBounds = YES;
    [[line layer] addSublayer:shapeLayer];
    [self addSubview:line];
}
@end
