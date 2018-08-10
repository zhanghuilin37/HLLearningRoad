//
//  BBSTableViewCell.m
//  WeiboCellDemo
//
//  Created by CH10 on 16/3/29.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "BBSTableViewCell.h"

@interface BBSTableViewCell ()
@property (nonatomic,weak)YYLabel *letterL;
@end

@implementation BBSTableViewCell

-(void)setData:(BBSFModel *)fModel{
    if (fModel) {
        _letterL.attributedText = fModel.attText;
        _letterL.frame = fModel.letterLF;
    }
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat x = 10,y=4,w=SCREEN_WIDTH-20,h=0;
        YYLabel *letterL = [[YYLabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        letterL.layer.borderColor = rgb(200, 200, 200 , 1).CGColor;
        letterL.layer.borderWidth = 1.5;
        letterL.layer.cornerRadius = 5;
        letterL.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        letterL.displaysAsynchronously = YES;
        letterL.fadeOnHighlight = NO;
        letterL.numberOfLines = 0;
        _letterL = letterL;
        [self.contentView addSubview:letterL];
    }
    return self;
}






- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
