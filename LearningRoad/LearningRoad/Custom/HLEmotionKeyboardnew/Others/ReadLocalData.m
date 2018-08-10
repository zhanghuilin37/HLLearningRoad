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
        instance.imgsArr = [[NSMutableArray alloc] init];
    });
    
    return instance;
}
-(void)initImgsArr{
    __block ReadLocalData *this = self;
    dispatch_async(dispatch_queue_create(0, 0), ^{
        for (NSDictionary *curDict in [this getFaceImgArray]) {
            UIImage *img = [UIImage imageNamed:[curDict objectForKey:@"png"]];
            [this.imgsArr addObject:img];
        }
    });
}
- (NSArray *)getImgsArray{
    return instance.imgsArr;
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
