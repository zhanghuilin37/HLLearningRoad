//
//  EditingTableViewCell.h
//  HandicapWin
//
//  Created by CH10 on 16/4/26.
//  Copyright © 2016年 赢盘. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTPhotosGroupView.h"
#import "BBSProtocols.h"
#import "YYText.h"
#define kanqiuIdentify @"kanqiu"
#define imgIdentify @"imgsIdentify"

@interface EditingTableViewCell : UITableViewCell<PhotoCollectionViewCellDelegate>
@property(nonatomic,assign)id<PhotoCollectionViewCellDelegate> delegate;
@property(nonatomic,assign)id<CTPhotoGroupViewDelegate> ctPGViewDelegate;
@property(nonatomic,strong)NSMutableArray *imgArray;
@property(nonatomic,strong)NSMutableArray *imgModelArray;
+(instancetype)EditingTableViewCellWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath;
-(void)setImgModelArray:(NSMutableArray *)imgModelArray hasRedBag:(BOOL)hasRedBag;



@end
