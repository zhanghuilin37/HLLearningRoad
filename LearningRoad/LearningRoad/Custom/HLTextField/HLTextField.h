//
//  HLTextField.h
//  demo
//
//  Created by Zhl on 16/11/18.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HLTextFieldDelegate;

@interface HLTextField : UITextField

@property(nonatomic,assign)id<HLTextFieldDelegate> hlTextFieldDelete;
-(instancetype)initWithFrame:(CGRect)frame hasToolBar:(BOOL)hasToolBar hasDelete:(BOOL)hasDeleteBtn;
+(NSInteger)getWordNumber:(UITextField*)textField;
@end


@protocol HLTextFieldDelegate <UITextFieldDelegate>
@optional
-(void)hlTextFieldDeleteBackward:(HLTextField *)textField;

@end
