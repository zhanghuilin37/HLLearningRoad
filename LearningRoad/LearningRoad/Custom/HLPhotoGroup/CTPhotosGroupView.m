//
//  CTPhotosGroupView.m
//  WeiboCellDemo
//
//  Created by CH10 on 16/3/31.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "CTPhotosGroupView.h"
#import "CTPGCollectionViewCell.h"
#import "CTPhotoModel.h"

@interface CTPhotosGroupView ()<UICollectionViewDataSource,UICollectionViewDelegate,CTPGCollectionViewCellDelegate>
@property (nonatomic,weak)UICollectionView *groupCollectionView;
@property (nonatomic,strong)NSMutableArray <CTPhotoModel*> *dataArray;
@property (nonatomic,assign)NSInteger hCount;
@property(nonatomic,assign)NSInteger countMax;
@property(nonatomic,assign)BOOL withAdd;
@property(nonatomic,assign)BOOL withRedBag;
@property(nonatomic,assign)CGFloat PhotosGroupViewWidth1;
@end

@implementation CTPhotosGroupView
-(instancetype)initWithFrame:(CGRect)frame andHCount:(NSInteger)hcount andCountMax:(NSInteger)countMax{
    self = [super initWithFrame:frame];
    if (self) {
        _withAdd = NO;
        _hCount = hcount;
        _countMax = countMax;
        _dataArray = [[NSMutableArray alloc] init];
        self.PhotosGroupViewWidth1 = frame.size.width;
        CGFloat x=0,y=0,w= (self.PhotosGroupViewWidth1-2*EdgeWidthLeft-space*(hcount-1))/hcount,h=(self.PhotosGroupViewWidth1-2*EdgeWidthUp-space*(hcount-1))/hcount;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        [layout setItemSize:CGSizeMake(w, h)];
        layout.minimumLineSpacing = space;
        
        w=frame.size.width-2*EdgeWidthLeft;
        h= frame.size.height-2*EdgeWidthUp;
        UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(x, y, w, h) collectionViewLayout:layout];
        collection.scrollEnabled = NO;
        collection.backgroundColor = [UIColor clearColor];
        collection.delegate = self;
        collection.dataSource = self;
        [collection registerClass:[CTPGCollectionViewCell class] forCellWithReuseIdentifier:@"cellIDs"];
        [self addSubview:collection];
        self.groupCollectionView = collection;
        
    }
    return self;
}
#pragma mark - setter methods
-(void)setDataArrayWithPhotoModelArray:(NSArray<CTPhotoModel *> *)photoModels withAdd:(BOOL)withAdd withRedBag:(BOOL)withRedBag
{
    _withAdd = withAdd;
    _withRedBag = withRedBag;
    if (self.dataArray.count>0) {
        [self.dataArray removeAllObjects];
    }else{
        self.dataArray = [[NSMutableArray alloc] init];
    }
    [self.dataArray addObjectsFromArray:photoModels];
    [self updateDataAndUI];
}
-(void)setDataArrayWithPhotoModelArray:(NSArray<CTPhotoModel *> *)photoModels withAdd:(BOOL)withAdd;
{
    _withAdd = withAdd;
    if (self.dataArray.count>0) {
        [self.dataArray removeAllObjects];
    }else{
        self.dataArray = [[NSMutableArray alloc] init];
    }
    [self.dataArray addObjectsFromArray:photoModels];
    [self updateDataAndUI];
}
-(void)setDataArrayWithImgUrlStrArray:(NSArray<NSString *> *)urlStrs{
    NSMutableArray <CTPhotoModel*>*photoModels = [[NSMutableArray alloc] init];
    for (NSString *urlStr in urlStrs) {
        
        CTPhotoModel *model = [[CTPhotoModel alloc] init];
        model.type = @"0";
        model.thumbnailImgUrl = urlStr;
        model.deleteBtnHidden = YES;
        [photoModels addObject:model];
    }
    [self setDataArrayWithPhotoModelArray:photoModels withAdd:NO];
}
-(void)setDataArrayWithImgArray:(NSArray<UIImage *> *)imgs  withAdd:(BOOL)withAdd{
    _withAdd = withAdd;
    NSMutableArray <CTPhotoModel*>* photoModels = [[NSMutableArray alloc] init];
    for (UIImage *img in imgs) {
        CTPhotoModel *model = [[CTPhotoModel alloc] init];
        model.type = @"1";
        model.thumbnailImage = img;
        model.deleteBtnHidden = YES;
        [photoModels addObject:model];
    }
    [self setDataArrayWithPhotoModelArray:photoModels withAdd:withAdd];
}


#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_withRedBag) {
        return _dataArray.count>_countMax+1?_countMax+1:_dataArray.count;
    }
    return _dataArray.count>_countMax?_countMax:_dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CTPGCollectionViewCell *cell = [CTPGCollectionViewCell PhotoCollectionViewCellWithCollectionView:collectionView IndexPath:indexPath];
    __weak CTPhotosGroupView *this = self;
    
    [cell setDeleteBtnClick:^(NSInteger index) {
        bool flag = NO;
        if (this.withRedBag&&index == 0) {
            flag = YES;
            this.withRedBag = NO;
        }
        if (this.dataArray.count>index) {
            [this.dataArray removeObjectAtIndex:index];
            [this updateDataAndUI];
        }
        
        if ([this.delegate respondsToSelector:@selector(photoGroup:deleteBtnClickedAtIndex: isRedBag:)]) {
            [this.delegate photoGroup:this deleteBtnClickedAtIndex:index isRedBag:flag];
        }
    }];
    if (_dataArray.count) {
        CTPhotoModel *model = [_dataArray objectAtIndex:indexPath.row];
        cell.model = model;
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CTPhotoModel *model = [self.dataArray lastObject];
    CTPhotoModel *tempModel = [self.dataArray objectAtIndex:indexPath.row];
    
    BOOL flag = (indexPath.row == self.dataArray.count-1&&model.isAdd)?YES:NO;
    
    if ([self.delegate respondsToSelector:@selector(photoGroup:photoClickedAtIndex:isAddBtn:isRedBag:)]) {
        [self.delegate photoGroup:self photoClickedAtIndex:indexPath.row isAddBtn:flag isRedBag:tempModel.isRedBag];
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(EdgeWidthUp, 0, EdgeWidthUp, 0);
}
#pragma mark - private methods
-(void)updateDataAndUI{
    CTPhotoModel *lastModel = [self.dataArray lastObject];
    CTPhotoModel *firstModel = [self.dataArray firstObject];
    if (self.dataArray.count==0) {
        if (_withAdd) {
            //            CTPhotoModel *model = [[CTPhotoModel alloc] init];
            //            model.thumbnailImage = [UIImage imageNamed:@"imgGroupAdd"];
            //            model.deleteBtnHidden = YES;
            //            model.type = @"1";
            //            model.isAdd = YES;
            [self.dataArray addObject:[CTPhotoModel getAddModel]];
        }
        if (_withRedBag) {
            //            CTPhotoModel *model = [[CTPhotoModel alloc] init];
            //            model.thumbnailImage = [UIImage imageNamed:@"redbag"];
            //            model.deleteBtnHidden = YES;
            //            model.type = @"1";
            //            model.isAdd = NO;
            //            model.isRedBag = YES;
            [self.dataArray insertObject:[CTPhotoModel getRedBagModel] atIndex:0];
        }
    }else{
        if (lastModel.isAdd == NO&&_withAdd) {
            //            CTPhotoModel *model = [[CTPhotoModel alloc] init];
            //            model.thumbnailImage = [UIImage imageNamed:@"imgGroupAdd"];
            //            model.deleteBtnHidden = YES;
            //            model.type = @"1";
            //            model.isAdd = YES;
            [self.dataArray addObject:[CTPhotoModel getAddModel]];
        }
        if (firstModel.isRedBag == NO&&_withRedBag) {
            //            CTPhotoModel *model = [[CTPhotoModel alloc] init];
            //            model.thumbnailImage = [UIImage imageNamed:@"redbag"];
            //            model.deleteBtnHidden = YES;
            //            model.type = @"1";
            //            model.isAdd = NO;
            //            model.isRedBag = YES;
            [self.dataArray insertObject:[CTPhotoModel getRedBagModel] atIndex:0];
        }
    }
    [self updateFrame];
    [self.groupCollectionView reloadData];
}
-(void)updateFrame{
    
    
    NSInteger realCount = self.dataArray.count>self.countMax?self.countMax:self.dataArray.count;
    NSInteger hang      = realCount/self.hCount;
    NSInteger lie       = realCount%self.hCount;
    CGFloat itemWidth   = (self.PhotosGroupViewWidth1-2*EdgeWidthLeft-space*(self.hCount-1))/self.hCount;
    CGRect frame        = self.frame;
    CGFloat h,w;
    if (hang>0) {
        if (lie>0) {
            hang+=1;
        }
        w = self.PhotosGroupViewWidth1;
        h = itemWidth*hang+space*(hang-1)+2*EdgeWidthUp;
        frame.size.width  = w;
        frame.size.height = h;
    }else{
        if (lie == 0) {
            frame.size.height = 0;
        }else{
            w = itemWidth*lie+space*(lie-1)+2*EdgeWidthLeft;
            h = itemWidth+2*EdgeWidthUp;
            frame.size.width  = w;
            frame.size.height = h;
        }
    }
    
    //    CGSize size = [CTPhotosGroupView updateFrameCountMax:self.countMax count:self.dataArray.count hCount:self.hCount];
    self.frame = frame;
    self.groupCollectionView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}
-(NSArray<CTPhotoModel *> *)getPhotoModelArray{
    NSMutableArray *resultArr = [[NSMutableArray alloc] init];
    if (self.withAdd) {
        CTPhotoModel *lastModel = [self.dataArray lastObject];
        NSInteger count = self.dataArray.count;
        if (lastModel.isAdd == YES) {
            count = self.dataArray.count - 1;
        }
        
        
        for (int i = 0; i<count; i++) {
            CTPhotoModel *model = [self.dataArray objectAtIndex:i];
            [resultArr addObject:model];
        }
    }else{
        CTPhotoModel *firstModel = [self.dataArray firstObject];
        NSInteger count = self.dataArray.count;
        NSMutableArray *tempArr = [[NSMutableArray alloc] initWithArray:self.dataArray];
        if (firstModel.isRedBag == YES) {
            [tempArr removeObjectAtIndex:0];
            count = self.dataArray.count - 1;
        }
        
        
        for (int i = 0; i<count; i++) {
            CTPhotoModel *model = [tempArr objectAtIndex:i];
            [resultArr addObject:model];
        }
    }
    
    return resultArr;
}
/**
 *  获取自身size(有红包)
 */
+(CGSize)updateFrameCountMax:(NSInteger)countMax count:(NSInteger)count hCount:(NSInteger)hCount withWidth:(CGFloat)width withRedBag:(BOOL)withRedBag{
    if (withRedBag) {
        count++;
        countMax++;
    }
    if (count<countMax&&count!=0) {
        count++;
    }
    CGSize size = [CTPhotosGroupView updateFrameCountMax:countMax count:count hCount:hCount withWidth:width];
    return size;
}
/**
 *  获取自身size
 */
+(CGSize)updateFrameCountMax:(NSInteger)countMax count:(NSInteger)count hCount:(NSInteger)hCount withWidth:(CGFloat)width{
    NSInteger realCount = count>countMax?countMax:count;
    NSInteger hang      = realCount/hCount;
    NSInteger lie       = realCount%hCount;
    CGFloat itemWidth   = (width-2*EdgeWidthLeft-space*(hCount-1))/hCount;
    CGRect frame        = CGRectMake(0, 0, 0, 0);
    CGFloat h,w;
    if (hang>0) {
        if (lie>0) {
            hang+=1;
        }
        w = width;
        h = itemWidth*hang+space*(hang-1)+2*EdgeWidthUp;
        frame.size.width  = w;
        frame.size.height = h;
    }else{
        if (lie == 0) {
            frame.size.height = 0;
        }else{
            w = itemWidth*lie+space*(lie-1)+2*EdgeWidthLeft;
            h = itemWidth+2*EdgeWidthUp;
            frame.size.width  = w;
            frame.size.height = h;
        }
    }
    return CGSizeMake(frame.size.width, frame.size.height);
}

@end
