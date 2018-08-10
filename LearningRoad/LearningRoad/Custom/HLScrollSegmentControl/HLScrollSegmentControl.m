//
//  HLScrollSegmentControl.m
//  demo3
//
//  Created by Zhl on 2017/7/5.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import "HLScrollSegmentControl.h"
static const NSInteger KBtnBaseTag      = 3400;
static const NSInteger KRedBadgeBaseTag = 3500;
static const CGFloat   KLeftEdge        = 15.0f;
static const CGFloat   KRightEdge       = 15.0f;
static const CGFloat   KSliderHeight    = 3.0f;
@interface HLScrollSegmentControl ()<UIScrollViewDelegate>{
    UIView *_leftIndicator;
    UIView *_rightIndicator;
}

@property (nonatomic,weak) UIView   *sliderView;
@property (nonatomic,weak) UIButton *selectedBtn;
@property (nonatomic,weak) UIScrollView *bgScrollView;

@property (nonatomic,assign) NSInteger itemCount;
@property (nonatomic,assign) CGFloat   spaceWidth;

@property (nonatomic,strong) UIFont *textFont;
@property (nonatomic,strong) UIFont *largeFont;
@property (nonatomic,strong) NSMutableArray *items;
@end

@implementation HLScrollSegmentControl
-(void)showRoundBadgeAtIndex:(NSInteger)index{
    UIView *badage = [self viewWithTag:KRedBadgeBaseTag + index];
    badage.hidden = NO;
}
- (void)hideRoundBadageAtIndex:(NSInteger)index {
    UIView *badage = [self viewWithTag:KRedBadgeBaseTag + index];
    badage.hidden = YES;
}
-(instancetype)initWithFrame:(CGRect)frame Items:(NSArray<NSString *> *)items TextFont:(UIFont*)textFont SpaceWidth:(CGFloat)spaceWidth AndDelegate:(id<HLScrollSegmentControlDelegate>)delegate{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.textFont = textFont;
        self.largeFont = [UIFont systemFontOfSize:textFont.pointSize+3];
        self.itemCount = items.count;
        
        self.delegate = delegate;
        self.items = [items mutableCopy];
        self.spaceWidth = spaceWidth;
        self.sliderWidth = self.frame.size.width/4.5;

        [self initSubViews];
        
        self.showSlider = YES;
        self.showIndicator = YES;
        self.moveAnimation = YES;
        
        if ([self.delegate respondsToSelector:@selector(setBasicPropertyOfBtnItem:)]) {
            for (int i = 0; i<self.itemCount; i++) {
                UIButton *btn = [self.bgScrollView viewWithTag:i+KBtnBaseTag];
                [self.delegate setBasicPropertyOfBtnItem:btn];
            }
        }
        
        self.selectedIndex = 0;
        
        //
        if ([self.delegate respondsToSelector:@selector(setBasicPropertyOfHLScrollSegmentControl:)]) {
            [self.delegate setBasicPropertyOfHLScrollSegmentControl:self];
        }
        //设置左右指示器的基本属性
        if ([self.delegate respondsToSelector:@selector(setBasicPropertyOfLeftIndicator:RightIndicator:)]) {
            [self.delegate setBasicPropertyOfLeftIndicator:_leftIndicator RightIndicator:_rightIndicator];
        }
        //设置底部滑块的基本属性
        if ([self.delegate respondsToSelector:@selector(setBasicPropertyOfBottomSlider:)]) {
            [self.delegate setBasicPropertyOfBottomSlider:self.sliderView];
        }
    }
    return self;
}
-(void)initSubViews{
    //滚动视图
    UIScrollView *bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    bgScrollView.delegate = self;
    bgScrollView.showsHorizontalScrollIndicator = NO;
    self.bgScrollView = bgScrollView;
    [self addSubview:bgScrollView];
    
    //底部滑块
    UIView *sliderView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-KSliderHeight, self.sliderWidth, KSliderHeight)];
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
        if (self.itemCount<=4) {
            w=(self.frame.size.width-KLeftEdge-KRightEdge-(self.itemCount-1)*self.spaceWidth)/self.itemCount;
        }
        
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
        
        
        UIView *redBadge = [[UIView alloc] initWithFrame:CGRectMake(x+w, (self.frame.size.height-self.textFont.pointSize)/2-2.5, 5, 5)];
        redBadge.backgroundColor = [UIColor redColor];
        redBadge.layer.cornerRadius = redBadge.frame.size.height/2.0;
        redBadge.layer.masksToBounds = YES;
        redBadge.tag = KRedBadgeBaseTag+i;
        redBadge.hidden = YES;
        [bgScrollView addSubview:redBadge];
        x+=(w+self.spaceWidth);
    }
    self.bgScrollView.contentSize = CGSizeMake(x+KRightEdge-self.spaceWidth, 0);
    
    //左右指示块
    x=-60,y=-15,w=60,h=self.frame.size.height+30;
    _leftIndicator = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    _leftIndicator.backgroundColor = [UIColor whiteColor];
    _leftIndicator.layer.shadowOffset = CGSizeMake(20, 0);
    _leftIndicator.layer.shadowOpacity = 0.85;
    _leftIndicator.layer.shadowColor = [UIColor whiteColor].CGColor;
    
    x=self.frame.size.width,y=-15,w=60,h=self.frame.size.height+30;
    _rightIndicator = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    _rightIndicator.backgroundColor = [UIColor whiteColor];
    _rightIndicator.layer.shadowOffset = CGSizeMake(-20, 0);
    _rightIndicator.layer.shadowOpacity = 0.85;
    _rightIndicator.layer.shadowColor = [UIColor whiteColor].CGColor;
    
    [self addSubview:_leftIndicator];
    [self addSubview:_rightIndicator];
    
}
-(void)setShowIndicator:(BOOL)showIndicator{
    _showIndicator = showIndicator;
    [self judgeShowIndicator];
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
//                self.sliderView.frame = CGRectMake(btn.frame.origin.x, self.sliderView.frame.origin.y, btn.frame.size.width, KSliderHeight);
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
//            self.sliderView.frame = CGRectMake(btn.frame.origin.x, self.sliderView.frame.origin.y, btn.frame.size.width, KSliderHeight);
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
//        self.sliderView.frame = CGRectMake(btn.frame.origin.x, self.bgScrollView.frame.size.height-KSliderHeight, btn.frame.size.width, KSliderHeight);
        CGPoint center = self.sliderView.center;
        center.x = btn.center.x;
        self.sliderView.center = center;
        CGFloat offsetX = [self getOffsetXWithBtn:btn];
        [self.bgScrollView setContentOffset:CGPointMake(offsetX, 0) animated:NO];
    }

    if ([self.delegate respondsToSelector:@selector(hlScrollSegmentControl:SelectedIndex:)]) {
        [self.delegate hlScrollSegmentControl:self SelectedIndex:_selectedIndex];
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
-(void)judgeShowIndicator{
    if (_showIndicator) {
        if (self.bgScrollView.contentOffset.x<=0) {
            _leftIndicator.hidden = YES;
        }else{
            _leftIndicator.hidden = NO;
        }
        BOOL showRight = fabs(self.bgScrollView.contentOffset.x+self.bgScrollView.frame.size.width-self.bgScrollView.contentSize.width) >= 1.0f;
        _rightIndicator.hidden = !showRight;
        
    }else{
        _leftIndicator.hidden = YES;
        _rightIndicator.hidden = YES;
    }
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
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self judgeShowIndicator];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
