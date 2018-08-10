//
//  EditingTableViewCell.m
//  HandicapWin
//
//  Created by CH10 on 16/4/26.
//  Copyright © 2016年 赢盘. All rights reserved.
//

#import "EditingTableViewCell.h"
//#import "MatchSelectedViewController.h"
#import "CTPhotoModel.h"
@interface EditingTableViewCell ()<YYTextViewDelegate,CTPhotoGroupViewDelegate>
@property(nonatomic,assign)bool withRedBag;
@property(nonatomic,weak)CTPhotosGroupView *photosView;
@end

@implementation EditingTableViewCell

-(void)setImgModelArray:(NSMutableArray *)imgModelArray hasRedBag:(BOOL)hasRedBag{
    _imgModelArray = imgModelArray;
    _withRedBag = hasRedBag;
    [_photosView setDataArrayWithPhotoModelArray:_imgModelArray withAdd:YES withRedBag:hasRedBag];
    NSInteger count = _imgModelArray.count;
    if (hasRedBag) {
        count++;
    }
    if (count==0) {
        CGFloat x,y,w,h;
        x=_photosView.origin.x;y=_photosView.origin.y;w=_photosView.width ;h = 0.0;
        _photosView.frame = CGRectMake(x, y, w, h);
    }
}
+(instancetype)EditingTableViewCellWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath{
    
    EditingTableViewCell *cell = nil;
    if (indexPath.row==0){
        cell = [tableView dequeueReusableCellWithIdentifier:kanqiuIdentify];
        if (cell == nil) {
            cell = [[EditingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kanqiuIdentify];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:imgIdentify];
        if (cell == nil) {
            cell = [[EditingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:imgIdentify];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imgModelArray = [[NSMutableArray alloc] init];
        _imgArray = [[NSMutableArray alloc] init];
        self.clipsToBounds = YES;
        if ([reuseIdentifier isEqualToString:imgIdentify]){
            
            UIImage *img = [UIImage imageNamed:@"kanQiu"];
            CGFloat x = 10,y=10,w=img.size.width,h=img.size.height;
            UIImageView *kanQiuimgView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
            kanQiuimgView.image = img;
            [self.contentView addSubview:kanQiuimgView];
            
            x=kanQiuimgView.right+20;w=100;h=16;
            w = SCREEN_WIDTH -x;
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
            label.text = @"侃球";
            label.textColor = rgb(51, 51, 51, 1);
            label.userInteractionEnabled = YES;
            [self.contentView addSubview:label];
            
            //            UIControl *kanQiuControl = [[UIControl alloc] initWithFrame:label.bounds];
            //            [kanQiuControl addTarget:self action:@selector(kanQiuSelected) forControlEvents:UIControlEventTouchUpInside];
            //            [label addSubview:kanQiuControl];
            
            UIView *Hline = [[UIView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 0.5)];
            Hline.backgroundColor = rgb(220, 221, 221, 1);
            [self.contentView addSubview:Hline];
            
            
            UIView *Hline1 = [[UIView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 0.5)];
            Hline1.backgroundColor = rgb(220, 221, 221, 1);
            [self.contentView addSubview:Hline1];
        }else{
            
            CTPhotosGroupView *photosView = [[CTPhotosGroupView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 0) andHCount:5 andCountMax:9];
            photosView.delegate = self;
            _photosView = photosView;
            [self.contentView addSubview:photosView];
        }
    }
    return self;
}

//-(void)kanQiuSelected
//{
//    if (_delegate && [_delegate respondsToSelector:@selector(kanQiuClicked)]) {
//        [_delegate kanQiuClicked];
//    }
//}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(BOOL)textViewShouldBeginEditing:(YYTextView *)textView{
    return YES;
}
-(void)photoDeleteClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(photoDeleteClick:)]) {
        [self.delegate photoDeleteClick:btn];
    }
}
-(void)photoClicked:(NSInteger)index{
    if ([self.delegate respondsToSelector:@selector(photoClicked:)]) {
        [self.delegate photoClicked:index];
    }
}
-(void)photoGroup:(CTPhotosGroupView *)groupView photoClickedAtIndex:(NSInteger)index isAddBtn:(BOOL)flag isRedBag:(BOOL)isRedBag{
    if ([self.ctPGViewDelegate respondsToSelector:@selector(photoGroup:photoClickedAtIndex:isAddBtn:isRedBag:)]) {
        [self.ctPGViewDelegate photoGroup:groupView photoClickedAtIndex:index isAddBtn:flag isRedBag:isRedBag];
    }
}
-(void)photoGroup:(CTPhotosGroupView *)groupView deleteBtnClickedAtIndex:(NSInteger)index isRedBag:(BOOL)isRedBag{
    if ([self.ctPGViewDelegate respondsToSelector:@selector(photoGroup:deleteBtnClickedAtIndex:isRedBag:)]) {
        [self.ctPGViewDelegate photoGroup:groupView deleteBtnClickedAtIndex:index isRedBag:isRedBag];
    }
}
@end
