//
//  PhotosGroupView.h
//  WeiboCellDemo
//
//  Created by CH10 on 16/3/31.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//
/**
 图片九宫格排列
 */
#import <UIKit/UIKit.h>
#import "BBSProtocols.h"
#import "CTPhotoModel.h"
typedef enum {
    PhotosGroupViewTypeBBSImg = 0,
    PhotosGroupViewTypePhotoPickImg
}PhotosGroupViewType;

@interface PhotosGroupView : UIView
@property(nonatomic,assign)id<PhotoCollectionViewCellDelegate> delegate;

@property (nonatomic,strong)NSMutableArray *dataArray;
/**是否需要点击图片预览*/
@property (nonatomic,assign)BOOL switchPhotoWall;

@property (nonatomic,assign)PhotosGroupViewType type;
/**
 *hcount:横向的item个数
 *countMax:item总数
 */
-(instancetype)initWithFrame:(CGRect)frame andHCount:(NSInteger)hcount andCountMax:(NSInteger)countMax;
@end

@interface PhotoCollectionViewCell : UICollectionViewCell
@property (nonatomic,assign)id<PhotoCollectionViewCellDelegate>delegate;
@property (nonatomic,strong)CTPhotoModel *model;
@property (nonatomic,weak)UIImageView *imgView;
@property (nonatomic,weak)UIButton *deleteBtn;
+(instancetype)PhotoCollectionViewCellWithCollectionView:(UICollectionView*)collectionView IndexPath:(NSIndexPath*)indexPath;
@end
