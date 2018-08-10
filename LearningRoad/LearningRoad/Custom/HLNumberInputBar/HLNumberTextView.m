//
//  HLNumberTextView.m
//  HLCalculator
//
//  Created by 张会林 on 2017/10/24.
//  Copyright © 2017年 张会林. All rights reserved.
//

#import "HLNumberTextView.h"

@interface HLNumberTextView()
@property (nonatomic,weak)     UILabel    *textLabel;
@property (nonatomic,weak)     UIControl  *editSwidchControl;//用于弹出键盘
@property (nonatomic,strong)   HLNumberKeyBoardView *numberKeyboard;//键盘view
@end

@implementation HLNumberTextView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        textLabel.textColor = [UIColor blackColor];
        textLabel.textAlignment = NSTextAlignmentLeft;
        textLabel.adjustsFontSizeToFitWidth = YES;
        textLabel.text = NumberToolViewPlaceHolder;
        if ([self.delegate respondsToSelector:@selector(hlNumberTextViewTextDidChange:)]) {
            [self.delegate hlNumberTextViewTextDidChange:textLabel.text];
        }
        textLabel.backgroundColor = [UIColor whiteColor];
        self.textLabel = textLabel;
        [self addSubview:_textLabel];
        
        UIControl *editSwidchControl = [[UIControl alloc] initWithFrame:_textLabel.frame];
        [editSwidchControl addTarget:self action:@selector(editSwidchControlClick) forControlEvents:UIControlEventTouchUpInside];
        editSwidchControl.backgroundColor = [UIColor clearColor];
        self.editSwidchControl = editSwidchControl;
        [self addSubview:_editSwidchControl];
        
    }
    return self;
}
- (void)hideNumberKeyBoard {
    [self.numberKeyboard hideNumberKeyBoardDuration:keyBoardFloadAnimationDuration];
}
- (void)showNumberKeyBoard {
    [self.numberKeyboard showNumberKeyBoardDuration:keyBoardFloadAnimationDuration];
}

#pragma mark - Actions
//开始编辑弹出键盘
- (void)editSwidchControlClick {
    [self.numberKeyboard showNumberKeyBoardDuration:0.25];
}
//主数字键被点击
- (void)numberKeyBoardViewSelectedMainKeyNumber:(NSString*)numberStr {
    NSLog(@"numberKeyBoardViewSelectedMainNumber:%@",numberStr);
    if ([self.text isEqualToString:NumberToolViewPlaceHolder]) {
        self.text = numberStr;
    }else{
        self.text = [NSString stringWithFormat:@"%@%@",self.text,numberStr];
    }
}
//特殊数字键被点击
- (void)numberKeyBoardViewSelectedSpecialKeyNumber:(NSString*)numberStr {
    NSLog(@"numberKeyBoardViewSelectedSpecialNumber:%@",numberStr);
    self.text = numberStr;
    
}
//确定被点击
- (void)numberKeyBoardViewConfirmBtnClick {
    NSLog(@"numberKeyBoardViewConfirmBtnClick");
}
//删除被点击
- (void)numberKeyBoardViewDeleteBtnClick {
    NSLog(@"numberKeyBoardViewDeleteBtnClick");
    if (self.text.length>0) {
        self.text = [[self.text substringToIndex:self.text.length-1] mutableCopy];
    }
    
}

#pragma mark - Setter Methods
- (void)setText:(NSString *)text {
    if (text.length<=0) {
        text = [NSString stringWithFormat:@"%@%@",text,NumberToolViewPlaceHolder];
    }
    if (![_textLabel.text isEqualToString:text]) {
        _textLabel.text = text;
        if ([self.delegate respondsToSelector:@selector(hlNumberTextViewTextDidChange:)]) {
            [self.delegate hlNumberTextViewTextDidChange:_textLabel.text];
        }
    }
    
}



#pragma mark - Getter Methods
- (HLNumberKeyBoardView *)numberKeyboard {
    if (_numberKeyboard == nil) {
        __weak HLNumberTextView *this = self;
        _numberKeyboard = [[HLNumberKeyBoardView alloc] initWithFrame:CGRectMake(0, kdeviceHeight, kdeviceWidth, NumberKeyBoardViewHeight)];
        _numberKeyboard.hidden = YES;
        [_numberKeyboard setNumberKeyBoardViewSelectedMainNumber:^(NSString *numberStr) {
            [this numberKeyBoardViewSelectedMainKeyNumber:numberStr];
        }];
        [_numberKeyboard setNumberKeyBoardViewSelectedSpecialNumber:^(NSString *numberStr) {
            [this numberKeyBoardViewSelectedSpecialKeyNumber:numberStr];
        }];
        [_numberKeyboard setNumberKeyBoardViewDeleteBtnClick:^{
            [this numberKeyBoardViewDeleteBtnClick];
        }];
        [_numberKeyboard setNumberKeyBoardViewConfirmBtnClick:^{
            [this numberKeyBoardViewConfirmBtnClick];
        }];
    }
    
    return _numberKeyboard;
}
- (NSString *)text {
    NSString *text = _textLabel.text;
    return text;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
