//
//  UserManager.m
//  demo
//
//  Created by Zhl on 16/10/9.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import "UserManager.h"

@interface UserManager ()
@property(nonatomic,strong)dispatch_queue_t persistanceQueue;
@end
@implementation UserManager
+(instancetype)sharedInstance{
        static UserManager *_s;
        
        if (_s == nil) {
            _s = [[[self class] alloc]init];
            if (_s.persistanceQueue == nil) {
                _s.persistanceQueue = dispatch_queue_create("com.myApp.savingQueue", NULL);
            }
        }
        return _s;
}
-(void)setLoginUser:(UserModel *)user{
    _currUser = user;
    //保存到本地
    dispatch_sync(self.persistanceQueue, ^(void) {
        
        [self saveToLocal];
        
    });
}
-(UserModel *)getLoginUser{
    if (_currUser == Nil) {
        _currUser = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getCurrUserFiler]];
        if (_currUser == nil) {
            _currUser = [[UserModel alloc] init];
            
        }
    }
    return _currUser;
}
#pragma mark - private methods
-(void)saveToLocal{
    @synchronized(self) {
        NSString * filer = [self getCurrUserFiler];

        BOOL success = [NSKeyedArchiver archiveRootObject:_currUser toFile:filer];
        if (!success)
        {
            // we lost some data :(
            NSLog(@"保存失败： %@", filer);
        }else{
            NSLog(@"保存成功");
        }
    }
}
- (NSString *)getCurrUserFiler
{
    NSLog(@"%@",[NSString stringWithFormat:@"%@/%@", NSHomeDirectory(),
                 @"Library/Caches/CurrUser"]);
    return [NSString stringWithFormat:@"%@/%@", NSHomeDirectory(),
            @"Library/Caches/CurrUserHWNew"];
}

@end
