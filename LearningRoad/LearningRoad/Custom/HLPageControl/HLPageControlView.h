//
//  HLPageControlView.h
//  Quartz2d
//
//  Created by CH10 on 15/11/9.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLPageControlView : UIView
/**总页数*/
@property(nonatomic) NSInteger numberOfPages;
/**当前页*/
@property(nonatomic,assign) NSInteger currentPage;
/**
 *@pageNum：总页数
 *@currentPage:当前页
 *@currentImgName:当前页图片名
 *@bgImgName:背景页图片名
 */
- (instancetype)initWithFrame:(CGRect)frame andPageNum:(NSInteger)pageNum andCurrentPage:(NSInteger)currentPage andCurrentImg:(NSString *)currentImgName andBgImg:(NSString *)bgImgName;
@end
