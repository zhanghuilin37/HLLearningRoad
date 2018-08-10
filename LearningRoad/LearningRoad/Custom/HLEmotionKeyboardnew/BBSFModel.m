//
//  BBSFModel.m
//  LearningRoad
//
//  Created by Zhl on 16/6/28.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "BBSFModel.h"

@implementation BBSFModel
-(void)setText:(NSString *)text{
    _text = text;
    if (_text.length) {
        CGFloat x = 10,y=4,w=SCREEN_WIDTH-20,h=0;
        h =[BBSLetterTool getLetterHeight:text padd:5 WithWidth:w];
        _attText = [BBSLetterTool manageBBSLetterStr:text WithDelegate:nil];
        _letterLF=CGRectMake(x, y, w, h);
        _cellHeight = h+8;
    }
}
@end
