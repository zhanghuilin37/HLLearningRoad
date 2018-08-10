//
//  HLSegmentControlExtention.m
//  LearningRoad
//
//  Created by Zhl on 2017/6/2.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import "HLSegmentControlExtention.h"
@interface HLSegmentControlExtention ()<UIScrollViewDelegate,HLSegmentControlDelegate>{
    UIView *_leftV;
    UIView *_rightV;
}
@property (nonatomic,weak)UIScrollView *bgScrollView;
@property (nonatomic,assign) CGFloat itemWidth;
@end
@implementation HLSegmentControlExtention
- (instancetype)initWithFrame:(CGRect)frame itemArr:(NSArray*)itemArr
{
    self = [super initWithFrame:frame];
    if (self) {
        UIScrollView *bgScrollView= [[UIScrollView alloc] initWithFrame:ccr(0, 0, SCREEN_WIDTH, self.height)];
        bgScrollView.delegate = self;
        bgScrollView.bounces  = NO;
        bgScrollView.showsHorizontalScrollIndicator = NO;
        _bgScrollView = bgScrollView;
        [self addSubview:bgScrollView];
        NSInteger count = itemArr.count>0?itemArr.count:4;
        CGFloat itemWidth = SCREEN_WIDTH/4.0;
        if (count <= 4) {
            itemWidth = SCREEN_WIDTH/count;
        }else{
            itemWidth = SCREEN_WIDTH/4.5;
        }
        self.itemWidth = itemWidth;
        CGFloat x,y,w,h;
        x = 0;  y = 0;  w = itemWidth*count;   h = self.height;
        bgScrollView.contentSize = CGSizeMake(w, 0);
        HLSegmentControl *segmentControl = [[HLSegmentControl alloc] initWithFrame:ccr(x, y, w, h) andItems:itemArr andItemFont:[UIFont systemFontOfSize:12]];
        segmentControl.displayRect = NO;
        segmentControl.rectColor = [UIColor clearColor];
        segmentControl.selectedItemColor = [LRTools hl_colorWithHexString:@"278dff"];
        segmentControl.segmentTintColor = [LRTools hl_colorWithHexString:@"434343"];
        segmentControl.delegate = self;
        segmentControl.selectedIndex = 0;
        bgScrollView.backgroundColor = [UIColor whiteColor];
        _segmentControl = segmentControl;
        [bgScrollView addSubview:segmentControl];
        
        x=-40;y=0;w=40;h=self.height;
        _leftV = [[UIView alloc] initWithFrame:ccr(x, y, w,h)];
        _leftV.backgroundColor = [UIColor whiteColor];
        _leftV.alpha = 0.5;
        _leftV.layer.shadowColor = [UIColor blackColor].CGColor;
        _leftV.layer.shadowOffset = CGSizeMake(10,0);
        _leftV.layer.shadowOpacity = 0.5;
        _leftV.hidden = YES;
        [self addSubview:_leftV];
        
        x=self.width;y=0;w=40;h=self.height;
        _rightV = [[UIView alloc] initWithFrame:ccr(x, y, w,h)];
        _rightV.backgroundColor = [UIColor whiteColor];
        _rightV.layer.shadowColor = [UIColor blackColor].CGColor;
        _rightV.layer.shadowOffset = CGSizeMake(-10, 0);
        _rightV.layer.shadowOpacity = 0.5;
        _rightV.alpha = 0.5;
        _rightV.hidden = YES;
        [self addSubview:_rightV];
        if (self.bgScrollView.contentSize.width-(self.bgScrollView.contentOffset.x+self.bgScrollView.width)<0.5) {
            _rightV.hidden = YES;
        }else{
            _rightV.hidden = NO;
        }
        
        x=0;y=frame.size.height-0.5;w=frame.size.width;h=0.5;
        UIView *downLine = [[UIView alloc] initWithFrame:ccr(x, y, w, h)];
        downLine.backgroundColor = [UIColor grayColor];
        [self addSubview:downLine];
    }
    return self;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.bgScrollView.contentOffset.x>0) {
        _leftV.hidden = NO;
    }else{
        _leftV.hidden = YES;
    }
    
    CGFloat flag = self.bgScrollView.contentSize.width-(self.bgScrollView.contentOffset.x+self.bgScrollView.width);
//    NSLog(@"flag ======= %f",flag);
    if (flag<0.5) {
        _rightV.hidden = YES;
    }else{
        _rightV.hidden = NO;
    }
}
#pragma mark - CTSegmentControlDelegate
-(void)segmentControlDidSelectedIndex:(NSInteger)index{
    if ([self.delegate respondsToSelector:@selector(hlSegmentControlExtention:ClickedAtIndex:)]) {
        [self.delegate hlSegmentControlExtention:self ClickedAtIndex:index];
    }
}

@end
