//
//  ToolView.m
//  demo
//
//  Created by Zhl on 16/9/26.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import "ToolView.h"
#import "ReadLocalData.h"
#import "AppDelegate.h"

@interface ToolView ()
{
    UIView *_upLine;
    UIView *_downLine;
    CGFloat x,y,w,h;
}
@property (nonatomic,weak) UIButton *speakBtn;    //语音
@property (nonatomic,weak) UIButton *faceBtn;     // 表情/文字键盘
@property (nonatomic,weak) UIButton *addBtn;      // +
@property (nonatomic,weak) UIButton *recordBtn;   //录音
@end

@implementation ToolView
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:230/256.0 green:230/256.0 blue:230/256.0 alpha:1];
        self.userInteractionEnabled = YES;
        x=0,y=0,w=self.width,h=1;
        _upLine = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _upLine.backgroundColor = [UIColor grayColor];
        y=self.height-1;
        _downLine = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _downLine.backgroundColor = [UIColor grayColor];
        _showFlag = BoardShowTypeSpeak;

        [self addSubview:_upLine];
        [self addSubview:_downLine];
        
        [self addSubview:[self getSpeakBtn]];
        [self addSubview:[self getAddBtn]];
        [self addSubview:[self getFaceBtn]];
        [self addSubview:[self getMyTextView]];
        [self addSubview:[self getRecordLabel]];
        

    }
    return self;
}
-(void)touchSpace{
    self.showFlag = BoardShowTypeSpeak;
}
#pragma mark --------------------------- action
-(void)speakBtnClick:(UIButton *)btn{
    self.myTextView.text = @"";
    [self textViewDidChange:self.myTextView];
    self.myTextView.hidden = YES;
    self.recordBtn.hidden = NO;
    self.showFlag = BoardShowTypeSpeak;
    
}
-(void)addBtnClick:(UIButton *)btn{
    self.showFlag = BoardShowTypeAdd;
}
-(void)faceBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected == YES) {
        self.showFlag = BoardShowTypeEmotion;
        
    }else{
        self.showFlag = BoardShowTypeKeyBoard;
    }
    
}
-(void)recordBtnTouchBegain:(UIButton*)btn{
    [btn setTitle:@"松开发送语音" forState:UIControlStateNormal];
    [[MediaRecordAndPlayer shareInstance] begainRecord];
    NSLog(@"开始");
}
-(void)recordBtnTouchEnd:(UIButton*)btn{
    [btn setTitle:@"按住开始说话" forState:UIControlStateNormal];
    NSData *data = [NSData dataWithData:[[MediaRecordAndPlayer shareInstance] getRecordData]];
    
    if (self.getRecordData) {
        self.getRecordData(data);
    }
    NSLog(@"结束");
}
-(void)keyboardWillShow:(NSNotification*)notification{
    self.showFlag = BoardShowTypeKeyBoard;
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keybordFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGRect frame = self.superview.frame;
    frame.origin.y = self.superview.superview.frame.size.height-keybordFrame.size.height-self.height;
    self.faceBtn.selected = NO;
    if ([self.delegate respondsToSelector:@selector(toolViewKeyboardWillShowWithFrame:andDelays:)]) {
        [self.delegate toolViewKeyboardWillShowWithFrame:keybordFrame andDelays:duration];
    }
}
-(void)keyboardWillHidden:(NSNotification*)notification{
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect frame = self.superview.frame;
    frame.origin.y = self.superview.superview.frame.size.height-frame.size.height;
    [UIView animateWithDuration:duration animations:^{
        self.superview.frame = frame;
        [self.superview setNeedsLayout];
    } completion:^(BOOL finished) {
    
    }];
}
#pragma mark --------------------------- setter or getter methods
-(void)setShowFlag:(BoardShowType)showFlag{
    self.myTextView.hidden = NO;
    self.recordBtn.hidden = YES;
    if (showFlag == BoardShowTypeKeyBoard) {//键盘
        if (![self.myTextView isFirstResponder]) {
            [self.myTextView becomeFirstResponder];
        }
        
    }else if (showFlag == BoardShowTypeEmotion){//表情

        if ([self.myTextView isFirstResponder]) {
            [self.myTextView resignFirstResponder];
        }
    }else if (showFlag == BoardShowTypeAdd){//add

        if ([self.myTextView isFirstResponder]) {
            [self.myTextView resignFirstResponder];
        }
    }else if (showFlag == BoardShowTypeSpeak){

        self.myTextView.hidden = YES;
        self.recordBtn.hidden = NO;
        if ([self.myTextView isFirstResponder]) {
            [self.myTextView resignFirstResponder];
        }
    }
    if ([self.delegate respondsToSelector:@selector(boardShowWithType:)]) {
        [self.delegate boardShowWithType:showFlag];
    }
    
}



-(UIButton *)getSpeakBtn{
    UIImage *recordImg = [UIImage imageNamed:@"speak"];
    x = 5,y=(self.height-recordImg.size.height)/2.0-2,
    w=recordImg.size.width,h=recordImg.size.height;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(x, y, w, h);
    [btn setBackgroundImage:recordImg forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(speakBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _speakBtn = btn;
        
    return _speakBtn;
}
-(UIButton*)getAddBtn{
    UIImage *img = [UIImage imageNamed:@"add1"];
    x = self.width-5-img.size.width,y=(self.height-img.size.height)/2.0,w=img.size.width,h=img.size.height;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(x, y, w, h);
    [btn setBackgroundImage:img forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _addBtn = btn;
    return _addBtn;
}
-(UIButton *)getFaceBtn{
    UIImage *normalImg = [UIImage imageNamed:@"smile"];
    UIImage *selectImg = [UIImage imageNamed:@"keyboard"];
    x = self.addBtn.left-10-normalImg.size.width;
    y = (self.height-normalImg.size.height)/2.0;
    w = normalImg.size.width;
    h = normalImg.size.height;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(x, y, w, h);

    [btn setBackgroundImage:normalImg forState:UIControlStateNormal];
    [btn setBackgroundImage:selectImg forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(faceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _faceBtn = btn;
    return _faceBtn;
}
-(UITextView*)getMyTextView{

    x = self.speakBtn.right+10, y = 5,
    h = self.height-10, w = self.width-x-25-self.faceBtn.width-self.addBtn.width;
    
    UITextView *textView = [[UITextView alloc] init];
    textView.frame = CGRectMake(x, y, w, h);
    textView.delegate = self;
//    textView.backgroundColor = [UIColor grayColor];
    textView.layer.borderColor = [UIColor grayColor].CGColor;
    textView.layer.borderWidth = 1;
    textView.layer.cornerRadius = 5;
    textView.layer.masksToBounds = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    textView.hidden = NO;
//    textView.font = [UIFont systemFontOfSize:15];
    [textView addSubview:[self getPlaceHolderLabel]];
    _myTextView = textView;
    return _myTextView;
}
-(UIButton *)getRecordLabel{

    x = self.myTextView.frame.origin.x;
    y = self.myTextView.frame.origin.y;
    w = self.myTextView.frame.size.width;
    h = self.height - 10;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(x, y, w, h);
    [btn setTitle:@"按住开始说话" forState:UIControlStateNormal];
//    [btn setTitle:@"松开发送语音" forState:UIControlStateSelected];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    btn.layer.borderColor = [UIColor grayColor].CGColor;
    btn.layer.borderWidth = 1;
    btn.backgroundColor = [UIColor colorWithRed:190/256.0 green:190/256.0 blue:190/256.0 alpha:1];
    [btn setTitleColor:[UIColor colorWithRed:50/256.0 green:50/256.0 blue:50/256.0 alpha:1] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(recordBtnTouchBegain:) forControlEvents:UIControlEventTouchDown];
    [btn addTarget:self action:@selector(recordBtnTouchEnd:) forControlEvents:UIControlEventTouchUpInside];
    btn.enabled = YES;
    btn.hidden = YES;
    _recordBtn = btn;
    return _recordBtn;
}
-(UILabel*)getPlaceHolderLabel{
    CGRect frame = CGRectMake(0, 0, self.width-x-25-self.faceBtn.width-self.addBtn.width, self.height-10);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textColor = [UIColor colorWithRed:150/256.0 green:150/256.0 blue:150/256.0 alpha:1];
    _placeHolderLabel.hidden = YES;
    _placeHolderLabel = label;
//    _placeHolderLabel.backgroundColor = [UIColor yellowColor];
    return _placeHolderLabel;
}
#pragma mark - UITextViewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView{
//    self.placeHolderLabel.hidden = YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSString *lang = textView.textInputMode.primaryLanguage;//键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]&&[text isEqualToString:@""]){
        UITextRange *selectedRange = [textView markedTextRange];
        if (selectedRange) {//有高亮
            return YES;
        }
    }
    if ([text isEqualToString:@""]) {//键盘删除按钮被点击
        NSString *str = textView.text;
        if (range.length!=1) {
            return YES;
        }else{
            if (([str length]-1) == range.location) {
                [self deleteSpecialStrAtLast];
                return NO;
            }else{//当在中间删除的时候
                [self deleteSpecialStrAtCenter:str range:range];
            }
            [self textViewDidChange:self.myTextView];
            return  NO;
        }
    }else{//替换有值的时候是在输入
        return YES;
    }
    return YES;
}
-(void)textViewDidChange:(UITextView *)textView{
    if (self.textViewDidChangeBlock) {
        [self updateSelfFrame];
        self.textViewDidChangeBlock(textView.text);
    }
}
-(void)deleteSpecialStrAtLast{
    NSString *str = self.myTextView.text;
    
    if ([str length] == 0) {
        return ;
    }
    
    NSString *tmpTest = [str substringWithRange:NSMakeRange([str length]-1, 1)];
    if ([tmpTest isEqualToString:@"]"]) {
        [self deleteTheLastFaceWithStr:str];
    }else if([tmpTest isEqualToString:@" "]){
        [self deleteTheLastAtPeopleWithStr:str];
    }else{
        NSString *tmpWZ = [str substringToIndex:[str length]-1];
        self.myTextView.text = tmpWZ;
        [self.myTextView scrollRangeToVisible:NSMakeRange([self.myTextView.text length], 0)];
        [self textViewDidChange:self.myTextView];
    }
}
-(void)deleteTheLastFaceWithStr:(NSString *)str{
    for (NSInteger i = ([str length]-1); i > 0; i--) {
        NSString *tmpString = [str substringWithRange:NSMakeRange(i-1, 1)];
        if ([tmpString isEqualToString:@"["]) {
            NSInteger curLength = [str length] - (i-1);
            NSString *tmpStr1 = [str substringWithRange:NSMakeRange(i-1, curLength)];
            //删除表情
            NSDictionary *dict = [[ReadLocalData defaultReadLocalData] getFaceStrDict];
            NSString *faceStr = [dict objectForKey:tmpStr1];
            
            if (faceStr != nil) {
                NSString *strOne = [str substringToIndex:i-1];
                self.myTextView.text = strOne;
                [self.myTextView scrollRangeToVisible:NSMakeRange([self.myTextView.text length], 0)];
                //需要手动调用代理方法，否则无法统计字数
                [self textViewDidChange:self.myTextView];
                return;
            }
        }
    }
    NSString *tmpWZ = [str substringToIndex:[str length]-1];
    self.myTextView.text = tmpWZ;
    [self.myTextView scrollRangeToVisible:NSMakeRange([self.myTextView.text length], 0)];
    [self textViewDidChange:self.myTextView];
}
-(void)deleteTheLastAtPeopleWithStr:(NSString*)str{
    

    for (NSInteger i = ([str length]-1); i > 0; i--) {
        NSString *tmpString = [str substringWithRange:NSMakeRange(i-1, 1)];
        if ([tmpString isEqualToString:@" "]) {
            NSString *tmpWZ = [str substringToIndex:[str length]-1];
            self.myTextView.text = tmpWZ;
            [self.myTextView scrollRangeToVisible:NSMakeRange([self.myTextView.text length], 0)];
            [self textViewDidChange:self.myTextView];
            return ;
        }else if([tmpString isEqualToString:@"@"]){
            //删除AT
            NSString *strOne = [str substringToIndex:i-1];
            self.myTextView.text = strOne;
            [self.myTextView scrollRangeToVisible:NSMakeRange([self.myTextView.text length], 0)];
            
            [self textViewDidChange:self.myTextView];
            return;
        }
    }
    NSString *tmpWZ = [str substringToIndex:[str length]-1];
    self.myTextView.text = tmpWZ;
    [self.myTextView scrollRangeToVisible:NSMakeRange([self.myTextView.text length], 0)];
    [self textViewDidChange:self.myTextView];
}
-(void)deleteSpecialStrAtCenter:(NSString*)str range:(NSRange)range{
    //当在中间删除的时候
    if (range.location == 0 && range.length == 0) {
        return ;
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
                    
                    strOness = [strOness stringByAppendingString:strTwo];
                    self.myTextView.text = strOness;
                    self.myTextView.selectedRange = NSMakeRange(i-1, 0);
                    return ;
                }
            }
        }
        NSString *tmpWZ = [strOne substringToIndex:[strOne length]-1];
        tmpWZ = [tmpWZ stringByAppendingString:strTwo];
        self.myTextView.text = tmpWZ;
        self.myTextView.selectedRange = NSMakeRange([strOne length]-1, 0);
    }else if([tmpTest isEqualToString:@" "]){
        for (NSInteger i = ([strOne length]-1); i > 0; i--) {
            NSString *tmpString = [strOne substringWithRange:NSMakeRange(i-1, 1)];
            if ([tmpString isEqualToString:@" "]) {
                NSString *tmpWZ = [strOne substringToIndex:[strOne length]-1];
                tmpWZ = [tmpWZ stringByAppendingString:strTwo];
                self.myTextView.text = tmpWZ;
                self.myTextView.selectedRange = NSMakeRange([strOne length]-1, 0);
                return;
            }else if ([tmpString isEqualToString:@"@"]) {

                NSString *strOness = [strOne substringToIndex:i-1];
                strOness = [strOness stringByAppendingString:strTwo];
                self.myTextView.text = strOness;
                self.myTextView.selectedRange = NSMakeRange(i-1, 0);
                [self textViewDidChange:self.myTextView];
                return ;
            }
        }
        NSString *tmpWZ = [strOne substringToIndex:[strOne length]-1];
        tmpWZ = [tmpWZ stringByAppendingString:strTwo];
        self.myTextView.text = tmpWZ;
        self.myTextView.selectedRange = NSMakeRange([strOne length]-1, 0);
    }else{
        NSString *tmpWZ = [strOne substringToIndex:[strOne length]-1];
        tmpWZ = [tmpWZ stringByAppendingString:strTwo];
        self.myTextView.text = tmpWZ;
        self.myTextView.selectedRange = NSMakeRange([strOne length]-1, 0);
    }
    
}
#pragma mark ------------------------private methods
-(void)updateSelfFrame{
//    CGRect rect = [text boundingRectWithSize:CGSizeMake(self.myTextView.width, 1000000) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.myTextView.font} context:nil];
//    CGFloat height = rect.size.height;
    CGFloat height = self.myTextView.contentSize.height;
    if (height>30) {
        
        CGRect frame = self.frame;
        frame.size.height = height+10;
        self.frame = frame;
    }else{
        CGRect rect = self.frame;
        rect.size.height = 40;
        self.frame = rect;
    }
    //输入框
    self.myTextView.height = height;
    //语音按钮
    CGRect speakBtnFrame = self.speakBtn.frame;
    speakBtnFrame.origin.y = self.height-speakBtnFrame.size.height - (40-speakBtnFrame.size.height)/2.0-2;
    self.speakBtn.frame = speakBtnFrame;
    //表情按钮
    CGRect faceBtnFrame = self.faceBtn.frame;
    faceBtnFrame.origin.y = self.height-faceBtnFrame.size.height - (40 -faceBtnFrame.size.height)/2.0;
    self.faceBtn.frame = faceBtnFrame;
    //+按钮
    CGRect addBtnFrame = self.addBtn.frame;
    addBtnFrame.origin.y = self.height-addBtnFrame.size.height - (40 -addBtnFrame.size.height)/2.0;
    self.addBtn.frame = addBtnFrame;
    //downLine
    CGRect downLineFrame = _downLine.frame;
    downLineFrame.origin.y = self.height-_downLine.height;
    _downLine.frame = downLineFrame;

    if (self.updateFrame) {
        self.updateFrame(height);
    }
}


@end
