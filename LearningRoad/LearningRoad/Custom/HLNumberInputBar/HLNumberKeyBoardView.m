//
//  HLNumberKeyBoardView.m
//  HLCalculator
//
//  Created by 张会林 on 2017/10/20.
//  Copyright © 2017年 张会林. All rights reserved.
//

#import "HLNumberKeyBoardView.h"
#import "HLNumberTextViewConst.h"
#import "AppDelegate.h"

@interface HLNumberKeyBoardView()
@property (nonatomic,strong)    UIControl   *spaceControl;
@property (nonatomic,weak)      UIView      *specialkeyView;
@property (nonatomic,weak)      UIView      *mainKeyView;
@property (nonatomic,weak)      UIButton    *deleteBtn;
@property (nonatomic,weak)      UIButton    *confirmBtn;
@end

@implementation HLNumberKeyBoardView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //特殊键（000属于主键只是由于页面布局原因放到了这里）
        NSArray *specialKeyTitles = @[@"100",@"500",@"1000",@"000"];
        CGFloat x = 0,y=0,w=KeyBoardItemWidth,h=NumberKeyBoardViewHeight;
        UIView *specialKeyView = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        specialKeyView.backgroundColor = [self colorWithHexString:KeyBoardSpecialKeyColor];
        self.specialkeyView = specialKeyView;
        [self addSubview:specialKeyView];
        
        for (int i = 0; i<4; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:[specialKeyTitles objectAtIndex:i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            if (i==3) {
                btn.frame = CGRectMake(0, i*KeyBoardItemHeight, KeyBoardItemWidth, KeyBoardItemHeight+k_X_HomeSafeArea_H);
                [btn addTarget:self action:@selector(mainKeyClick:) forControlEvents:UIControlEventTouchUpInside];
            }else{
                btn.frame = CGRectMake(0, i*KeyBoardItemHeight, KeyBoardItemWidth, KeyBoardItemHeight);
                [btn addTarget:self action:@selector(specialKeyClicked:) forControlEvents:UIControlEventTouchUpInside];
            }
            [_specialkeyView addSubview:btn];
        }
        
        //主键
        NSArray *mainKeyTitles = @[@"7",@"8",@"9",
                                   @"4",@"5",@"6",
                                   @"1",@"2",@"3",
                                   @"00",@"0"];
        x = KeyBoardItemWidth;
        y = 0;
        w = KeyBoardItemWidth*3;
        h = NumberKeyBoardViewHeight;
        UIView *mainKeyView = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        mainKeyView.backgroundColor = [self colorWithHexString:KeyBoardMainkeyColor];
        self.mainKeyView = mainKeyView;
        [self addSubview:_mainKeyView];
        for (int i = 0; i<mainKeyTitles.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitle:[mainKeyTitles objectAtIndex:i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(mainKeyClick:) forControlEvents:UIControlEventTouchUpInside];
            [_mainKeyView addSubview:btn];
            if (i<10) {
                
                if (i==9) {//00
                    btn.frame = CGRectMake(KeyBoardItemWidth*(i%3), KeyBoardItemHeight*(i/3), KeyBoardItemWidth, KeyBoardItemHeight+k_X_HomeSafeArea_H);
                }else{//1-9
                    btn.frame = CGRectMake(KeyBoardItemWidth*(i%3), KeyBoardItemHeight*(i/3), KeyBoardItemWidth, KeyBoardItemHeight);
                }
            }else{//0
                btn.frame = CGRectMake(KeyBoardItemWidth*(i%3), KeyBoardItemHeight*(i/3), KeyBoardItemWidth*2, KeyBoardItemHeight+k_X_HomeSafeArea_H);
            }
            
        }
        //删除按钮
        x = KeyBoardItemWidth*4;
        y = 0;
        w = KeyBoardItemWidth;
        h = KeyBoardItemHeight;
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteBtn.backgroundColor = [self colorWithHexString:KeyBoardDeleteKeyColor];
        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        deleteBtn.frame = CGRectMake(x, y, w, h);
        [deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
        self.deleteBtn = deleteBtn;
        [self addSubview:_deleteBtn];
        
        //确定按钮
        x = KeyBoardItemWidth*4;
        y = KeyBoardItemHeight;
        w = KeyBoardItemWidth;
        h = KeyBoardItemHeight*3+k_X_HomeSafeArea_H;
        UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        confirmBtn.backgroundColor = [self colorWithHexString:KeyBoardConfirmKeyColor];
        [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        confirmBtn.frame = CGRectMake(x, y, w, h);
        [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:confirmBtn];
        //横线
        y=0;
        for (int i = 0; i<4; i++) {
            x = 0;h = KeyBoardSeparatorLineWidth;
            w=(i==0?self.frame.size.width:KeyBoardItemWidth*4);
            UIView *hLine = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
            hLine.backgroundColor = [self colorWithHexString:KeyBoardSeparateLineColor];
            [self addSubview:hLine];
            y+=KeyBoardItemHeight;
            
        }
        //竖线
        x=KeyBoardItemWidth;
        for (int i = 0; i<3; i++) {
            w=KeyBoardSeparatorLineWidth;h=(i==2?KeyBoardItemHeight*3:self.frame.size.height);y=0;
            UIView *vLine = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
            vLine.backgroundColor = [self colorWithHexString:KeyBoardSeparateLineColor];
            [self addSubview:vLine];
            x+=KeyBoardItemWidth;
        }
    }
    return self;
}




#pragma mark - Actions
//数字键被点击（主键）（0-9、00、000）
- (void)mainKeyClick:(UIButton*)btn {
    if (self.numberKeyBoardViewSelectedMainNumber) {
        self.numberKeyBoardViewSelectedMainNumber(btn.titleLabel.text);
    }
}

//特殊数字键被点击（100、500、1000）
- (void)specialKeyClicked:(UIButton*)btn {
    if (self.numberKeyBoardViewSelectedSpecialNumber) {
        self.numberKeyBoardViewSelectedSpecialNumber(btn.titleLabel.text);
    }
}

//删除键被点击
- (void)deleteBtnClick {
    if (self.numberKeyBoardViewDeleteBtnClick) {
        self.numberKeyBoardViewDeleteBtnClick();
    }
}

//确定键被点击
- (void)confirmBtnClick {
    [self hideNumberKeyBoardDuration:0.25];
    if (self.numberKeyBoardViewConfirmBtnClick) {
        self.numberKeyBoardViewConfirmBtnClick();
    }
}

//点击空白处收回键盘
- (void)spaceControlClick {
    [self hideNumberKeyBoardDuration:keyBoardFloadAnimationDuration];
}



#pragma mark - Public Methods
//隐藏键盘
- (void)hideNumberKeyBoardDuration:(CGFloat)duration {
    
    [UIView animateWithDuration:duration animations:^{
        self.frame = CGRectMake(0, kdeviceHeight, kdeviceWidth, NumberKeyBoardViewHeight);
        self.spaceControl.frame = CGRectMake(0, k_NavBar_H, kdeviceWidth, kdeviceHeight-k_NavBar_H);
    }completion:^(BOOL finished) {
        [self.spaceControl removeFromSuperview];
        [self removeFromSuperview];
        self.hidden = YES;
    }];
}

//弹出键盘
- (void)showNumberKeyBoardDuration:(CGFloat)duration {
    self.hidden = NO;
    
    UIWindow *window = ((AppDelegate*)[UIApplication sharedApplication].delegate).window;
    
    UIView *view = [window viewWithTag:KeyBoardSpaceControlTag];
    if (view&&[view isKindOfClass:[UIControl class]]) {
        
    }else{
        [window addSubview:self.spaceControl];
        [window addSubview:self];
    }
    
    [UIView animateWithDuration:duration animations:^{
        self.frame = CGRectMake(0, kdeviceHeight-NumberKeyBoardViewHeight, kdeviceWidth, NumberKeyBoardViewHeight);
        self.spaceControl.frame = CGRectMake(0, k_NavBar_H, kdeviceWidth, kdeviceHeight-NumberKeyBoardViewHeight-k_NavBar_H);
    }completion:^(BOOL finished) {
        
    }];
}



#pragma mark - Getter Methods
//空白处control
-(UIControl *)spaceControl {
    if (_spaceControl == nil) {
        _spaceControl = [[UIControl alloc] initWithFrame:CGRectMake(0, k_NavBar_H, kdeviceWidth, kdeviceHeight-k_NavBar_H)];
        _spaceControl.tag = 2100;
        _spaceControl.backgroundColor = [UIColor clearColor];
        [_spaceControl addTarget:self action:@selector(spaceControlClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _spaceControl;
}

- (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *noHashString = [stringToConvert stringByReplacingOccurrencesOfString:@"#" withString:@""]; // remove the #
    NSScanner *scanner = [NSScanner scannerWithString:noHashString];
    [scanner setCharactersToBeSkipped:[NSCharacterSet symbolCharacterSet]]; // remove + and $
    
    unsigned hex;
    if (![scanner scanHexInt:&hex]) return nil;
    NSInteger r = (hex >> 16) & 0xFF;
    NSInteger g = (hex >> 8) & 0xFF;
    NSInteger b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f];
}
@end




















