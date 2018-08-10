//
//  PhotosGroupView.m
//  WeiboCellDemo
//
//  Created by CH10 on 16/3/31.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "PhotosGroupView.h"
#import "PhotoWall.h"
#import <UIImageView+WebCache.h>
@interface PhotosGroupView ()<UICollectionViewDataSource,UICollectionViewDelegate,PhotoCollectionViewCellDelegate>
@property (nonatomic,weak)UICollectionView *groupCollectionView;
@property (nonatomic,assign)NSInteger hCount;
@property(nonatomic,assign)NSInteger countMax;
@end

@implementation PhotosGroupView
-(void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    [self.groupCollectionView reloadData];
}
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.groupCollectionView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
}
-(instancetype)initWithFrame:(CGRect)frame andHCount:(NSInteger)hcount andCountMax:(NSInteger)countMax{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor grayColor];
        _switchPhotoWall = NO;
        _hCount = hcount;
        _countMax = countMax;
        _dataArray = [[NSMutableArray alloc] init];
        CGFloat x=0,y=0,w= (frame.size.width-10*(hcount-1))/hcount,h=(frame.size.width-10*(hcount-1))/hcount;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        [layout setItemSize:CGSizeMake(w, h)];
        w=frame.size.width;h= frame.size.height-k_NavBar_H;
        UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(x, y, w, h) collectionViewLayout:layout];
        collection.scrollEnabled = NO;
        collection.backgroundColor = [UIColor clearColor];
        collection.delegate = self;
        collection.dataSource = self;
        [collection registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"cellIDs"];
        [self addSubview:collection];
        self.groupCollectionView = collection;
        
    }
    return self;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count>_countMax?_countMax:_dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCollectionViewCell *cell = [PhotoCollectionViewCell PhotoCollectionViewCellWithCollectionView:collectionView IndexPath:indexPath];
    cell.delegate = self;
    if (_dataArray.count) {
        CTPhotoModel *model = [_dataArray objectAtIndex:indexPath.row];
        cell.model = model;
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type==PhotosGroupViewTypeBBSImg) {
        CTPhotoModel *imgModel = nil;
        if (_dataArray.count) {
            imgModel = [_dataArray objectAtIndex:indexPath.row];
        }
        if (_switchPhotoWall) {
            [PhotoWall photoWallShowWithImgModelDataArr:_dataArray Index:indexPath.row];
        }

    }else{
        if ([self.delegate respondsToSelector:@selector(photoClicked:)]) {
            [self.delegate photoClicked:indexPath.row];
        }
    }
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 0, 15, 0);
}
-(void)photoDeleteClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(photoDeleteClick:)]) {
        [self.delegate photoDeleteClick:btn];
    }
}


@end
@implementation PhotoCollectionViewCell
-(void)setModel:(CTPhotoModel *)model{
    _model = model;
    if (_model) {
        if ([_model.type isEqualToString:@"0"]) {
            NSString *url = nil;
            if (![model.thumbnailImgUrl hasPrefix:@"http"]) {
//                url = [NSString stringWithFormat:@"%@%@",HW_IP_ADRESS,model.thumbnailImgUrl];
                url = [NSString stringWithFormat:@"%@%@",@"",model.thumbnailImgUrl];
            }else{
                url = model.thumbnailImgUrl;
            }
            
            [_imgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"BBSDefaultImg"]];
            
        }else if ([_model.type isEqualToString:@"1"]){
            _imgView.image = _model.thumbnailImage;
        }
        _deleteBtn.hidden = _model.deleteBtnHidden;
    }
}

+(instancetype)PhotoCollectionViewCellWithCollectionView:(UICollectionView*)collectionView IndexPath:(NSIndexPath*)indexPath{
    static NSString*cellName = @"cellIDs";
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellName forIndexPath:indexPath];
    cell.deleteBtn.tag = indexPath.row;
    return cell;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderColor = rgb(220, 221, 221, 1).CGColor;
        self.layer.borderWidth = 0.5;
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        imgView.userInteractionEnabled = YES;
        _imgView = imgView;
        
        [self.contentView addSubview:imgView];
        CGFloat x = imgView.width-17.5,y=0,w=17.5,h=17.5;
        UIImage *img = [UIImage imageNamed:@"picDelete"];
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteBtn.frame = CGRectMake(x, y, w, h);
        [deleteBtn setBackgroundImage:img forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [imgView addSubview:deleteBtn];
        self.deleteBtn = deleteBtn;
    }
    return self;
}
-(void)deleteBtnClick:(UIButton*)btn{
    if ([self.delegate respondsToSelector:@selector(photoDeleteClick:)]) {
        [self.delegate photoDeleteClick:btn];
    }
}
@end
