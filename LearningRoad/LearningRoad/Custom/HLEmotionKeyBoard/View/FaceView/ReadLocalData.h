//
//  ReadLocalData.h
//  LotteryApp
//
//  Created by Feili on 13-9-4.
//  Copyright (c) 2013年 windo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadLocalData : NSObject

+ (ReadLocalData *)defaultReadLocalData;

- (NSArray *)getFaceImgArray;
- (NSArray *)getGroupedFaceImgArray;
- (NSDictionary *)getFaceStrDict;

@end
