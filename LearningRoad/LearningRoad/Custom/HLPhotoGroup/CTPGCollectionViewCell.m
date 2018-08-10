//
//  CTPGCollectionViewCell.m
//  WeiboCellDemo
//
//  Created by CH10 on 16/4/1.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "CTPGCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@interface CTPGCollectionViewCell ()
@end

@implementation CTPGCollectionViewCell
-(void)setModel:(CTPhotoModel *)model{
    _model = model;
    if (_model) {
        if ([_model.type isEqualToString:@"0"]) {
            NSString *url = nil;
            url = model.thumbnailImgUrl;
            [_imgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"BBSDefaultImg"]];
            
        }else if ([_model.type isEqualToString:@"1"]){
            _imgView.image = _model.thumbnailImage;
        }
        _deleteBtn.hidden = _model.deleteBtnHidden;
    }
}

+(instancetype)PhotoCollectionViewCellWithCollectionView:(UICollectionView*)collectionView IndexPath:(NSIndexPath*)indexPath{
    static NSString*cellName = @"cellIDs";
    CTPGCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellName forIndexPath:indexPath];
    cell.deleteBtn.tag = indexPath.row;
    return cell;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        self.layer.borderColor = rgb(220, 221, 221, 1).CGColor;
        //        self.layer.borderWidth = 0.5;
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
    if (self.deleteBtnClick) {
        self.deleteBtnClick(btn.tag);
    }
}
@end
