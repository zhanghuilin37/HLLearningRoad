//
//  FacePageView.m
//  demo
//
//  Created by Zhl on 16/9/26.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import "FacePageView.h"
#import "ReadLocalData.h"
#define faceImgVWidht

@interface FacePageView ()
@end

@implementation FacePageView
-(instancetype)initWithFrame:(CGRect)frame FaceImgArray:(NSArray*)faceImgArray{
    self = [super initWithFrame:frame];
    if (self) {
        [self.facePageArr addObjectsFromArray:faceImgArray];
        [self addFaceToView];
    }
    return self;
}
-(void)addFaceToView{
    for (int i = 0; i<3; i++) {
        for (int j = 0; j<7; j++) {
            
            NSInteger index = i*7+j;
            if (index>=self.facePageArr.count) {
                return;
            }
            NSDictionary *dic = [self.facePageArr objectAtIndex:index];
            UIImage *img = [UIImage imageNamed:[dic valueForKey:@"png"]];
            CGFloat w = 32,h=32,
            x = SCREEN_WIDTH/7.0*j+(SCREEN_WIDTH/7.0-w)/2.0,
            y = SCREEN_WIDTH/7.0*i+(SCREEN_WIDTH/7.0-h)/2.0;
            UIImageView *faceImgV = [[UIImageView alloc] initWithImage:img];
            faceImgV.frame = CGRectMake(x, y, w, h);
            faceImgV.image = img;
            [self addSubview:faceImgV];
        }
    }
}
-(NSMutableArray *)facePageArr{
    if (_facePageArr == nil) {
        _facePageArr = [[NSMutableArray alloc] init];
    }
    return _facePageArr;
}
#pragma mark ---------------------------- Actions
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    UITouch *touch = [touches anyObject];
    
    //点击后取得在 view 上的坐标点
    CGPoint locationCel = [touch locationInView:self];
    //点击后取得在window上的坐标点
//    CGPoint locationWin = [touch locationInView:[UIApplication sharedApplication].delegate.window];
    NSLog(@"lx:%f  ly:%f",locationCel.x,locationCel.y);
    [self getFaceNameWithLocationCel:locationCel];
    
    return;
}
-(void)getFaceNameWithLocationCel:(CGPoint)point{
    CGFloat x = point.x, y = point.y;
    NSInteger hang = 0;
    NSInteger lie = 0;
    lie = x/(SCREEN_WIDTH/7.0);
    hang = y/(SCREEN_WIDTH/7.0);
    NSLog(@"hang:%ld lie:%ld",(long)hang,(long)lie);
    NSInteger index = hang*7+lie;
    if (index<self.facePageArr.count) {
        NSDictionary *dic = [self.facePageArr objectAtIndex:index];
        if (self.faceDic!=nil&index<self.facePageArr.count-1) {
            self.faceDic(dic);
        }
        if (index == self.facePageArr.count-1) {//点击了删除按钮
            if(self.faceDeleteClick!=nil){
                self.faceDeleteClick();
            }
        }
    }
    
}
@end
