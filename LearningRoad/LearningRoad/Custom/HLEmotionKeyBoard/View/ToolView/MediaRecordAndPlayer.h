//
//  MediaRecordAndPlayer.h
//  demo
//
//  Created by Zhl on 16/9/30.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
@interface MediaRecordAndPlayer : NSObject
+(instancetype)shareInstance;
-(void)begainRecord;
-(NSData*)getRecordData;
-(void)removeVoice;
@end
