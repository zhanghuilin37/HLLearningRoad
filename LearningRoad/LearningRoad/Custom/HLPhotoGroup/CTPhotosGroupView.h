//
//  CTPhotosGroupView.h
//  WeiboCellDemo
//
//  Created by CH10 on 16/3/31.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTPhotoModel.h"
//间隔
#define space 10
//九宫格整体宽度
#define PhotosGroupViewWidth ([UIScreen mainScreen].bounds.size.width-67)
//边界宽度
#define EdgeWidthUp 5
#define EdgeWidthLeft 0
#define MaxPicCount 9
#define MaxPicHangCount 3
@protocol CTPhotoGroupViewDelegate;

/** 图片九宫格排列 */
@interface CTPhotosGroupView : UIView
@property(nonatomic,assign)id<CTPhotoGroupViewDelegate> delegate;

/**
 * hcount:横向的item最大个数
 * countMax:item总数的最大值
 */
-(instancetype)initWithFrame:(CGRect)frame andHCount:(NSInteger)hcount andCountMax:(NSInteger)countMax;

//-(void)setDataArrayWithPhotoModelArray:(NSArray<CTPhotoModel *> *)photoModels withAdd:(BOOL)withAdd;

-(void)setDataArrayWithPhotoModelArray:(NSArray<CTPhotoModel *> *)photoModels withAdd:(BOOL)withAdd withRedBag:(BOOL)withRedBag;

//-(void)setDataArrayWithImgArray:(NSArray<UIImage*>*)imgs withAdd:(BOOL)withAdd;

-(void)setDataArrayWithImgUrlStrArray:(NSArray<NSString *> *)urlStrs;

-(NSArray<CTPhotoModel*>*)getPhotoModelArray;
//获取自身size
+(CGSize)updateFrameCountMax:(NSInteger)countMax count:(NSInteger)count hCount:(NSInteger)hCount withWidth:(CGFloat)width;

//获取自身size（有红包和Add）
+(CGSize)updateFrameCountMax:(NSInteger)countMax count:(NSInteger)count hCount:(NSInteger)hCount withWidth:(CGFloat)width withRedBag:(BOOL)withRedBag;
@end

@protocol CTPhotoGroupViewDelegate <NSObject>
@optional
-(void)photoGroup:(CTPhotosGroupView*)groupView photoClickedAtIndex:(NSInteger)index isAddBtn:(BOOL)flag isRedBag:(BOOL)isRedBag;
-(void)photoGroup:(CTPhotosGroupView*)groupView deleteBtnClickedAtIndex:(NSInteger)index isRedBag:(BOOL)isRedBag;
@end
