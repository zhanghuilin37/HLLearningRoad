//
//  ReadLocalData.m
//  LotteryApp
//
//  Created by Feili on 13-9-4.
//  Copyright (c) 2013年 windo. All rights reserved.
//

#import "ReadLocalData.h"

static ReadLocalData *instance;

@implementation ReadLocalData

+ (ReadLocalData *)defaultReadLocalData
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ReadLocalData alloc] init];
    });
    
    return instance;
}

- (NSArray *)getFaceImgArray
{
    static NSArray *faceImgArray;
    
    if (nil == faceImgArray) {
        //读取表情字典
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"faceInfo" ofType:@"plist"];
        NSDictionary *faceDictionary = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        
        faceImgArray = [faceDictionary objectForKey:@"emoticon_group_emoticons"];
    }
    
    return faceImgArray;
}
-(NSArray*)getGroupedFaceImgArray{
    static NSArray *groupedFaceImgArr;
    if (groupedFaceImgArr == nil) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"EmotionGroups" ofType:@"plist"];
        groupedFaceImgArr = [NSArray arrayWithContentsOfFile:plistPath];
    }
    return groupedFaceImgArr;
}
- (NSDictionary *)getFaceStrDict
{
    static NSDictionary *faceStrDict;
    if (nil == faceStrDict) {
        //读取解析表情的字典
        NSString *jieXiplistPath = [[NSBundle mainBundle] pathForResource:@"jieXiFaceInfo" ofType:@"plist"];
        
        faceStrDict = [[NSDictionary alloc] initWithContentsOfFile:jieXiplistPath];
    }
    return faceStrDict;
}

@end
