//
//  BBSFModel.h
//  LearningRoad
//
//  Created by Zhl on 16/6/28.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBSLetterTool.h"
@interface BBSFModel : NSObject
@property (nonatomic,copy)NSString *text;
@property (nonatomic)NSAttributedString *attText;
@property (nonatomic)CGRect letterLF;
@property (nonatomic,assign)CGFloat cellHeight;
@end
