//
//  UserModel.h
//  demo
//
//  Created by Zhl on 16/10/11.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface UserModel : NSObject
@property (nonatomic,strong) User *user;
@property (nonatomic,assign) BOOL isLogin;
@property (nonatomic,assign) BOOL isGestureLock;
@property (nonatomic,copy) NSString *gesturePsword;
@end
