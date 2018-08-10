//
//  UserManager.h
//  demo
//
//  Created by Zhl on 16/10/9.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface UserManager : NSObject
{
    UserModel *_currUser;
}


+(instancetype)sharedInstance;
-(void)setLoginUser:(UserModel*)user;
-(UserModel*)getLoginUser;

@end
