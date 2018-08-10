//
//  HLAnimationView.m
//  AnimationDemo
//
//  Created by Zhl on 2017/3/22.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import "HLAnimationView.h"
#import <WebKit/WebKit.h>
@interface HLAnimationView (){
    //sw自身的宽度
    //sh自身的高度
    //itemW子控件的宽
    //itemH子控件的高
    
    CGFloat sw,sh,itemW,itemH;
}
@property (nonatomic,assign)NSInteger count;
//item的最大旋转角度
@property (nonatomic,assign)CGFloat maxAngle;
//item叠到一起时， item之间的空隙
@property (nonatomic,assign)CGFloat finalItemSpace;
@property (nonatomic,weak) WKWebView *abc;
@end

@implementation HLAnimationView

- (instancetype)initWithFrame:(CGRect)frame andImgNames:(NSArray*)imgNames
{
    self = [super initWithFrame:frame];
    if (self) {
        self.finalItemSpace = 0;
        self.maxAngle       = M_PI*4/9;
        self.count          = imgNames.count;
        
        
        CGFloat x,y,w,h;
        sw = frame.size.width;
        sh = frame.size.height;
        
        //在旋转过程中imgview的宽度是计算的平面宽度，会发生变化，所以记录下初始的宽度备用
        w = sw/(self.count-0.5),  h = w,  itemW = w,  itemH = h;
        for (int i = 0; i < self.count; i++) {
            
            x = w*i,  y=0;
            UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            //设置锚点 使view旋转时可以沿着左边旋转，否则是沿着垂直中线【|】旋转的
            itemBtn.layer.anchorPoint = CGPointMake(0, 0.5);

            itemBtn.frame = CGRectMake(x, y, w, h);
            itemBtn.layer.borderColor = [UIColor blackColor].CGColor;
            itemBtn.layer.borderWidth = 1;
            [itemBtn addTarget:self action:@selector(itemBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [itemBtn setImage:[UIImage imageNamed:imgNames[i]] forState:UIControlStateNormal];
            [self addSubview:itemBtn];
            
            itemBtn.tag    = 2300+i;
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
            label.text     = [NSString stringWithFormat:@"%ld",(long)i];
            label.backgroundColor = [UIColor grayColor];
            [itemBtn addSubview:label];
        }
    }
    return self;
}
/*
-(void)layoutSubviews{
    CGFloat x,y,w,h;
    sw = self.frame.size.width;
    sh = self.frame.size.height;
    
    //在旋转过程中imgview的宽度是计算的平面宽度，会发生变化，所以记录下初始的宽度备用
    w = sw/(self.count-0.5),  h = w,  itemW = w,  itemH = h;
    for (int i = 0; i < self.count; i++) {
        x = w*i,  y=0;
        UIButton *itemBtn = [self viewWithTag:2300+i];
        //设置锚点 使view旋转时可以沿着左边旋转，否则是沿着垂直中线【|】旋转的
        itemBtn.layer.anchorPoint = CGPointMake(0, 0.5);
        itemBtn.frame = CGRectMake(x, y, w, h);
    }

}
 */
-(void)update3DTransationWithOffsetX:(CGFloat)offsetX{
    
    if(offsetX<0){
        return;
    }
    if (offsetX<sw){

        CGFloat cha = offsetX;
        //旋转的总角度为M_PI/3
        //以下的cha/sw为比例系数
        CGFloat angle = cha/sw*self.maxAngle;
        for (int i = 0; i<self.count; i++) {
            UIButton *itemBtn = (UIButton*)[self viewWithTag:2300+i];
            CATransform3D transform = CATransform3DIdentity;
            //实现3D变换的立体效果 300可以看成眼睛距离手机屏幕的距离，一般设置为500-1000之间即可，根据需要自行调整
            transform.m34 = -1.0/300.0;
            CGFloat left  = cha/sw*i*(itemW-self.finalItemSpace);
            //计算每个item在旋转的同时需要向左移动的距离
            itemBtn.layer.position = CGPointMake(itemW*i-left, itemH/2.0);
            transform = CATransform3DRotate(transform, angle, 0, 1, 0);
            itemBtn.layer.transform = transform;

        }
        //随着滚动式图的移动而移动
        CGRect frame     = self.frame;
        frame.origin.x   = cha;
        frame.size.width = sw-cha;
        self.frame       = frame;
    }
    
}
-(void)itemBtnClicked:(UIButton*)btn{
    if (self.ItemClickedAtIndex!=nil) {
        self.ItemClickedAtIndex(btn.tag-2300);
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
