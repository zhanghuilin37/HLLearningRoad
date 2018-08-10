//
//  BaseData.h
//  demo
//
//  Created by Zhl on 16/8/31.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseData : NSObject
/** field 错误编号*/
@property(nonatomic,assign)NSInteger errCode;
/**
 *  字符串JSON解析
 *
 *  @param str 服务器返回的JSON字符串
 */
-(void)decode:(NSString*)str;
/**
 *  模型中如果有数组类型的字段解析时调用，如果有数组类型的字段，需要在子类中重写这个方法
 *
 *  @param arr 存有子数据的数组
 *  @param name 字段名称
 */
-(void)decodeWithSubArray:(NSArray*)arr withPropertyName:(NSString*)name;

-(NSMutableDictionary*) getYxbDic;
@end
