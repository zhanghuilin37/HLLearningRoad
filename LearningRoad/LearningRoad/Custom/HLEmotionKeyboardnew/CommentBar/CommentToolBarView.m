//
//  CommentToolBarView.m
//  BBSDemo
//
//  Created by Zhl on 2017/9/4.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import "CommentToolBarView.h"
#import "ReadLocalData.h"
@interface CommentToolBarView()<UITextViewDelegate>

@property (nonatomic,weak) UIView       *hline2;//底部细线
@property (nonatomic,weak) UIView       *hBolderLine;//中间较粗黑线
@property (nonatomic,weak) UIButton     *faceBtn;//表情/键盘按钮
@property (nonatomic,weak) UIButton     *commentBtn;//发送按钮
@property (nonatomic,weak) UIImageView  *inputBgImgView;//输入框背景图片
@property (nonatomic,weak) UILabel      *placeholderLabel;//提示文本
@property (nonatomic,weak) UIControl    *editingSwitch;//唤醒键盘的开关(唤醒系统键盘的工作交给这个空间来完成，避免直接点击textView弹出键盘)
@property (nonatomic,weak) id<CommentToolBarViewDelegate> delegate;

@end

@implementation CommentToolBarView
+ (instancetype)commentToolBarViewWithPoint:(CGPoint)point AndDelegate:(id<CommentToolBarViewDelegate>)delegate {
    CommentToolBarView *toolBarView = [[CommentToolBarView alloc] initWithFrame:CGRectMake(point.x, point.y, SCREEN_WIDTH, CommentNormalToolBarHeight)];
    toolBarView.delegate = delegate;
    toolBarView.inputTextView.delegate = toolBarView;
    return toolBarView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self p_createSubViews];
    }
    return self;
}

- (void)p_createSubViews {
    
    //表情按钮
    UIImage *faceImg =[UIImage imageNamed:@"smile"];
    CGFloat x = 11,y = 9,w = faceImg.size.width,h = faceImg.size.height;
    UIButton *faceBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    faceBtn1.frame = CGRectMake(x, y, w, h);
    [faceBtn1 setImage:faceImg forState:UIControlStateNormal];
    UIImage *faceImg1 = [UIImage imageNamed:@"keyboard"];
    [faceBtn1 setImage:faceImg1 forState:UIControlStateSelected];
    [faceBtn1 addTarget:self action:@selector(faceBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    self.faceBtn = faceBtn1;
    [self addSubview:faceBtn1];
    
    //发送按钮
    UIImage *sendImg = [UIImage imageNamed:@"sendGray"];
    x=SCREEN_WIDTH-11-sendImg.size.width,y = 7,w = sendImg.size.width,h=sendImg.size.height;
    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [commentBtn imageForState:UIControlStateDisabled];
    commentBtn.enabled = NO;
    [commentBtn setBackgroundImage:sendImg forState:UIControlStateDisabled];
    sendImg = [UIImage imageNamed:@"sendRed"];
    [commentBtn setBackgroundImage:sendImg forState:UIControlStateNormal];
    commentBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    commentBtn.frame = ccr(x, y, w, h);
    
    [commentBtn addTarget:self action:@selector(commentBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:commentBtn];
    self.commentBtn = commentBtn;
    
    //输入框背景图
    x = faceBtn1.right+11, y = (self.height-CommentNormalToolBarTextViewHeight)/2.0, w = SCREEN_WIDTH-faceImg.size.width-44-sendImg.size.width, h =CommentNormalToolBarTextViewHeight;
    UIImage *img = [UIImage imageNamed:@""];
    img = [img stretchableImageWithLeftCapWidth:img.size.width/2 topCapHeight:img.size.height/2];
    UIImageView *inputBgImgView = [[UIImageView alloc] initWithImage:img];
    inputBgImgView.frame = ccr(x, y, w, h);
    inputBgImgView.userInteractionEnabled = YES;
    self.inputBgImgView = inputBgImgView;
    [self addSubview:_inputBgImgView];
    
    //输入框
    UITextView *inputTextView = [[UITextView alloc] initWithFrame:_inputBgImgView.bounds];
    inputTextView.font = [UIFont systemFontOfSize:13];
    inputTextView.backgroundColor = [UIColor clearColor];
    inputTextView.clipsToBounds = YES;
    self.inputTextView = inputTextView;
    [self.inputBgImgView addSubview:inputTextView];
    
    
    //
    UIControl *editingSwitch = [[UIControl alloc] initWithFrame:self.inputTextView.bounds];
    [editingSwitch addTarget:self action:@selector(editingSwitchClick) forControlEvents:UIControlEventTouchUpInside];
    self.editingSwitch = editingSwitch;
    [self.inputTextView addSubview:_editingSwitch];
    
    //提示
    UILabel *placeholderLabel = [[UILabel alloc] initWithFrame:CGRectInset(self.inputTextView.bounds, 5, 0)];
    placeholderLabel.font = [UIFont systemFontOfSize:13];
    placeholderLabel.text = PlaceHolderKey;
    placeholderLabel.textColor = rgb(187, 187, 187,1);
    placeholderLabel.backgroundColor = [UIColor clearColor];
    self.placeholderLabel = placeholderLabel;
    [self.inputTextView addSubview:placeholderLabel];
    
    
    //中间较粗的线
    x = _inputBgImgView.left,y=_inputBgImgView.bottom,w=_inputBgImgView.width,h=1;
    UIView *hBolderLine = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    hBolderLine.backgroundColor = rgb(206, 206, 206, 1);
    self.hBolderLine = hBolderLine;
    [self addSubview:_hBolderLine];
    
    //顶部细线
    UIView *hline1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    hline1.backgroundColor = rgb(220, 221, 221, 1);
    [self addSubview:hline1];
    
    //底部细线
    UIView *hline2 = [[UIView alloc] initWithFrame:CGRectMake(0, _inputBgImgView.bottom, SCREEN_WIDTH, 0.5)];
    hline2.backgroundColor = rgb(220, 221, 221, 1);
    self.hline2 = hline2;
    [self addSubview:_hline2];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIImage *faceImg =[UIImage imageNamed:@"smile"];
    CGFloat x = 11,y = 9,w = faceImg.size.width,h = faceImg.size.height;
    self.faceBtn.frame = ccr(x, y, w, h);
    
    UIImage *sendImg = [UIImage imageNamed:@"sendGray"];
    x=SCREEN_WIDTH-11-sendImg.size.width,y = 7,w = sendImg.size.width,h=sendImg.size.height;
    self.commentBtn.frame = ccr(x, y, w, h);
    
    x = _faceBtn.right+11, y = (self.height-self.inputTextView.height)/2.0, w = SCREEN_WIDTH-faceImg.size.width-44-sendImg.size.width, h = self.inputTextView.height;
    
    self.inputBgImgView.frame = ccr(x, y, w, h);
    
    self.editingSwitch.frame = _inputTextView.bounds;
    
    self.placeholderLabel.frame = _inputTextView.bounds;
    
    self.hBolderLine.frame = CGRectMake(_inputBgImgView.left, _inputBgImgView.bottom, _inputBgImgView.width, 1);
    self.hline2.frame = CGRectMake(0, self.height-0.5, SCREEN_WIDTH, 0.5);
}


#pragma mark - Actions
//表情
- (void)faceBtnClicked {
    if ([self.delegate respondsToSelector:@selector(faceBtnClick:)]) {
        [self.delegate faceBtnClick:self.faceBtn];
    }
}

//发送
- (void)commentBtnClicked {
    if ([self.delegate respondsToSelector:@selector(sendBtnClick:)]) {
        [self.delegate sendBtnClick:self.commentBtn];
    }
}

//textView处被点击
- (void)editingSwitchClick {
    self.faceBtn.selected = NO;
    if ([self.delegate respondsToSelector:@selector(editingSwitchClick)]) {
        [self.delegate editingSwitchClick];
    }
}


#pragma mark - Public Methods
//藏表情/键盘切换按钮
- (void)setFaceBtnSelected:(BOOL)isSelected {
    self.faceBtn.selected = isSelected;
}

//提示语label是否隐藏
- (void)setPlaceHolderLabelHidden:(BOOL)isHidden {
    self.placeholderLabel.hidden = isHidden;
}

//textview上的control是否隐藏
- (void)setEditingSwitchHidden:(BOOL)isHidden {
    self.editingSwitch.hidden = isHidden;
}

//发送按钮是否可用
- (void)setSendBtnEnable:(BOOL)isEnable {
    self.commentBtn.enabled = isEnable;
}

//当选择表情后更改textview的text
- (void)changeTextWithFaceSelectedName:(NSString*)nameStr {
    [self textViewDidBeginEditing:self.inputTextView];
    NSString *tmpStr = self.inputTextView.text;
    tmpStr = [tmpStr stringByAppendingString:nameStr];
    
    if ([tmpStr length] > CommentWordCountMax) {
        return;
    } else {
        self.inputTextView.text = tmpStr;
        [self textViewDidChange:self.inputTextView];
    }
}

//单表情中的删除被点击时调用删除
- (void)faceDeleteClick {
    NSString *str = self.inputTextView.text;
    
    if (str.length == 0) {
        return;
    }
    
    NSString *tmpTest = [str substringWithRange:NSMakeRange(str.length-1, 1)];
    if ([tmpTest isEqualToString:@"]"]) {
        for (NSInteger i = (str.length-1); i > 0; i--) {
            NSString *tmpString = [str substringWithRange:NSMakeRange(i-1, 1)];
            if ([tmpString isEqualToString:@"["]) {
                NSInteger curLength = str.length - (i-1);
                NSString *tmpStr1 = [str substringWithRange:NSMakeRange(i-1, curLength)];
                NSDictionary *dict = [[ReadLocalData defaultReadLocalData] getFaceStrDict];
                
                NSString *faceStr = [dict objectForKey:tmpStr1];
                if (faceStr != nil) {
                    NSString *strOne = [str substringToIndex:i-1];
                    self.inputTextView.text = strOne;
                    [self textViewDidChange:self.inputTextView];
                    return;
                }
            }
        }
        NSString *tmpWZ = [str substringToIndex:str.length-1];
        self.inputTextView.text = tmpWZ;
    } else {
        NSString *tmpWZ = [str substringToIndex:str.length-1];
        self.inputTextView.text = tmpWZ;
    }
    
    [self textViewDidChange:self.inputTextView];
}

//获取当前toolbar和标准toolbar（CommentNormalToolBarHeight）的高度差
- (CGFloat)getDHeight {
    CGFloat textHeight = self.inputTextView.contentSize.height;
    CGFloat lineHeight =self.inputTextView.font.lineHeight;
    
    
    NSInteger numLines;
    CGRect txtFrame = self.inputTextView.frame;
    textHeight = [[NSString stringWithFormat:@"%@\n ", self.inputTextView.text] boundingRectWithSize:CGSizeMake(txtFrame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.inputTextView.font,NSFontAttributeName, nil] context:nil].size.height;
    
    numLines = textHeight/lineHeight-1;
    numLines = numLines >= CommentMaxLines ? CommentMaxLines-1 : numLines-1;
    return numLines*lineHeight;
}


#pragma mark - text view delegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (!textView.window.isKeyWindow) {
        [textView.window makeKeyAndVisible];
    }
    
    if (![textView.text isEqualToString:@""]) {
        self.placeholderLabel.hidden = YES;
        self.commentBtn.enabled = YES;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@""]) {   //替换是空的时候说明是删除呢
        NSString *str = textView.text;
        if (str.length == 0) {
            return NO;
        }else{
            if ((str.length-1) == range.location) {
                NSString *tmpTest = [str substringWithRange:NSMakeRange(str.length-1, 1)];
                if ([tmpTest isEqualToString:@"]"]) {
                    for (NSInteger i = (str.length-1); i > 0; i--) {
                        NSString *tmpString = [str substringWithRange:NSMakeRange(i-1, 1)];
                        
                        if ([tmpString isEqualToString:@"["]) {
                            NSInteger curLength = str.length - (i-1);
                            
                            NSString *tmpStr1 = [str substringWithRange:NSMakeRange(i-1, curLength)];
                            
                            NSDictionary *dict = [[ReadLocalData defaultReadLocalData] getFaceStrDict];
                            NSString *faceStr = [dict objectForKey:tmpStr1];
                            
                            if (faceStr != nil) {
                                NSString *strOne = [str substringToIndex:i-1];
                                //textview的text发生改变,但是此时返回No则不会调用textViewDidChange方法，所以需要手动调用
                                textView.text = strOne;
                                [textView.delegate textViewDidChange:textView];
                                return NO;
                            }
                        }
                    }
                    
                    NSString *tmpWZ = [str substringToIndex:str.length-1];
                    textView.text = tmpWZ;
                    [textView.delegate textViewDidChange:textView];
                    return NO;
                } else {
                    return YES;
                }
                
            } else {//当在中间删除的时候
                if (range.location == 0 && range.length == 0) {
                    return NO;
                }
                
                NSString *strOne = [str substringToIndex:range.location+1];
                NSString *strTwo = [str substringFromIndex:range.location+1];
                
                NSString *tmpTest = [strOne substringWithRange:NSMakeRange([strOne length]-1, 1)];
                
                if ([tmpTest isEqualToString:@"]"]) {
                    for (NSInteger i = ([strOne length]-1); i > 0; i--) {
                        NSString *tmpString = [strOne substringWithRange:NSMakeRange(i-1, 1)];
                        
                        if ([tmpString isEqualToString:@"["]) {
                            NSInteger curLength = [strOne length] - (i-1);
                            
                            NSString *tmpStr1 = [strOne substringWithRange:NSMakeRange(i-1, curLength)];
                            
                            NSDictionary *dict = [[ReadLocalData defaultReadLocalData] getFaceStrDict];
                            NSString *faceStr = [dict objectForKey:tmpStr1];
                            if (faceStr != nil) {
                                NSString *strOness = [strOne substringToIndex:i-1];
//                                NSLog(@"%@",strOness);
                                strOness = [strOness stringByAppendingString:strTwo];
                                textView.text = strOness;
                                textView.selectedRange = NSMakeRange(i-1, 0);
                                [textView.delegate textViewDidChange:textView];
                                return NO;
                            }
                        }
                    }
                    NSString *tmpWZ = [strOne substringToIndex:[strOne length]-1];
                    tmpWZ = [tmpWZ stringByAppendingString:strTwo];
                    textView.text = tmpWZ;
                    [textView.delegate textViewDidChange:textView];
                    textView.selectedRange = NSMakeRange([strOne length]-1, 0);
                }
            }
        }
    } else {//替换有值的时候是在输入
        if ([text length] + [textView.text length] > CommentWordCountMax) {
            return NO;
        }
        return YES;
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (!textView.text.length) {
        self.placeholderLabel.hidden = NO;
        [self.inputTextView setContentOffset:CGPointMake(0, 0)];
    }
}

//统计并限制字数时 注意中文联想模式
//由于要统计字数所以其他地方直接给textview的text赋值的时候需要手动调用此代理方法
- (void)textViewDidChange:(UITextView *)textView {
    NSString *lang = textView.textInputMode.primaryLanguage;//键盘输入模式
    static NSInteger length = 0;
    if ([lang isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange = [textView markedTextRange];
        if (!selectedRange) {//没有有高亮
            length = textView.text.length;
        } else {
            
        }
    } else {
        length = textView.text.length;
    }
    
    NSString *str = textView.text;
    if (length > CommentWordCountMax) {
        
        NSString *str1 = [str substringToIndex:CommentWordCountMax];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"最多%d字",CommentWordCountMax] delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        [alert show];
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        textView.text = str1;
        length = CommentWordCountMax;
    }
    
    
    if (textView.text.length) {
        _commentBtn.enabled = YES;
        _placeholderLabel.hidden = YES;
        _hBolderLine.hidden = YES;
    } else {
        _placeholderLabel.hidden = NO;
        _hBolderLine.hidden = NO;
        _commentBtn.enabled = NO;
    }
    [textView scrollRangeToVisible:NSMakeRange([textView.text length], 0)];
    [self p_updateFrame];
}

//当text发生改变时更改自身以及textView的frame，同时调用协议方法更新父控件的frame
- (void)p_updateFrame {
    CGFloat textHeight = self.inputTextView.contentSize.height;
    CGFloat lineHeight = self.inputTextView.font.lineHeight;
    NSInteger numLines;
    CGRect txtFrame = self.inputTextView.frame;
    textHeight = [[NSString stringWithFormat:@"%@\n ", self.inputTextView.text] boundingRectWithSize:CGSizeMake(txtFrame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.inputTextView.font,NSFontAttributeName, nil] context:nil].size.height;
    numLines = textHeight/lineHeight-1;
    
    textHeight = (numLines-1)*lineHeight;
    if (numLines > CommentMaxLines-1) {
        self.inputTextView.scrollEnabled = YES;
    } else {
        [self.inputTextView setContentOffset:CGPointMake(0, 0)];
        CGRect frame = self.frame;
        frame.size.height = CommentNormalToolBarHeight + textHeight;
        if (numLines>1) {
            
            self.inputTextView.frame = CGRectMake(_inputTextView.frame.origin.x, _inputTextView.frame.origin.y, _inputTextView.width, _inputTextView.contentSize.height);
            self.frame = frame;
        } else {
            self.inputTextView.frame = CGRectMake(_inputTextView.frame.origin.x, _inputTextView.frame.origin.y, _inputTextView.width, CommentNormalToolBarTextViewHeight);
            frame.size.height = CommentNormalToolBarHeight;
            self.frame = frame;
        }
        if ([self.delegate respondsToSelector:@selector(updateToolBarSuperViewFrame)]) {
            [self.delegate updateToolBarSuperViewFrame];
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
