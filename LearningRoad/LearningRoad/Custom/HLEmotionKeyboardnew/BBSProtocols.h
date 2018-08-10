//
//  BBSProtocols.h
//  HandicapWin
//
//  Created by CH10 on 16/4/25.
//  Copyright © 2016年 赢盘. All rights reserved.
//

#ifndef BBSProtocols_h
#define BBSProtocols_h


@protocol BBSIconDelegate <NSObject>

@optional
-(void)iconClickedWithUserID:(NSString*)userID;

@end

@protocol BBSTopicHeaderViewDelegate <NSObject>

-(void)BBSDetailHeaderView:(UIView*)headerView;

@end

@protocol PhotoCollectionViewCellDelegate <NSObject>
@optional
-(void)photoDeleteClick:(UIButton*)btn;
-(void)photoClicked:(NSInteger)index;
//-(void)kanQiuClicked;
@end
#endif /* BBSProtocols_h */
