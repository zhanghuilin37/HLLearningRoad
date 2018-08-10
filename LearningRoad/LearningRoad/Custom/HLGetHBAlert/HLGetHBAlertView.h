//
//  HLGetHBAlertView.h
//  demo
//
//  Created by Zhl on 16/10/27.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HLGetHBAlertViewDelegate;
@interface HLGetHBAlertView : UIView
@property(nonatomic,assign)id<HLGetHBAlertViewDelegate> delegate;
+(instancetype)hlGetHBAlertViewWithDelegate:(id<HLGetHBAlertViewDelegate>)delegate;
-(void)hlGetHBAlertViewShowWithType:(NSString *)type inView:(UIView *)view;
-(void)hlGetHBAlertViewShowInWindowWithType:(NSString *)type;
-(void)hlGetHBAlertViewHidden;
@end
@protocol HLGetHBAlertViewDelegate <NSObject>
@optional
-(void)hlGetHBAlertViewPushToNextVC;
-(void)hlGetHBAlertViewOpenBtnClicked;
-(void)hlGetHBAlertViewSeeLuckyBtnClicked;
@end
