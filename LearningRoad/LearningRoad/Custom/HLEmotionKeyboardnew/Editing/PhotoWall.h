//
//  PhotoWall.h
//  HandicapWin
//
//  Created by CH10 on 16/5/9.
//  Copyright © 2016年 赢盘. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTPhotoModel.h"
@interface PhotoWall : UIView

+(void)photoWallShowWithImgModelDataArr:(NSArray<CTPhotoModel*>*)dataArr Index:(NSInteger)index;
+(void)photoWallShowWithImgDataArr:(NSArray<UIImage *> *)dataArr Index:(NSInteger)index;
@end
