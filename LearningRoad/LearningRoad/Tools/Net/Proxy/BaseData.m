//
//  BaseData.m
//  demo
//
//  Created by Zhl on 16/8/31.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import "BaseData.h"
#import <objc/runtime.h>

@interface BaseData ()
/**
 *  字典转模型
 *
 *  @param dic json解析获得的字典
 */
-(void)decodeWithDic:(NSDictionary*)dic;
@end

@implementation BaseData
-(void)decode:(NSString *)str{
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
    NSLog(@"dict == %@",dic);
    [self decodeWithDic:dic];
}
//字典转模型
-(void)decodeWithDic:(NSDictionary *)dic{
    unsigned int propsCount;
    NSObject *obj = [[[self class] alloc] init];
    while (obj) {
        objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
        for (int i = 0; i < propsCount; i++) {
            objc_property_t prop = props[i];
            id value = nil;
            @try {
                NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
                value = [dic objectForKey:propName];
                if (value != nil) {
                    if ([value isKindOfClass:[NSArray class]]) {
                        NSArray *arrValue = (NSArray*)value;
                        [self decodeWithSubArray:arrValue withPropertyName:propName];
                    }else{
                        [self setValue:value forKey:propName];
                    }
                }
            }
            @catch (NSException *exception) {
                
            }
            obj = [[obj.superclass alloc] init];
        }
    }
}
-(void)decodeWithSubArray:(NSArray *)arr withPropertyName:(NSString *)name{
}
//模型转字典
-(NSMutableDictionary*) getYxbDic {
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
    //    [dic setObject:@"aaa" forKey:@"key"];
    
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([self class], &propsCount);
    for(int i = 0;i < propsCount; i++) {
        objc_property_t prop = props[i];
        id value = nil;
        
        @try {
            NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
            //                        NSLog(@"propName %@",propName);
            value = [self valueForKey:propName];
            //            Class subClass = [value class];
            //            NSString* tmp = NSStringFromClass(subClass);
            //            NSLog(@"tmp class name  = %@", tmp);
            if(value != nil) {
                
                if ([value isKindOfClass:[NSArray class]]) {
                    //                    NSArray* arr = (NSArray*) value;
                    //                    if (arr != nil && [arr count] > 0) {
                    //                        NSObject* objArr = arr[0];
                    //                        Class subClass = [objArr class];
                    //                        NSString* tmpClassName = NSStringFromClass(subClass);
                    //                        NSLog(@"tmpClassName = %@", tmpClassName);
                    //                    }
                }
                else {
                    [dic setObject:value forKey:propName];
                }
                
            }
        }
        @catch (NSException *exception) {
            //[self logError:exception];
        }
        
    }
    
    return dic;
}
@end
