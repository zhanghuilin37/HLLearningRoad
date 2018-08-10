//
//  HLPageControlView.m
//  Quartz2d
//
//  Created by CH10 on 15/11/9.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "HLPageControlView.h"
#define ScreenCutViewWidth rect.size.width
#define ScreenCutViewHeight rect.size.height

@interface HLPageControlView()
{
    BOOL _flag;
}
@property(nonatomic,copy)NSString *backImgName;
@property(nonatomic,copy)NSString *currentImgName;

@end
@implementation HLPageControlView

- (instancetype)initWithFrame:(CGRect)frame andPageNum:(NSInteger)pageNum andCurrentPage:(NSInteger)currentPage andCurrentImg:(NSString *)currentImgName andBgImg:(NSString *)bgImgName
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame=CGRectMake(frame.origin.x, frame.origin.y, pageNum*14+4, 18);
        self.numberOfPages = pageNum;
        self.currentPage = currentPage;
        self.currentImgName = currentImgName;
        self.backImgName = bgImgName;
    }
    return self;
}
-(void)setCurrentPage:(NSInteger)currentPage{
    if (currentPage!=_currentPage) {
        _currentPage = currentPage;
        _flag = YES;
        [self setNeedsDisplay];
    }
}
-(void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    [self setNeedsDisplay];
}
-(void)drawRect:(CGRect)rect{
    
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClearRect(ctx, rect);

    [self.backgroundColor set];
    CGContextSetLineWidth(ctx, 2);
    CGContextFillRect(ctx, rect);

    UIImage *currentImage  = [UIImage imageNamed:self.currentImgName];
    UIImage *image = [UIImage imageNamed:self.backImgName];
    //把图片绘制到view上



    for (int i = 0; i<self.numberOfPages; i++) {
        [image drawInRect:CGRectMake(4+14*i, 4, 10, 10)];
    }
    [currentImage drawInRect:CGRectMake(4+14*self.currentPage, 4, 10, 10)];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
