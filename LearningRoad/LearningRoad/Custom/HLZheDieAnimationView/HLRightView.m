//
//  HLRightView.m
//  AnimationDemo
//
//  Created by Zhl on 2017/3/23.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import "HLRightView.h"

@implementation HLRightView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arr = @[@"test",@"test2",@"test",@"test2",@"test",@"test2",@"test",@"test2",@"test",@"test2",@"test"];
        
        CGFloat x,y,w,h;
        
        w = frame.size.width/4.5;
        h = w;
        
        for (int i = 0; i<arr.count; i++) {
            x=i/3*w;
            y=frame.size.height-i%3*h-h;
            UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            itemBtn.frame = CGRectMake(x, y, w, h);
            [itemBtn addTarget:self action:@selector(itemBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [itemBtn setImage:[UIImage imageNamed:arr[i]] forState:UIControlStateNormal];
            itemBtn.tag = 2300+i+4;
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
            label.backgroundColor = [UIColor grayColor];
            label.text = [NSString stringWithFormat:@"%ld",(long)i+4];
            [itemBtn addSubview:label];
            [self addSubview:itemBtn];
        }
    }
    return self;
}
-(void)layoutSubviews{
    NSArray *arr = @[@"test",@"test2",@"test",@"test2",@"test",@"test2",@"test",@"test2",@"test",@"test2",@"test"];
    CGFloat x,y,w,h;
    
    w = self.frame.size.width/4.5;
    h = w;
    for (int i = 0; i<arr.count; i++) {
        x=i/3*w;
        y=self.frame.size.height-i%3*h-h;
        UIButton *itemBtn = (UIButton *)[self viewWithTag:2300+i+4];
        itemBtn.frame = CGRectMake(x, y, w, h);
    }
}
-(void)itemBtnClicked:(UIButton*)btn{
    if (self.rightItemClickedAtIndex!=nil) {
        self.rightItemClickedAtIndex(btn.tag-2300);
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
