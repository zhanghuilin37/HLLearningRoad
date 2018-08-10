//
//  CommentInputBar.m
//  LotteryApp
//
//  Created by Feili on 13-9-4.
//  Copyright (c) 2013年 windo. All rights reserved.
//

#import "CommentInputBar.h"
#import "CommentToolBarView.h"
#import "ReadLocalData.h"
#import "FaceView.h"

typedef NS_ENUM(NSInteger,CPBBoardState) {
   CPBBoardStateFold,       //收起
   CPBBoardStateUnfold,     //显示键盘
   CPBBoardStateUnfoldFace, //显示表情
};


@interface CommentInputBar () <FaceViewDelegate,CommentToolBarViewDelegate> {
    CGFloat _keyBoardHeight;
}
@property (nonatomic, assign) id<CommentInputBarDelegate>delegate;
//当前空间的显示状态
@property (nonatomic,assign) CPBBoardState boardState;
//工具栏（包含输入框）
@property (nonatomic,weak)  CommentToolBarView *toolBarView;
//表情view
@property (nonatomic, weak) FaceView      *faceView;
//用于点击空白收回键盘
@property (nonatomic,strong)UIControl *tapSpaceControl;
@end

@implementation CommentInputBar
- (void)dealloc {
    [self.tapSpaceControl removeFromSuperview];
    self.tapSpaceControl=nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)commentInputBarWithPoint:(CGPoint)point AndDelegate:(id<CommentInputBarDelegate>)delegate {
    
    CGFloat height = FaceViewHeight + CommentNormalToolBarHeight;
    CommentInputBar *commentView = [[CommentInputBar alloc] initWithFrame:CGRectMake(point.x, point.y, [UIScreen mainScreen].bounds.size.width, height)];
    commentView.delegate = delegate;
    
    return commentView;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = rgb(250, 250, 250, 1);
        //监听键盘事件
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        [self p_createSubViews];
        _boardState = CPBBoardStateFold;//默认收起
    }
    return self;
}

//创建子控间
- (void)p_createSubViews {
    CommentToolBarView *toolBarView = [CommentToolBarView commentToolBarViewWithPoint:CGPointMake(0, 0) AndDelegate:self];
    self.toolBarView = toolBarView;
    [self addSubview:toolBarView];
    //表情键盘
    FaceView *faceView = [FaceView faceViewWithPoint:CGPointMake(0, toolBarView.bottom) andDelegate:self];
    self.faceView = faceView;
    [self addSubview:faceView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.faceView.frame = CGRectMake(0, self.height-FaceViewHeight, self.width, FaceViewHeight);
    self.toolBarView.frame = CGRectMake(0, 0, self.width, CommentNormalToolBarHeight + [self.toolBarView getDHeight]);
    self.tapSpaceControl.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.superview.height-self.height);
}

//表情移动到底部
- (void)p_moveToBottomDuration:(NSTimeInterval)duration {
    
    CGRect frame = self.frame;
    frame.origin.y = self.superview.frame.size.height-self.toolBarView.height-k_X_HomeSafeArea_H;
    [UIView animateWithDuration:duration animations:^{
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self setNeedsLayout];
    }];
}

//显示faceview
- (void)p_moveToFacePositionDuration:(NSTimeInterval)duration {
    CGRect frame = self.frame;
    CGFloat dHeight = [self.toolBarView getDHeight];
    frame.size.height = FaceViewHeight + CommentNormalToolBarHeight + dHeight;
    frame.origin.y = self.superview.frame.size.height-CommentNormalToolBarHeight-FaceViewHeight-dHeight;
    [UIView animateWithDuration:duration animations:^{
        self.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
}

//判断是不是收起状态
- (BOOL)p_isBottom {
    return self.frame.origin.y == self.superview.frame.size.height - CommentNormalToolBarHeight - [self.toolBarView getDHeight];
}


#pragma mark - Actions
//点击空白处
- (void)spaceControlAction {
    self.boardState = CPBBoardStateFold;
}
- (void)keyboardWillShow:(NSNotification *)info {
    NSTimeInterval duration = [info.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect kebordFrame = [info.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _keyBoardHeight = kebordFrame.size.height;
    CGRect frame = self.frame;
    frame.origin.y = self.superview.frame.size.height-kebordFrame.size.height-self.toolBarView.height;
    frame.size.height = kebordFrame.size.height+self.toolBarView.height;
    [UIView animateWithDuration:duration animations:^{
        self.frame = frame;
        [self setNeedsLayout];
    } completion:^(BOOL finished) {

    }];
}
- (void)keyboardWillHide:(NSNotification *)info {
    NSTimeInterval duration = [info.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if (self.boardState == CPBBoardStateUnfoldFace) {
        [self p_moveToFacePositionDuration:duration];
    } else {
        [self p_moveToBottomDuration:duration];
    }
}


#pragma mark - Public Methods
//开始编辑（显示系统键盘）
- (void)startEditing {
    self.boardState = CPBBoardStateUnfold;
}

//放弃第一响应者身份（收起键盘）
- (void)giveUpFirstResponder {
    self.boardState = CPBBoardStateFold;
}

//清空输入内容
- (void)clearText {
    self.toolBarView.inputTextView.text = @"";
    [self.toolBarView setPlaceHolderLabelHidden:NO];
}

//发送按钮是否可用点击发送时禁用，发送成功后打开禁用
-(void)setSendBtnEnable:(BOOL)isEnable {
    [self.toolBarView setSendBtnEnable:isEnable];
}


#pragma mark - < FacePageView delegate >
- (void)faceSelectedName:(NSString *)nameStr {
    [self.toolBarView changeTextWithFaceSelectedName:nameStr];
}

//代理里面的删除函数
- (void)faceDeleteClick {
    [self.toolBarView faceDeleteClick];
}


#pragma mark - <- CommentToolBarViewDelegate ->
- (void)sendBtnClick:(UIButton *)btn {
    [self giveUpFirstResponder];
    if ([self.delegate respondsToSelector:@selector(sendBtnClickedWithText:)]) {
        [self.delegate sendBtnClickedWithText:_toolBarView.inputTextView.text];
    }
    btn.enabled = NO;
}

//表情/键盘按钮被点击
- (void)faceBtnClick:(UIButton *)btn {
    if ([self p_isBottom]) {
        self.boardState = CPBBoardStateUnfold;
    } else {
        if (btn.selected) {//键盘
            self.boardState = CPBBoardStateUnfold;
            btn.selected = NO;
        } else {
            self.boardState = CPBBoardStateUnfoldFace;
            btn.selected = YES;
        }
    }
}

//更新ToolBar父视图的frame
- (void)updateToolBarSuperViewFrame {
    if (self.boardState==CPBBoardStateUnfoldFace) {//表情
        self.height = self.toolBarView.height+self.faceView.height;
        self.top = self.superview.height-self.height;
    } else {//系统键盘
        self.height = self.toolBarView.height+_keyBoardHeight;
        self.top = self.superview.height-self.height;
    }
}

- (void)editingSwitchClick {
    self.boardState = CPBBoardStateUnfold;
}


#pragma mark - Setter Methods
- (void)setBoardState:(CPBBoardState)boardState {
    _boardState = boardState;
    switch (_boardState) {
        case CPBBoardStateFold: {//收起键盘
            self.faceView.hidden = YES;
            [self.toolBarView setEditingSwitchHidden:NO];
            [self.toolBarView setFaceBtnSelected:NO];
            [self.toolBarView.inputTextView resignFirstResponder];
            [self p_moveToBottomDuration:0.25];
            self.tapSpaceControl.hidden = YES;
            if ([self.toolBarView.inputTextView.text isEqualToString:@""]) {
                [self.toolBarView setPlaceHolderLabelHidden:NO];
            }
        }
            break;
        case CPBBoardStateUnfold: {//显示键盘
            self.faceView.hidden = YES;
            [self.toolBarView setEditingSwitchHidden:YES];
            [self.superview addSubview:self.tapSpaceControl];
            [self.superview bringSubviewToFront:self];
            [self.superview bringSubviewToFront:self.tapSpaceControl];
            [self.toolBarView.inputTextView becomeFirstResponder];
            self.tapSpaceControl.hidden = NO;
        }
            break;
        case CPBBoardStateUnfoldFace: {//显示表情
            self.faceView.hidden = NO;
            [self.toolBarView setEditingSwitchHidden:NO];
            [self.superview addSubview:self.tapSpaceControl];
            [self.superview bringSubviewToFront:self];
            [self.superview bringSubviewToFront:self.tapSpaceControl];
            [self.toolBarView.inputTextView resignFirstResponder];
            [self p_moveToFacePositionDuration:0.25];
            self.tapSpaceControl.hidden = NO;
            static BOOL onceFlag = YES;
            if (onceFlag) {
                //首次弹出加载第0页表情图片
                [self.faceView setImgsWithPage:0];
                onceFlag = NO;
            }
            
        }
            break;
    }
}


#pragma mark - Getter Methods
- (UIControl *)tapSpaceControl {
    if (_tapSpaceControl == nil) {
        _tapSpaceControl = [[UIControl alloc] init];
        [_tapSpaceControl addTarget:self action:@selector(spaceControlAction) forControlEvents:UIControlEventTouchUpInside];
        _tapSpaceControl.hidden = YES;
    }
    _tapSpaceControl.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.superview.height-self.height);
    return _tapSpaceControl;
}
@end
