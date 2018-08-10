//
//  UserModel.m
//  demo
//
//  Created by Zhl on 16/10/11.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        _user = [[User alloc] init];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {

    //        [aCoder encodeObject:self.user.uid forKey:@"uid"];
    [aCoder encodeObject:self.user.userName forKey:@"userName"];
    [aCoder encodeObject:self.user.password forKey:@"password"];
    [aCoder encodeBool:self.isLogin forKey:@"isLogin"];
    [aCoder encodeBool:self.isGestureLock forKey:@"isGestureLock"];
    [aCoder encodeObject:self.gesturePsword forKey:@"gesturePsword"];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.user = [[User alloc] init];

        self.user.userName = [aDecoder decodeObjectForKey:@"userName"];
        
        self.user.password = [aDecoder decodeObjectForKey:@"password"];
        
        self.isLogin = [aDecoder decodeBoolForKey:@"isLogin"];
        self.isGestureLock = [aDecoder decodeBoolForKey:@"isGestureLock"];
        self.gesturePsword = [aDecoder decodeObjectForKey:@"gesturePsword"];
    }
    return self;
}

@end
