//
//  HLTextView.m
//  demo
//
//  Created by Zhl on 16/11/18.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import "HLTextView.h"

@interface HLTextView ()
@property (nonatomic,weak)UILabel *placeHolderLabel;
@end

@implementation HLTextView
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}
- (instancetype)initWithFrame:(CGRect)frame HasToolBar:(BOOL)hasToolBar
{
    self = [super initWithFrame:frame];
    if (self) {
        //placeHolderLabel
        CGFloat x,y,w,h;
        x = 5,  y = 5,  w = frame.size.width-10,   h = frame.size.height-10;
        UILabel *placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        placeHolderLabel.numberOfLines = 0;
        placeHolderLabel.hidden = YES;
        placeHolderLabel.contentMode = UIViewContentModeTopLeft;
        placeHolderLabel.font = self.font;
        placeHolderLabel.backgroundColor = [UIColor yellowColor];
        placeHolderLabel.textColor = [UIColor grayColor];

        self.contentInset = UIEdgeInsetsMake(5, 0, 10, 0);
        _placeHolderLabel = placeHolderLabel;
        [self addSubview:_placeHolderLabel];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
        if (hasToolBar) {
            UIToolbar *tool = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.titleLabel.font = [UIFont systemFontOfSize:25];
            button.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
            [button addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:@"确        定" forState:UIControlStateNormal];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            UIBarButtonItem *sureItem = [[UIBarButtonItem alloc] initWithCustomView:button];
            UIBarButtonItem *spaceItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            [spaceItem1 setWidth:-16];
            tool.items =@[spaceItem1,sureItem];
            self.inputAccessoryView =tool;
        }
    }
    return self;
}
//重写父类 删除 方法
- (void)deleteBackward {
    //    ！！！这里要调用super方法，要不然删不了东西
    [super deleteBackward];
    if ([self.hlTextViewDelegate respondsToSelector:@selector(hlTextViewDeleteBackward:)]) {
        [self.hlTextViewDelegate hlTextViewDeleteBackward:self];
    }
}
#pragma mark - Actions
-(void)sureBtnClick:(UIButton*)btn{
    [self resignFirstResponder];
}
-(void)textDidChange{
    NSLog(@"改变");
    if (self.placeHolder.length>0) {
        self.placeHolderLabel.hidden = self.hasText;
    }else{
        self.placeHolderLabel.hidden = YES;
    }
}
#pragma mark - setter Methods
-(void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolder = placeHolder;
    if (_placeHolder.length) {
        
        self.placeHolderLabel.text = placeHolder;
        [self updatePlaceHolderSize];
        self.placeHolderLabel.hidden = NO;
    }
}
-(void)setPlaceHolderColor:(UIColor *)placeHolderColor{
    self.placeHolderLabel.textColor = placeHolderColor;
}
-(void)setPlaceHolderFont:(UIFont *)placeHolderFont{
    self.placeHolderLabel.font = placeHolderFont;
    [self updatePlaceHolderSize];
}
#pragma mark - public Methods
+(NSInteger)getWordNumber:(UITextView*)textView{
    NSString *language = textView.textInputMode.primaryLanguage;
    static NSInteger length = 0;
    if ([language isEqualToString:@"zh-Hans"]) {//汉字
        UITextRange *selectedRange = [textView markedTextRange];
        //避免拼音计入字数引起不必要麻烦
        if (!selectedRange) {//没有高亮
            length = textView.text.length;
        }else{//有高亮时暂不统计字数
            
        }
    }else{
        length = textView.text.length;
    }
    return length;
}
#pragma mark - private Methods
-(void)updatePlaceHolderSize{
    CGSize size = [_placeHolder boundingRectWithSize:CGSizeMake(self.frame.size.width-10, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.placeHolderLabel.font} context:nil].size;
    CGRect frame = self.placeHolderLabel.frame;
    frame.size.height = size.height>self.height-10?self.height:size.height;
    self.placeHolderLabel.frame = frame;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
