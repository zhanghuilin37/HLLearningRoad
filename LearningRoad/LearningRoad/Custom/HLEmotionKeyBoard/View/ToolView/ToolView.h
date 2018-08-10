//
//  ToolView.h
//  demo
//
//  Created by Zhl on 16/9/26.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MediaRecordAndPlayer.h"
typedef enum {
    
    BoardShowTypeKeyBoard = 0,
    BoardShowTypeEmotion,
    BoardShowTypeAdd,
    BoardShowTypeSpeak
}BoardShowType;

@protocol ToolViewDelegate;
/**
 *  工具栏
 */
@interface ToolView : UIView<UITextViewDelegate>
@property(nonatomic,assign)id<ToolViewDelegate> delegate;
/**
 *  0、键盘 1、表情 2、add
 */
@property (nonatomic,assign) BoardShowType showFlag;
@property (nonatomic,weak) UITextView *myTextView;
@property (nonatomic,copy) void(^textViewDidChangeBlock)(NSString*text);
@property (nonatomic,copy) void(^getRecordData)(NSData *data);
@property (nonatomic,copy) void(^updateFrame)(CGFloat height);
@property (nonatomic,weak) UILabel *placeHolderLabel;

//-(void)updateFrame;
@end

@protocol ToolViewDelegate <NSObject>
@optional
-(void)boardShowWithType:(BoardShowType)type;
-(void)toolViewKeyboardWillShowWithFrame:(CGRect)frame andDelays:(NSTimeInterval)delays;
@end