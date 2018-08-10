//
//  CTPGCollectionViewCell.h
//  WeiboCellDemo
//
//  Created by CH10 on 16/4/1.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTPhotoModel.h"


@protocol CTPGCollectionViewCellDelegate <NSObject>
@optional
-(void)photoDeleteClick:(UIButton*)btn;
@end

@interface CTPGCollectionViewCell : UICollectionViewCell
@property (nonatomic,assign)id<CTPGCollectionViewCellDelegate>delegate;
@property (nonatomic,strong)CTPhotoModel *model;
@property (nonatomic,weak)UIImageView *imgView;
@property (nonatomic,weak)UIButton *deleteBtn;
@property (nonatomic,copy)void(^deleteBtnClick)(NSInteger index);
+(instancetype)PhotoCollectionViewCellWithCollectionView:(UICollectionView*)collectionView IndexPath:(NSIndexPath*)indexPath;
@end
