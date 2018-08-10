//
//  CustomProgressView.h
//  CustomProgressTest
//
//  Created by CH10 on 15/11/18.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLProgressView : UIView
@property(nonatomic,assign)CGFloat progress;
/**底色*/
@property(nonatomic,strong)UIColor *trackColor;
/**进度颜色*/
@property(nonatomic,strong)UIColor *progressColor;

-(void)setProgress:(CGFloat)progress andAinmated:(BOOL)animated;
@end
