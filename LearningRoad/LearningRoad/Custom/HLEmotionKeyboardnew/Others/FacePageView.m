//
//  FacePageView.m
//  LotteryApp
//
//  Created by Feili on 13-9-4.
//  Copyright (c) 2013年 windo. All rights reserved.
//

#import "FacePageView.h"
#import "ReadLocalData.h"

#define BALLHIGHLIGHT  100001
#define cellSpaceWidth ([UIScreen mainScreen].bounds.size.width-24-7*32)/6
#define cellWidth (([UIScreen mainScreen].bounds.size.width-24-7*32)/6+32)
@implementation FacePageView

- (void)deleteButtonPressed {
    NSLog(@"FacePageView---deleteButtonPressed-");
    if ([_delegate respondsToSelector:@selector(faceDeleteClick)]) {
         [_delegate faceDeleteClick];
    }
}

- (id)initWithFrame:(CGRect)frame withPage:(NSInteger)page {
    self = [super initWithFrame:frame];
    if (self) {
        ReadLocalData *dataUtil = [ReadLocalData defaultReadLocalData];
        _faceImgArray = [dataUtil getFaceImgArray];
        _faceStrDict = [dataUtil getFaceStrDict];
        _curPage = page;
        
        [self addFaceToViewWithPage:page];
        
        self.backgroundColor = [UIColor clearColor];

    }
    return self;
}

- (void)addFaceToViewWithPage:(NSInteger)page {
    //（第0-19为表情图片， 第20个为删除键）
    
    //建立删除按钮
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.backgroundColor = [UIColor clearColor];
    deleteBtn.frame = CGRectMake(SCREEN_WIDTH-12-32, 100, 32, 32);
    [deleteBtn setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [deleteBtn setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateHighlighted];
    [deleteBtn addTarget:self action:@selector(deleteButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteBtn];
    
    CGRect rect = CGRectMake(12, 12, 32, 32);
    for (int i=0; i<3; i++) {
        for (int j=0; j<7; j++) {
            if (i*7+j == 20) {//删除键的位置
                return;
            }
            NSInteger index = page*20+i*7+j;
            if (index >= 114) {
                return;
            }
            UIImageView *faceImageView = [[UIImageView alloc] init];
            faceImageView.backgroundColor = [UIColor clearColor];
            faceImageView.userInteractionEnabled = YES;
            faceImageView.tag = index+100;
            faceImageView.frame = rect;
            [self addSubview:faceImageView];
            rect.origin.x += cellWidth;
        }
        rect.origin.x = 12;
        rect.origin.y += 44;
    }
}

- (void)setImgsWithPage:(NSInteger)page {
    for (NSInteger i=0; i<3; i++) {
        for (NSInteger j=0; j<7; j++) {
            if (i*7+j == 20) {
                return;
            }
            NSInteger index = page*20+i*7+j;
            if (index >= 114) {
                return;
            }
            
            UIImageView *faceImageView = (UIImageView*)[self viewWithTag:index+100];
            //如果该表情异步存入到数组则直接加载，如果没有则创建img后再加载
            if (index<[[ReadLocalData defaultReadLocalData] getImgsArray].count) {
                faceImageView.image = [[[ReadLocalData defaultReadLocalData] getImgsArray] objectAtIndex:index];
            } else {
                NSDictionary *curDict = [[[ReadLocalData defaultReadLocalData]getFaceImgArray] objectAtIndex:index];
                UIImage *img = [UIImage imageNamed:[curDict objectForKey:@"png"]];
                faceImageView.image = img;
            }
        }
    }
    
}


#pragma mark -- 删除点击小图后的大图和大图上数字
- (void)removeBallHighlight {
    for (UIView *tmpView in [UIApplication sharedApplication].delegate.window.subviews) {
        if (tmpView.tag == BALLHIGHLIGHT) {
            [tmpView removeFromSuperview];
        }
    }
}



#pragma mark -- 获取view上点击表情图片按钮的绝对坐标
- (CGPoint)getSelectNumberPoint:(CGPoint)windowPoint withCellPoint:(CGPoint)cellPoint andYofBallorigin:(CGPoint)cellBallOrigin {

    CGPoint testPoint ;
    if (windowPoint.x >= 12+cellWidth*6) {
        testPoint.x = 12+cellWidth*6;
    } else if (windowPoint.x >= 12+cellWidth*5) {
        testPoint.x = 12+cellWidth*5;
    } else if (windowPoint.x >= 12+cellWidth*4) {
        testPoint.x = 12+cellWidth*4;
    } else if (windowPoint.x >= 12+cellWidth*3) {
        testPoint.x = 12+cellWidth*3;
    } else if (windowPoint.x >= 12+cellWidth*2) {
        testPoint.x = 12+cellWidth*2;
    } else if (windowPoint.x >= 12+cellWidth) {
        testPoint.x = 12+cellWidth;
    } else if (windowPoint.x >= 12-12) {
        testPoint.x = 12;
    }
    
    testPoint.y = windowPoint.y - cellPoint.y + cellBallOrigin.y;
    
    return testPoint;
}


#pragma mark -- 添加点击小图后的大图和大图上的表情图
- (void)addBallHighlight:(NSInteger)SeleteNumber withLocation:(CGPoint)location {
    UIImageView *_numberImageGround  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"emoticon_keyboard_magnifier"]];
    
    _numberImageGround.tag = BALLHIGHLIGHT;
    _numberImageGround.frame = CGRectMake(location.x-16 , location.y+16-92, 64, 92);
    _numberImageGround.alpha = 1;
    [[UIApplication sharedApplication].delegate.window addSubview:_numberImageGround];
    
    NSDictionary *curDict = [self.faceImgArray objectAtIndex:SeleteNumber];
    
    UIImageView *curImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 15, 32, 32)] ;
    curImageView.backgroundColor = [UIColor clearColor];
    curImageView.userInteractionEnabled = YES;
    curImageView.image = [UIImage imageNamed:[curDict objectForKey:@"png"]];
    [_numberImageGround addSubview:curImageView];
}


#pragma mark -- touch事件了
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([_delegate respondsToSelector:@selector(controlScroll:)]) {
        [_delegate controlScroll:2];
    }
    
    //[self.delegate tableViewScrll:YES];
    UITouch *touch = [touches anyObject];
    
    //点击后取得在 view 上的坐标点
    CGPoint locationCel = [touch locationInView:self];
    //点击后取得在window上的坐标点
    CGPoint locationWin = [touch locationInView:[UIApplication sharedApplication].delegate.window];
    
    if (locationCel.y < 0 || locationCel.y >130) {
        return;
    }
    
    if (locationCel.x >= SCREEN_WIDTH-36-12 && locationCel.y >= 88) {
        return;
    }
    
    //删除所有的redballHighlight
    [self removeBallHighlight];
    
    CGFloat curX = locationCel.x;
    CGFloat curY = locationCel.y;
    
    int curIntX = (int)curX;
    int curIntY = (int)curY;
    
    int hang = curIntY/44;
    
    int lei = 0;
    if (curIntX < 12) {
        lei = 0;
    } else if (curIntX >= 12 && curIntX < SCREEN_WIDTH-12) {
        int intcellwid = (int)cellWidth;
        lei = (curIntX-12)/intcellwid;
    } else if (curIntX >=SCREEN_WIDTH-12) {
        lei = 12;
    }
    
    int sss = 7*hang+lei;
    
    UIImageView *tmpImage = (UIImageView *)[self viewWithTag:sss+20*_curPage+100];
    CGRect tmpRect = tmpImage.frame;
    
    CGPoint locations;
    locations.x = tmpRect.origin.x;
    locations.y = tmpRect.origin.y;
    
    //选中表情的位置
    NSInteger testNumber = sss+20*_curPage;
    
    if (testNumber > 113) {
        return;
    }
    
    //所选表情的绝对坐标点
    CGPoint absoluteCoordinate = [self getSelectNumberPoint:locationWin withCellPoint:locationCel andYofBallorigin:locations];
    
    //把所选号码背景图加到window上
    [self addBallHighlight:testNumber withLocation:absoluteCoordinate];
    
    return;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchMoved");
    
    UITouch *touch = [touches anyObject];
    //点击后取得在 view 上的坐标点
    CGPoint locationCel = [touch locationInView:self];
    //点击后取得在window上的坐标点
    CGPoint locationWin = [touch locationInView:[UIApplication sharedApplication].delegate.window];
    
    //删除所有的redballHighlight
    [self removeBallHighlight];
    //表情下方的空白
    if (locationCel.y < 0 || (locationCel.y >=130)) {
        return;
    }
    //删除键
    if (locationCel.x >= SCREEN_WIDTH-12-36 && locationCel.y >= 88) {
        return;
    }
    
    
    CGFloat curX = locationCel.x;
    CGFloat curY = locationCel.y;
    
    int curIntX = (int)curX;
    int curIntY = (int)curY;
    
    int hang = curIntY/44;
    int lei = 0;
    if (curIntX < 12) {
        lei = 0;
    } else if (curIntX >= 12 && curIntX < SCREEN_WIDTH-12) {
        int intwid = (int)cellWidth;
        lei = (curIntX-12)/intwid;
    } else if (curIntX >=SCREEN_WIDTH-12) {
        lei = 12;
    }
    
    int sss = 7*hang+lei;
    
    UIImageView *tmpImage = (UIImageView *)[self viewWithTag:sss+20*_curPage+100];
    CGRect tmpRect = tmpImage.frame;
    
    CGPoint locations;
    locations.x = tmpRect.origin.x;
    locations.y = tmpRect.origin.y;
    
    //选中表情的位置
    NSInteger testNumber = sss+20*_curPage;
    
    if (testNumber > 113) {
        return;
    }
    
    //所选表情的绝对坐标点
    CGPoint absoluteCoordinate = [self getSelectNumberPoint:locationWin withCellPoint:locationCel andYofBallorigin:locations];
    
    //把所选号码背景图加到window上
    [self addBallHighlight:testNumber withLocation:absoluteCoordinate];
    
    return;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    //删除所有的redballHighlight
    [self removeBallHighlight];
    if ([_delegate respondsToSelector:@selector(controlScroll:)]) {
        [_delegate controlScroll:1];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self performSelector:@selector(touchEnd:) withObject:nil afterDelay:0.1];
    
    UITouch *touch = [touches anyObject];
    //点击后取得在 view 上的坐标点
    CGPoint locationCel = [touch locationInView:self];
    NSLog(@"point.x = %f",locationCel.x);
    NSLog(@"point.y = %f",locationCel.y);
    //点击后取得在window上的坐标点
//    CGPoint locationWin = [touch locationInView:[UIApplication sharedApplication].delegate.window];
    //表情下方的空白处
    if (locationCel.y < 0 || (locationCel.y >=130)) {
        return;
    }
    //删除键
    if (locationCel.x >= SCREEN_WIDTH-12-36 && locationCel.y >= 88) {
        return;
    }
    
    CGFloat curX = locationCel.x;
    CGFloat curY = locationCel.y;
    
    int curIntX = (int)curX;
    int curIntY = (int)curY;
    
    int hang = curIntY/44;
    int lei = 0;
    NSLog(@"%f",cellWidth);
    if (curIntX < 6) {
        lei = 0;
    } else if (curIntX >= 12 && curIntX < SCREEN_WIDTH-12) {
        int intwid = (int)cellWidth;
        lei = (curIntX-12)/intwid;
    } else if (curIntX >=SCREEN_WIDTH-12) {
        lei = 6;
    }
    
    int sss = 7*hang+lei;
    
    UIImageView *tmpImage = (UIImageView *)[self viewWithTag:sss+20*_curPage+100];
    CGRect tmpRect = tmpImage.frame;
    
    CGPoint locations;
    locations.x = tmpRect.origin.x;
    locations.y = tmpRect.origin.y;
    
    //选中表情的位置
    NSInteger testNumber = sss+20*_curPage;
    
    if (testNumber > 113) {
        return;
    }
    
    NSDictionary *curDict = [self.faceImgArray objectAtIndex:testNumber];
    NSString *nameStr = [curDict objectForKey:@"chs"];
    if ([_delegate respondsToSelector:@selector(faceSelectedName:)]) {
        [_delegate faceSelectedName:nameStr];
    }
}

- (void)touchEnd:(id)cur {
    //删除所有的redballHighlight
    [self removeBallHighlight];
    if ([_delegate respondsToSelector:@selector(controlScroll:)]) {
        [_delegate controlScroll:1];
    }
    
}

@end
