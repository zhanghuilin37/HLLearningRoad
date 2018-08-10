//
//  CTEmotionKeyBoard.m
//  demo
//
//  Created by Zhl on 16/9/26.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import "CTEmotionKeyBoard.h"
#import "FaceView.h"
#import "TZImagePickerController.h"
@interface CTEmotionKeyBoard ()<ToolViewDelegate,TZImagePickerControllerDelegate>
{
    /**
     *  更新frame时用   tooview下部的高度（键盘或者contentView的高度）
     */
    CGFloat _downHeight;
}
@property (nonatomic,weak) ToolView *toolView;
/**  
 * 存放faceView和toolView
 */
@property (nonatomic,strong) UIView *contentView;
/**
 * 表情视图
 */
@property (nonatomic,strong) FaceView *faceView;
/**
 * +视图
 */
@property (nonatomic,strong) AddView *addView;
/**
 * 点击父视图的空白处收回键盘
 */
@property (nonatomic,weak) UIControl *control;
@end

@implementation CTEmotionKeyBoard
-(void)dealloc{
    [self removeControlFromWindow];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self addSubview:[self getToolView]];
        __weak CTEmotionKeyBoard *this = self;
        //由于铺设表情键盘耗时较长，可能会造成控制器延迟跳转，故将其 加入子线程执行
        dispatch_async(dispatch_get_main_queue(), ^{
            [this addSubview:[this getContentView]];
        });
        
    }
    return self;
}
#pragma mark - Actions
//点击空白处收回键盘
-(void)touchSpace{
    if ([self.toolView.myTextView isFirstResponder]) {
        [self.toolView.myTextView resignFirstResponder];
    }
    __weak CTEmotionKeyBoard *this = self;
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = this.frame;
        frame.origin.y = this.superview.size.height-self.toolView.height;
        this.frame = frame;
    }completion:^(BOOL finished) {
        [self removeControlFromWindow];
    }];
}

#pragma mark - ToolViewDelegate
-(void)boardShowWithType:(BoardShowType)type{
    if (type == BoardShowTypeEmotion) {
        
        self.addView.hidden = YES;
        self.faceView.hidden = NO;
        CGRect frame = self.frame;
        frame.origin.y = self.superview.size.height-self.height;
        [self addControlToWindow];
        _downHeight = ContentViewHeight;
        [self updateFrameWithNewFrame:frame];
    }else if (type == BoardShowTypeAdd){
        self.faceView.hidden = YES;
        self.addView.hidden = NO;
        CGRect frame = self.frame;
        frame.origin.y = self.superview.size.height-self.height;
        [self addControlToWindow];
        _downHeight = ContentViewHeight;
        [self updateFrameWithNewFrame:frame];
    }else if (type == BoardShowTypeSpeak){
        CGRect frame = self.frame;
        frame.origin.y = self.superview.size.height-40;
        
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = frame;
        }completion:^(BOOL finished) {
            _downHeight = ContentViewHeight;
            [self removeControlFromWindow];
        }];
    }
}
-(void)toolViewKeyboardWillShowWithFrame:(CGRect)frame andDelays:(NSTimeInterval)delays{
    CGRect selfFrame = self.frame;
    selfFrame.origin.y = self.superview.frame.size.height-frame.size.height-self.toolView.height;
    [self addControlToWindow];

    _downHeight = frame.size.height;
    [self updateFrameWithNewFrame:selfFrame];
}
#pragma mark - publicMethods
/**
 *  删除录音文件
 */
-(void)removeRecordData{
    [[MediaRecordAndPlayer shareInstance] removeVoice];
}
/**
 *  移除control
 */
-(void)removeControlFromWindow{
    if (self.control!=nil) {
        [self.control removeFromSuperview];
    }
}
#pragma mark - privateMethods
-(void)updateFrameWithNewFrame:(CGRect)newFrame{
    [self.toolView updateFrame];
    [UIView animateWithDuration:0.25 animations:^{
//        self.frame = newFrame;
        CGRect frame = newFrame;
        frame.size.height = _downHeight+self.toolView.height;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height-frame.size.height-64;
        self.frame = frame;
        //content
        CGRect contentFrame = self.contentView.frame;
        contentFrame.origin.y = self.toolView.bottom;
        self.contentView.frame = contentFrame;
        //control
        if (self.control) {
            CGRect controlFrame = self.control.frame;
            controlFrame.size.height = self.top;
            self.control.frame = controlFrame;
        }
    }];
}
-(void)addControlToWindow{
    if (self.control == nil) {
        UIControl *control = [[UIControl alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH,self.origin.y)];
        [control addTarget:self action:@selector(touchSpace) forControlEvents:UIControlEventAllTouchEvents];
        [[UIApplication sharedApplication].keyWindow addSubview:control];
        control.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.9];
        self.control = control;
    }else{
        self.control.frame = CGRectMake(0, 64, SCREEN_WIDTH, self.origin.y);
    }
}
#pragma mark - setter or getter methods
-(void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolder = placeHolder;
    if (placeHolder.length) {
        self.toolView.placeHolderLabel.text = placeHolder;
        if (self.toolView.myTextView.text.length>0) {
            self.toolView.placeHolderLabel.hidden = YES;
        }else{
            self.toolView.placeHolderLabel.hidden = NO;
        }
    }
}
-(ToolView *)getToolView{
    ToolView *toolView = [[ToolView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ToolViewHeith)];
    toolView.delegate = self;
    __weak CTEmotionKeyBoard *this = self;
    __weak ToolView *weakToolView = toolView;
    [toolView setTextViewDidChangeBlock:^(NSString *text) {
        if (text.length) {
            weakToolView.placeHolderLabel.hidden = YES;
        }else{
            weakToolView.placeHolderLabel.hidden = NO;
        }
        if ([this.delegate respondsToSelector:@selector(emotionKeyBoard:textDidChanged:)]) {
            
            [this.delegate emotionKeyBoard:this textDidChanged:text];
            [this.toolView.myTextView scrollRangeToVisible:NSMakeRange(text.length-1, 1)];
            [this updateFrameWithNewFrame:this.frame];
        }
    }];
    [toolView setGetRecordData:^(NSData *recordData) {
        if ([this.delegate respondsToSelector:@selector(emotionKeyBoard:RecordHasEnd:)]) {
            [this.delegate emotionKeyBoard:this RecordHasEnd:recordData];
        }
    }];
    _toolView = toolView;
    return _toolView;
}
-(UIView *)getContentView{
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, ToolViewHeith, self.width, ContentViewHeight)];
    [_contentView addSubview:self.faceView];
    [_contentView addSubview:self.addView];
    return _contentView;
}
-(FaceView *)faceView{
    if (_faceView == nil) {
        _faceView = [[FaceView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, self.contentView.height)];
        _faceView.backgroundColor = [UIColor colorWithRed:240/256.0 green:240/256.0 blue:240/256.0 alpha:1];
        __weak CTEmotionKeyBoard *this = self;
        [_faceView setFaceName:^(NSString *faceName) {
            NSLog(@"faceName:%@",faceName);
            NSMutableString *newText = [NSMutableString stringWithString:this.toolView.myTextView.text] ;
            [newText appendString:faceName];
            this.toolView.myTextView.text = newText;
            [this.toolView textViewDidChange:this.toolView.myTextView];
        }];
        [_faceView setFaceDeleteClick:^{
            NSString *text = this.toolView.myTextView.text;
            if (text.length>0) {
                NSRange range = {text.length-1,1};
                NSString *replacementText = @"";
                [this.toolView textView:this.toolView.myTextView shouldChangeTextInRange:range replacementText:replacementText];
            }
            NSLog(@"faceDeleteClicked");
        }];
    }
    return _faceView;
}
-(AddView *)addView{
    if (_addView == nil) {
        _addView = [[AddView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, self.contentView.height)];
        _addView.backgroundColor = [UIColor colorWithRed:240/256.0 green:240/256.0 blue:240/256.0 alpha:1];
        __weak CTEmotionKeyBoard *this = self;
        [_addView setAddViewBtnClicked:^(AddViewBtnTag btnTag) {
            if ([this.delegate respondsToSelector:@selector(emotionKeyBoard:addViewClicked:)]) {
                [this.delegate emotionKeyBoard:this addViewClicked:btnTag];
            }
        }];
    }
    return _addView;
}
#pragma mark - public methods
-(void)showWithType:(BoardShowType)type{
    self.toolView.showFlag = type;
}
-(void)moveToBottom{
    CGRect frame = self.frame;
    frame.origin.y = self.superview.size.height-self.toolView.height;
    _downHeight = ContentViewHeight;
    [self removeControlFromWindow];
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = frame;
    }completion:^(BOOL finished) {

    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
