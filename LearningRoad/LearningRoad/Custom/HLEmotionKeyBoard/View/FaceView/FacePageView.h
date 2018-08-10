//
//  FacePageView.h
//  demo
//
//  Created by Zhl on 16/9/26.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  单页表情
 */
@interface FacePageView : UIView
@property(nonatomic,strong)NSMutableArray  *facePageArr;
@property(nonatomic,copy)void(^faceDic)(NSDictionary *faceDic);
@property(nonatomic,copy)void(^faceDeleteClick)();
//-(instancetype)initWithFrame:(CGRect)frame Page:(NSInteger)page;
-(instancetype)initWithFrame:(CGRect)frame FaceImgArray:(NSArray*)faceImgArray;

@end
