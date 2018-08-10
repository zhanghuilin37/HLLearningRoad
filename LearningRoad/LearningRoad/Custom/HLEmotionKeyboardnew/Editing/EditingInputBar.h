//
//  EditingInputBar.h
//  HandicapWin
//
//  Created by CH10 on 16/4/27.
//  Copyright © 2016年 赢盘. All rights reserved.
//

#import <UIKit/UIKit.h>
#define PostingBarHeight                44.0f
#define FaceViewHeight                  216.0f

@protocol EditingInputBarDelegate <NSObject>
/**去选择图片*/
-(void)goAlbum;
/**选择at的人*/
-(void)goAtFriends;
/**表情和键盘切换*/
-(void)faceBtnClicked:(UIButton*)btn;
/**表情选择*/
-(void)faceWasSelectedName:(NSString *)nameStr;
/**删除按钮*/
-(void)deleteBtnClicked;

@end

//@class WriteViewController;
@interface EditingInputBar : UIView

//@property (nonatomic, assign) WriteViewController *delegate;
@property(nonatomic,assign)id<EditingInputBarDelegate> delegate;
@property (nonatomic,weak) UIButton      *faceBtn;
@property (nonatomic,weak) UIButton      *atBtn;
@property (nonatomic,weak)UIButton *walletBtn;
//@property (nonatomic,weak)YYTextView *inputView;

- (void) hideAtBtn;
- (void)setImgs;
@end

