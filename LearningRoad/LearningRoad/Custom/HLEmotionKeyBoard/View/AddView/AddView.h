//
//  AddView.h
//  demo
//
//  Created by Zhl on 16/9/26.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    AddViewBtnTagPhoto = 0,
    AddViewBtnTagTakePic,
    AddViewBtnTagSmallVideo,
    AddViewBtnTagAudioChat,
    AddViewBtnTagRedbag,
    AddViewBtnTagPersonCards,
    AddViewBtnTagLocation,
    AddViewBtnTagCollect
}AddViewBtnTag;

/**
 * addView 
 */
@interface AddView : UIView
/**
 *  addView按钮点击第几个
 */
@property (nonatomic,copy)void(^AddViewBtnClicked)(AddViewBtnTag btnTag);
@end
