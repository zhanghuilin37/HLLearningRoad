//
//  FacePageView.h
//  LotteryApp
//
//  Created by Feili on 13-9-4.
//  Copyright (c) 2013年 windo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FaceViewDelegate;

@interface FacePageView : UIView {
    NSInteger _curPage;     //记录当前是几页
}
@property (nonatomic,assign) id<FaceViewDelegate> delegate;

@property (nonatomic, strong, readonly) NSArray       *faceImgArray;
@property (nonatomic,strong) NSMutableArray *imgsArr;
@property (nonatomic, strong, readonly) NSDictionary  *faceStrDict;
-(id)initWithFrame:(CGRect)frame withPage:(NSInteger)page;

-(void)addFaceToViewWithPage:(NSInteger)page;
//加载当前页的表情图（如果该表情异步存入到数组则直接加载，如果没有则创建img后再加载）
-(void)setImgsWithPage:(NSInteger)page;

@end

@protocol FaceViewDelegate <NSObject>
@optional
- (void)controlScroll:(NSInteger)curIndex;   //1是滑动  2是不滑动
- (void)faceSelectedName:(NSString *)nameStr;
- (void)faceDeleteClick;

@end
