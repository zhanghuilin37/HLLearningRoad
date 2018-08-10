//
//  HLScreenCutBtn.h
//  Quartz2d
//
//  Created by CH10 on 15/11/9.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@protocol HLScreenCutBtnDelegate <NSObject>

-(void)saveImageSuccess;

@end


@interface HLScreenCutBtn : UIButton
@property(nonatomic,assign)id<HLScreenCutBtnDelegate>delegate;
@property (nonatomic,assign) CGFloat offsetY;
+(HLScreenCutBtn *)shareZHLScreenCutBtn;
@end
