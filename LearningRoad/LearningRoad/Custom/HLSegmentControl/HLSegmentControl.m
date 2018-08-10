//
//  HLSegmentControl.m
//  CustomSegmentControl
//
//  Created by CH10 on 16/3/16.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "HLSegmentControl.h"

@interface HLSegmentControl ()
/**
 *标题
 */
@property (nonatomic,strong)NSMutableArray *items;
@end


@implementation HLSegmentControl
-(void)setDisplayRect:(BOOL)displayRect{
    _displayRect = displayRect;
    if (_displayRect) {
        self.layer.borderWidth = 1;
        for (int i = 0; i < _items.count; i ++ ) {
            UIView *view = (UIView *)[self viewWithTag:3500+i];
            view.hidden = NO;
        }
    }else{
        self.layer.borderWidth = 0.0;
        for (int i = 0; i < _items.count; i ++ ) {
            UIView *view = (UIView *)[self viewWithTag:3500+i];
            view.hidden = YES;
        }
    }
    
}
-(void)setRectColor:(UIColor *)rectColor{
    _rectColor = rectColor;
    self.layer.borderColor = _rectColor.CGColor;
    for (int i = 0; i < _items.count; i ++ ) {
        UIView *view = (UIView *)[self viewWithTag:3500+i];
        view.backgroundColor = _rectColor;
    }
    if (_displayRect) {
        [self setDisplayRect:YES];
    }
}
-(void)setSelectedItemColor:(UIColor *)selectedItemColor{
    _selectedItemColor = selectedItemColor;
    for (int i = 0;i < _items.count; i++) {
        UIButton *button = (UIButton *)[self viewWithTag:i+3000];
        [button setTitleColor:_selectedItemColor forState:UIControlStateSelected];
    }
    _sliderLine.backgroundColor = _selectedItemColor;
}
-(void)setSegmentTintColor:(UIColor *)segmentTintColor{
    _segmentTintColor = segmentTintColor;
    for (int i = 0;i < _items.count; i++) {
        UIButton *button = (UIButton *)[self viewWithTag:i+3000];
        [button setTitleColor:_segmentTintColor forState:UIControlStateNormal];
    }
}
-(void)setSelectedIndex:(NSInteger)selectedIndex{

    _selectedIndex = selectedIndex;
    for (int i = 0;i < _items.count; i++) {
        UIButton *button = (UIButton *)[self viewWithTag:i+3000];
        button.selected = NO;
    }
    UIButton *btn = (UIButton *)[self viewWithTag:selectedIndex+3000];
    btn.selected = YES;
    CGFloat bW = self.frame.size.width/_items.count;
    if (_startAnimation) {
        [UIView animateWithDuration:0.1 animations:^{
            _sliderLine.frame = CGRectMake(bW * selectedIndex+2, _sliderLine.frame.origin.y, _sliderLine.frame.size.width, _sliderLine.frame.size.height);
        }];
    }else{
        _sliderLine.frame = CGRectMake(bW * selectedIndex, _sliderLine.frame.origin.y, _sliderLine.frame.size.width, _sliderLine.frame.size.height);
    }
        
        

}
-(void)setItemFont:(UIFont *)itemFont{
    _itemFont = itemFont;
    for (int i = 0 ; i < _items.count; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:i+3000];
        btn.titleLabel.font = _itemFont;
    }
}
+ (instancetype)HLSegmentControlWithFrame:(CGRect)frame andItems:(NSArray *)items andItemFont:(UIFont *)itemFont{
    HLSegmentControl *control = [[HLSegmentControl alloc] initWithFrame:frame andItems:items andItemFont:itemFont];

    return control;
}
- (instancetype)initWithFrame:(CGRect)frame andItems:(NSArray *)items andItemFont:(UIFont *)itemFont
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupColorLayer];
        _items = [NSMutableArray arrayWithArray:items];
        _startAnimation = NO;
        _rectColor = [UIColor grayColor];
        CGFloat bW = frame.size.width/items.count;
        CGFloat bH = frame.size.height-3.5;
        for (int i = 0; i < items.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(bW*i, 0, bW, bH);
            [button setTitle:[items objectAtIndex:i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            button.titleLabel.font = itemFont;
            button.tag = 3000+i;
            [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            if(i<items.count-1){
                CGFloat bR = button.frame.origin.x+button.frame.size.width;
                UIView *vLine = [[UIView alloc] initWithFrame:CGRectMake(bR-1, 2, 1, bH-2)];
                vLine.backgroundColor = [UIColor grayColor];
                vLine.tag = 3500+i;
                [self addSubview:vLine];
            }
        }
        UIView *tSliderView = [[UIView alloc] initWithFrame:CGRectMake(2, bH, bW-5, 2)];
        tSliderView.backgroundColor = [UIColor redColor];
        [self addSubview:tSliderView];
        _sliderLine = tSliderView;
    }
    return self;
}
- (void)setupColorLayer {
    //渐变图层
    CALayer * grain = [CALayer layer];
    //        我们是两种渐变色，所以我么要用一个grain 对象将两个渐变图层放到一起，
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    
    gradientLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    
    [gradientLayer setColors:[NSArray arrayWithObjects:(id)[[UIColor purpleColor] CGColor],(id)[[self rgb:193 g:44 b:113 a:1] CGColor], nil]];
    
    [gradientLayer setLocations:@[@0.1,@0.9]];
    
    [gradientLayer setStartPoint:CGPointMake(0.5, 0)];
    
    [gradientLayer setEndPoint:CGPointMake(0.5, 1)];
    [grain addSublayer:gradientLayer];
//    [self.layer addSublayer:grain];
}

-(void)btnClick:(UIButton *)btn{
    self.selectedIndex = btn.tag - 3000;
    [self.delegate segmentControlDidSelectedIndex:_selectedIndex];
}
-(UIColor*)rgb:(NSInteger)r g:(NSInteger)g b:(NSInteger)b a:(CGFloat)alpha{
    return [UIColor colorWithRed:r%256/256.0 green:g%256/256.0 blue:b%256/256.0 alpha:alpha];
}

@end
