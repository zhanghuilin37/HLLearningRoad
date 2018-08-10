//
//  IndicatorViewCtrl.m
//  LearningRoad
//
//  Created by Zhl on 2017/6/2.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import "IndicatorViewCtrl.h"
#import "HLBaseTableView.h"
#import "HLScrollSegmentControl.h"
#import "HLUNScrollSegmentControl.h"
@interface IndicatorViewCtrl ()<UITableViewDelegate,UITableViewDataSource,HLBaseTableViewDelegate,HLScrollSegmentControlDelegate,HLUNScrollSegmentControlDelegate>
@property (nonatomic,strong) HLBaseTableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) HLScrollSegmentControl *segmentControl;
@property (nonatomic,strong) HLUNScrollSegmentControl *unSegmentControl;
@end

@implementation IndicatorViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"指导";
    [self.view addSubview:self.segmentControl];
    [self.view addSubview:self.tableView];
}
#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }

    
    return cell;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - <HLBaseTableViewDelegate>
-(void)hlBaseTableViewDidPullDownRefreshed:(HLBaseTableView *)tableView{
    [self.tableView reloadDeals];
}


#pragma mark - Getter Methods
-(HLBaseTableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[HLBaseTableView alloc] initWithFrame:ccr(0, 115*SCREEN_WIDTH/750, SCREEN_WIDTH, SCREEN_HEIGHT-115*SCREEN_WIDTH/750-64-49) style:UITableViewStylePlain hasFooter:NO];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        _tableView.refreshDelegate = self;
        _tableView.editing = YES;
    }
    return _tableView;
}

-(HLScrollSegmentControl *)segmentControl{
    if (_segmentControl == nil) {
        _segmentControl = [[HLScrollSegmentControl alloc] initWithFrame:ccr(0, 0, SCREEN_WIDTH, 100*SCREEN_WIDTH/750) Items:@[@"标  题0",@"标  题1",@"标  题2",@"标  题3",@"标  题4",@"标  题5",@"标  题6",@"标  题7",@"标  题8",@"标  题9"] TextFont:[UIFont systemFontOfSize:15] SpaceWidth:10 AndDelegate:self];
//                _segmentControl = [[HLScrollSegmentControl alloc] initWithFrame:ccr(0, 0, SCREEN_WIDTH, 100*SCREEN_WIDTH/750) Items:@[@"标  题0",@"标  题1",@"标  题2",@"标  题3",@"标  题4"] TextFont:[UIFont systemFontOfSize:15] SpaceWidth:10 AndDelegate:self];
        _segmentControl.backgroundColor = rgb(250, 250, 250, 1);
    }
    return _segmentControl;
}
-(HLUNScrollSegmentControl *)unSegmentControl{
    if (_unSegmentControl == nil) {
        _unSegmentControl = [[HLUNScrollSegmentControl alloc] initWithFrame:ccr(0, 0, SCREEN_WIDTH, 80*SCREEN_WIDTH/750) Items:@[@"热门",@"宝动态",@"实时官微",@"分析",@"复盘"] TextFont:[UIFont systemFontOfSize:15] AndDelegate:self];
        //                _segmentControl = [[HLScrollSegmentControl alloc] initWithFrame:ccr(0, 0, SCREEN_WIDTH, 100*SCREEN_WIDTH/750) Items:@[@"标  题0",@"标  题1",@"标  题2",@"标  题3",@"标  题4"] TextFont:[UIFont systemFontOfSize:15] SpaceWidth:10 AndDelegate:self];
        _unSegmentControl.backgroundColor = rgb(250, 250, 250, 1);
    }
    return _unSegmentControl;
}
#pragma mark - < HLScrollSegmentControlDelegate >
-(void)hlScrollSegmentControl:(HLScrollSegmentControl *)segControl SelectedIndex:(NSInteger)index{
    
}
-(void)setBasicPropertyOfBtnItem:(UIButton *)btnItem{
    [btnItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnItem setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
}
-(void)setBasicPropertyOfLeftIndicator:(UIView *)leftIndicator RightIndicator:(UIView *)rightIndicator{
    leftIndicator.layer.shadowColor = [UIColor whiteColor].CGColor;
    rightIndicator.layer.shadowColor = [UIColor whiteColor].CGColor;
}
-(void)setBasicPropertyOfBottomSlider:(UIView *)sliderView{
    sliderView.backgroundColor = [UIColor redColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
