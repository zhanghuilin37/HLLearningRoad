//
//  CTEmotionKeyBoard.h
//  demo
//
//  Created by Zhl on 16/9/26.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//
/**
 *  键盘所在视图控制器消失前最好调用-(void)removeControlFromWindow;方法
 *
 *  避免control延迟移除
 *
 *
 */
#import <UIKit/UIKit.h>
#import "AddView.h"
#import "ToolView.h"
#define EmotionHeight (([UIScreen mainScreen].bounds.size.width/7.0*3.0+20+40)+40)
#define ContentViewHeight ([UIScreen mainScreen].bounds.size.width/7.0*3.0+20+40)
#define ToolViewHeith 40

@protocol CTEmotionKeyBoardDelegate;
/**
 *  表情+add+文字 键盘
 */
@interface CTEmotionKeyBoard : UIView
@property (nonatomic,assign)id<CTEmotionKeyBoardDelegate>delegate;
@property (nonatomic,copy)NSString *placeHolder;
-(void)removeRecordData;
-(void)removeControlFromWindow;
-(void)showWithType:(BoardShowType)type;
-(void)moveToBottom;
@end

@protocol CTEmotionKeyBoardDelegate <NSObject>
@optional
/**
 *  获取文本
 *
 *  param emotionKeyboard
 *  param text            文本
 */
-(void)emotionKeyBoard:(CTEmotionKeyBoard*)emotionKeyboard textDidChanged:(NSString*)text;
/**
 *  获取录音文件
 *
 *  param emotionKeyboard
 *  param recordData      录音文件 （NSdata类型）
 */
-(void)emotionKeyBoard:(CTEmotionKeyBoard*)emotionKeyboard RecordHasEnd:(NSData*)recordData;
/**
 *  获取录音文件
 *
 *  param emotionKeyboard
 *  param recordData      录音文件 （NSdata类型）
 */
-(void)emotionKeyBoard:(CTEmotionKeyBoard*)emotionKeyboard addViewClicked:(AddViewBtnTag)btnTag;
-(void)emotionKeyBoard:(CTEmotionKeyBoard *)emotionKeyboard addViewDidSelectedPics:(NSArray<UIImage*>*)pics;
@end
