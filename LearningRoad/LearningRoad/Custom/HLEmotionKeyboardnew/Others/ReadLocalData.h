//
//  ReadLocalData.h
//  LotteryApp
//
//  Created by Feili on 13-9-4.
//  Copyright (c) 2013年 windo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadLocalData : NSObject
@property (nonatomic,strong) NSMutableArray *imgsArr;
+ (ReadLocalData *)defaultReadLocalData;
//获取faceInfo.plist中的 emoticon_group_emoticons 数组
- (NSArray *)getFaceImgArray;
//获取字符串对应的图片字典 （jieXiFaceInfo.plist中的根字典）
- (NSDictionary *)getFaceStrDict;
//异步读取图片并存储
- (void)initImgsArr;
//获取已经存储的图片
- (NSArray *)getImgsArray;
@end
