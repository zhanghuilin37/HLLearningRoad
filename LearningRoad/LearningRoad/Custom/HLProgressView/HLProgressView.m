//
//  HLProgressView.m
//  CustomProgressTest
//
//  Created by CH10 on 15/11/18.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "HLProgressView.h"

@interface HLProgressView ()
{
    CADisplayLink *_display;
    BOOL _animated;
}
@property (nonatomic,assign)CGFloat tempProgress;

@end

@implementation HLProgressView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = frame.size.height<frame.size.width?frame.size.height/2:frame.size.width/2;
        self.layer.masksToBounds = YES;
        self.tempProgress = 0.0;
    }
    return self;
}
-(void)updateImage{
    [self setNeedsDisplay];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}
-(void)setAnimated:(BOOL)animated{
    _animated = animated;
}
-(void)setProgress:(CGFloat)progress andAinmated:(BOOL)animated{
    _animated = animated;
    if (_progress!=progress) {
        _progress = progress;
        if (_animated) {
            _display = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateImage)];
            [_display addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        }else{
            [self setNeedsDisplay];
        }
        
    }
}
-(void)setTempProgress:(CGFloat)tempProgress{
    if (_tempProgress!=tempProgress) {
        _tempProgress = tempProgress;
        [self setNeedsDisplay];
    }
}
-(void)setProgress:(CGFloat)progress{
    if (_progress!=progress) {
        _progress = progress;
    }
}
-(void)setTrackColor:(UIColor *)trackColor{
    if (_trackColor!=trackColor) {
        _trackColor = trackColor;
        [self setNeedsDisplay];
    }
}
-(void)setProgressColor:(UIColor *)progressColor{
    if (_progressColor!=progressColor) {
        _progressColor = progressColor;
        [self setNeedsDisplay];
    }
}
-(void)drawRect:(CGRect)rect{
    
    if (_animated) {
        if (_tempProgress<_progress) {
            if (_progress-_tempProgress<0.01) {
                _tempProgress = _progress;
                [_display removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            }else{
                _tempProgress+=0.01;
            }
        }
    }else{
        _tempProgress = _progress;
    }
    
    
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(ctx, 0, rect.size.height/2.0);
    CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height/2.0);
    CGContextSetLineWidth(ctx, rect.size.height);


    if (self.trackColor) {
        [self.trackColor setStroke];
    }else{
        [[UIColor grayColor] setStroke];
    }
    CGContextStrokePath(ctx);
    
    CGContextMoveToPoint(ctx, 0, rect.size.height/2.0);
    CGContextAddLineToPoint(ctx, rect.size.width*self.tempProgress, rect.size.height/2.0);
    CGContextSetLineWidth(ctx, rect.size.height);

    if (self.progressColor) {
        [self.progressColor setStroke];
    }else{
        [[UIColor cyanColor] setStroke];
    }
    CGContextStrokePath(ctx);
    
    NSString *str = [NSString stringWithFormat:@"%d%%",(int)(self.tempProgress*100)];
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.alignment = NSTextAlignmentCenter;
    para.lineSpacing = 0;
    CGContextSetTextDrawingMode (ctx, kCGTextFill);
    [str drawInRect:CGRectMake(0, rect.size.height/4.0-rect.size.height/14.0, rect.size.width, rect.size.height/2.0) withAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:rect.size.height/2.0],NSParagraphStyleAttributeName:para,NSForegroundColorAttributeName:[UIColor whiteColor],NSBackgroundColorAttributeName:[UIColor clearColor]}];
}

@end
