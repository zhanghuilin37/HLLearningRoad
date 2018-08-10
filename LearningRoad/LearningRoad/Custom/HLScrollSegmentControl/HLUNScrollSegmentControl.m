//
//  HLUNScrollSegmentControl.m
//  LearningRoad
//
//  Created by Zhl on 2017/7/25.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import "HLUNScrollSegmentControl.h"
static const NSInteger KBtnBaseTag      = 3400;
static const NSInteger KRedBadgeBaseTag = 3500;
static const CGFloat   KLeftEdge        = 15.0f;
static const CGFloat   KRightEdge       = 15.0f;
static const CGFloat   KSliderHeight    = 3.0f;
@interface HLUNScrollSegmentControl ()<UIScrollViewDelegate>

@property (nonatomic,weak) UIView   *sliderView;
@property (nonatomic,weak) UIButton *selectedBtn;
@property (nonatomic,weak) UIScrollView *bgScrollView;

@property (nonatomic,assign) NSInteger itemCount;
@property (nonatomic,assign) CGFloat   spaceWidth;
@property (nonatomic,assign) CGFloat sliderWidth;

@property (nonatomic,strong) UIFont *textFont;
@property (nonatomic,strong) UIFont *largeFont;
@property (nonatomic,strong) NSMutableArray *items;
@end
@implementation HLUNScrollSegmentControl
-(void)showRoundBadgeAtIndex:(NSInteger)index{
    
}

-(instancetype)initWithFrame:(CGRect)frame Items:(NSArray<NSString*> *)items TextFont:(UIFont*)textFont  AndDelegate:(id<HLUNScrollSegmentControlDelegate>)delegate{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.textFont = textFont;
        self.largeFont = [UIFont systemFontOfSize:textFont.pointSize+3];
        self.itemCount = items.count;
        
        self.delegate = delegate;
        self.items = [items mutableCopy];
        
        NSString *fullStr = [items componentsJoinedByString:@""];
        CGFloat strW = [self getFontSizeWithString:fullStr font:self.largeFont constrainSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)].width;
        self.spaceWidth = (self.frame.size.width-strW-KLeftEdge-KRightEdge)/(items.count-1);
        if (self.spaceWidth<0) {
            self.spaceWidth = 0;
        }
        
        [self initSubViews];
        
        self.showSlider = YES;
        self.moveAnimation = YES;
        self.selectedIndex = 0;
        

    }
    return self;
}
-(void)initSubViews{

    //滚动视图
    UIScrollView *bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    bgScrollView.delegate = self;
    bgScrollView.showsHorizontalScrollIndicator = NO;
    bgScrollView.scrollEnabled = NO;
    bgScrollView.contentSize = CGSizeMake(self.frame.size.width, 0);
    self.bgScrollView = bgScrollView;
    [self addSubview:bgScrollView];
    self.sliderWidth = self.frame.size.width/_itemCount;
    //底部滑块
    UIView *sliderView = [[UIView alloc] initWithFrame:ccr(0, self.bgScrollView.frame.size.height-KSliderHeight, self.sliderWidth, KSliderHeight)];
    sliderView.backgroundColor = [UIColor redColor];
    self.sliderView = sliderView;
    [bgScrollView addSubview:self.sliderView];
    
    //按钮
    CGFloat x,y,w,h;
    x = KLeftEdge,  y = 0,  w = 0,   h = bgScrollView.frame.size.height;
    
    for (int i = 0; i<self.itemCount; i++) {
        
        NSString *title = [self.items objectAtIndex:i];
        CGSize titleSize = [self getFontSizeWithString:title font:self.largeFont constrainSize:CGSizeMake(CGFLOAT_MAX, h)];
        w = titleSize.width;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(x, y, w, h);
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = KBtnBaseTag+i;
        [bgScrollView addSubview:btn];
        btn.titleLabel.font = _textFont;
        
        
        UIView *redBadge = [[UIView alloc] initWithFrame:CGRectMake(x+w, (self.frame.size.height-self.textFont.pointSize)/2-5, 10, 10)];
        redBadge.backgroundColor = [UIColor redColor];
        redBadge.layer.cornerRadius = redBadge.frame.size.height/2.0;
        redBadge.layer.masksToBounds = YES;
        redBadge.tag = KRedBadgeBaseTag+i;
        [bgScrollView addSubview:redBadge];
        x+=(w+self.spaceWidth);
    }
    
}

-(void)setShowSlider:(BOOL)showSlider{
    _showSlider = showSlider;
    self.sliderView.hidden = !_showSlider;
}
-(void)btnClick:(UIButton*)btn{
    self.selectedIndex = btn.tag - KBtnBaseTag;
}
-(void)setSelectedIndex:(NSInteger)selectedIndex{
    
    
    if (_selectedIndex!=selectedIndex) {
        _selectedIndex = selectedIndex;
        UIButton *btn = [self.bgScrollView viewWithTag:KBtnBaseTag+_selectedIndex];
        //改变选中状态
        self.selectedBtn.selected = NO;
        btn.selected = YES;
        
        if (_moveAnimation) {
            
            [UIView animateWithDuration:0.2 animations:^{
                
                //改变大小
                btn.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
                self.selectedBtn.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                
                //改变底部滑块的位置
                CGPoint center = self.sliderView.center;
                center.x = btn.center.x;
                self.sliderView.center = center;
                
            }];
            self.selectedBtn = btn;
            
            //改变偏移量
            CGFloat offsetX = [self getOffsetXWithBtn:btn];
            [self.bgScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
            
            
        }else{
            
            //改变大小
            btn.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
            self.selectedBtn.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
            
            //改变底部滑块的位置
            CGPoint center = self.sliderView.center;
            center.x = btn.center.x;
            self.sliderView.center = center;
            
            self.selectedBtn = btn;
            //改变偏移量
            CGFloat offsetX = [self getOffsetXWithBtn:btn];
            [self.bgScrollView setContentOffset:CGPointMake(offsetX, 0) animated:NO];
        }
    }else{//初始化
        _selectedIndex = selectedIndex;
        UIButton *btn = [self.bgScrollView viewWithTag:KBtnBaseTag+_selectedIndex];
        self.selectedBtn = btn;
        btn.selected = YES;
        btn.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
        CGPoint center = self.sliderView.center;
        center.x = btn.center.x;
        self.sliderView.center = center;
    }
    if ([self.delegate respondsToSelector:@selector(hlScrollSegmentControl:SelectedIndex:)]) {
        [self.delegate hlScrollSegmentControl:self
                                SelectedIndex:_selectedIndex];
    }
}

-(CGSize)getFontSizeWithString:(NSString *)words font:(UIFont *)font constrainSize:(CGSize)cSize
{
    CGSize size = CGSizeMake(0, 0);
    if (words != nil) {
        size = [words boundingRectWithSize:CGSizeMake(cSize.width, cSize.height) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
    }
    
    return size;
    
}

-(CGFloat)getOffsetXWithBtn:(UIButton*)btn{
    CGFloat offsetX = btn.center.x - self.bgScrollView.frame.size.width/2.0;
    if (offsetX<=self.bgScrollView.contentSize.width-self.bgScrollView.frame.size.width  &&  offsetX>0) {
        offsetX = offsetX;
    }else{
        if (offsetX>0) {
            offsetX = self.bgScrollView.contentSize.width-self.bgScrollView.frame.size.width;
        }else{
            offsetX = 0;
        }
    }
    return offsetX;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
