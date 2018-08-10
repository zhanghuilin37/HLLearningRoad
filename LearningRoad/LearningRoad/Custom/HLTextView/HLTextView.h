//
//  HLTextView.h
//  demo
//
//  Created by Zhl on 16/11/18.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HLTextViewAlignmentUP
}HLTextViewAlignment;

@protocol HLTextViewDelegate;
@interface HLTextView : UITextView
@property (nonatomic,assign)id<HLTextViewDelegate> hlTextViewDelegate;
@property (nonatomic,copy)NSString *placeHolder;
@property (nonatomic,strong)UIColor *placeHolderColor;
@property (nonatomic,strong)UIFont *placeHolderFont;
@property (nonatomic,assign)NSTextAlignment placeHolderAligment;
/**
 *  创建 键盘自带确定按钮的 textView
 */
- (instancetype)initWithFrame:(CGRect)frame HasToolBar:(BOOL)hasToolBar;

/**
 *  字数统计
 */
+ (NSInteger)getWordNumber:(UITextView*)textView;

@end
@protocol HLTextViewDelegate <UITextViewDelegate>
@optional
/**
 *  键盘删除键被点击
 */
-(void)hlTextViewDeleteBackward:(HLTextView *)textView;

@end
