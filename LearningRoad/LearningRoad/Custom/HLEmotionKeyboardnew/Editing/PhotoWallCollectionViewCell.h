//
//  PhotoWallCollectionViewCell.h
//  HandicapWin
//
//  Created by CH10 on 16/5/9.
//  Copyright © 2016年 赢盘. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTPhotoModel.h"
@interface PhotoWallCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)CTPhotoModel *model;
@property(nonatomic,strong)UIImage *img;
@end
