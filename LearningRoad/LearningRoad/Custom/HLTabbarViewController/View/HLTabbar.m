//
//  HLTabbar.m
//  HLTabbarDemo
//
//  Created by Zhl on 2017/3/3.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import "HLTabbar.h"

#define HLTabbarItemTag   32200
#define HLTabbarBadgeTag  32400

@implementation HLTabbar
CGFloat x,y,w,h,sw,sh,s;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.selItemAnimation = YES;
        self.tintColor   = [UIColor grayColor];
        self.selectedItemColor = [UIColor redColor];
        self.sourceArr   = [[NSArray alloc] init];
        [self addSubview:self.backgroundImgV];
//        [self addSubview:self.shadowImgV];
        
    }
    return self;
}
#pragma mark - public Methods

+(HLTabbar*)createHLTabbarWithFrame:(CGRect)frame andArr:(NSArray<HLTabbarItemModel*>*)arr;{
    sw = [UIScreen mainScreen].bounds.size.width;   sh = 49;  x = 0;  y = 0;
    HLTabbar *tabbar = [[HLTabbar alloc] initWithFrame:CGRectMake(x, y, sw, sh)];
    tabbar.sourceArr = arr;
    return tabbar;
}

-(void)showBadgeAtIndex:(NSInteger)index{
    
    HLTabbarButton *itemView = (HLTabbarButton*)[self viewWithTag:HLTabbarItemTag+index];
    itemView.badgeView.hidden  = NO;
}
-(void)hiddeBadgeAtIndex:(NSInteger)index{
    HLTabbarButton *itemView = (HLTabbarButton*)[self viewWithTag:HLTabbarItemTag+index];
    itemView.badgeView.hidden  = YES;
}
#pragma mark - actions
-(void)btnClicked:(HLTabbarButton*)btn{
    self.selBtn.selected = NO;

    btn.selected = YES;
    btn.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5);
    if (self.selItemAnimation) {
        [UIView animateWithDuration:0.2 animations:^{
            btn.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
        }];
    }
    self.selBtn = btn;
    
    self.selectedIndex = btn.tag - HLTabbarItemTag;
}
#pragma mark - getter Methods
-(UIImageView *)backgroundImgV{
    if (_backgroundImgV == nil) {
        _backgroundImgV = [[UIImageView alloc] initWithFrame:self.bounds];
    }
    return _backgroundImgV;
}
-(UIImageView *)shadowImgV{
    if (_shadowImgV == nil) {
        _shadowImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
//        _shadowImgV.backgroundColor = [UIColor grayColor];
    }
    return _shadowImgV;
}
#pragma mark - setter Methods
-(void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    self.selBtn.selected = NO;
    HLTabbarButton *btn  = (HLTabbarButton*)[self viewWithTag:HLTabbarItemTag+selectedIndex];
    btn.selected = YES;
    btn.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.7, 0.7);
    if (self.selItemAnimation) {
        [UIView animateWithDuration:0.1 animations:^{
            btn.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
        }];
    }
    self.selBtn = btn;
    if (self.tabbarClickedAtIndex!=nil) {
        self.tabbarClickedAtIndex(_selectedIndex);
    }
}
-(void)setSelectedItemColor:(UIColor *)selectedItemColor{
    _selectedItemColor = selectedItemColor;
    for (int i = 0; i<self.sourceArr.count; i++) {
        HLTabbarButton *btn  = (HLTabbarButton*)[self viewWithTag:HLTabbarItemTag+i];
        [btn setTitleColor:self.tintColor forState:UIControlStateNormal];
        if (i == self.selectedIndex) {
            [btn setTitleColor:self.selectedItemColor forState:UIControlStateSelected];
            
        }
    }
}
-(void)setTintColor:(UIColor *)tintColor{
    _tintColor = tintColor;
    for (int i = 0; i<self.sourceArr.count; i++) {
        HLTabbarButton *btn  = (HLTabbarButton*)[self viewWithTag:HLTabbarItemTag+i];
        [btn setTitleColor:self.tintColor forState:UIControlStateNormal];
        if (i == self.selectedIndex) {
            [btn setTitleColor:self.selectedItemColor forState:UIControlStateSelected];
            
        }
    }
}
-(void)setSourceArr:(NSArray *)sourceArr{
    _sourceArr = [NSMutableArray arrayWithArray:sourceArr];
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[HLTabbarButton class]]) {
            [subView removeFromSuperview];
        }
    }
    for (int i = 0; i<self.sourceArr.count; i++) {
        
        HLTabbarItemModel *model  = [_sourceArr objectAtIndex:i];

        w = sw/_sourceArr.count,h=sh,x=w*i,y=0;
        HLTabbarButton *btn = [HLTabbarButton createTabbarButtonWithFrame:CGRectMake(x, y, w, h) Model:model];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = HLTabbarItemTag+i;
        [self addSubview:btn];
        if (i == 0) {
            self.selBtn = btn;
            btn.selected = YES;
        }
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
