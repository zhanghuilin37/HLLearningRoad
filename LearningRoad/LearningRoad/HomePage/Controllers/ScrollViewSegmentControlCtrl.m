//
//  ScrollViewSegmentControlCtrl.m
//  LearningRoad
//
//  Created by Zhl on 2017/8/4.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import "ScrollViewSegmentControlCtrl.h"
#import "HLScrollSegmentControl.h"
#import "HLUNScrollSegmentControl.h"
@interface ScrollViewSegmentControlCtrl ()<HLScrollSegmentControlDelegate,HLUNScrollSegmentControlDelegate>
@property (nonatomic,strong) HLScrollSegmentControl *segControl;
@property (nonatomic,strong) HLUNScrollSegmentControl *unSegControl;
@end

@implementation ScrollViewSegmentControlCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.segControl];
    [self.view addSubview:self.unSegControl];
}
#pragma mark - setter and getter methods
-(HLScrollSegmentControl *)segControl{
    if (_segControl == nil) {
        _segControl = [[HLScrollSegmentControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) Items:@[@"标题0000",@"标 题1",@"标  题22222",@"标题3",@"标   题4",@"标  题5",@"标题6",@"标题7",@"标 题8",@"标题9",] TextFont:[UIFont systemFontOfSize:15] SpaceWidth:10.0f AndDelegate:self];
        _segControl.backgroundColor = rgb(200, 200, 200, 1);
    }
    return _segControl;
}
-(HLUNScrollSegmentControl *)unSegControl{
    if (_unSegControl == nil) {
        _unSegControl = [[HLUNScrollSegmentControl alloc]initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 40) Items:@[@"标题0000",@"标 题1",@"标  题2222",@"标题3"] TextFont:[UIFont systemFontOfSize:15]  AndDelegate:self];
        _unSegControl.backgroundColor = rgb(200, 200, 200, 1);
    }
    return _unSegControl;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
