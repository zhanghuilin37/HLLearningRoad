//
//  HomePageViewCtrl.m
//  LearningRoad
//
//  Created by Zhl on 2017/6/2.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import "HomePageViewCtrl.h"
#import "UIScrollView+VGParallaxHeader.h"
#import "HLBaseTableView.h"
#import "HLAdvScrollView.h"
#import "HLNavView.h"
#import "HLZheDieView.h"
#import "HLScreenCutBtn.h"
#import "ScrollViewSegmentControlCtrl.h"
#import "HLAlertDemoViewController.h"
#import <objc/runtime.h>

@interface HomePageViewCtrl ()<UITableViewDelegate,UITableViewDataSource,HLAdvScrollViewDelegate,HLZheDieViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) HLAdvScrollView *advHeaderView;
@property (nonatomic,strong) HLNavView *navView;
@property (nonatomic,strong) HLZheDieView *bottomView;
@property (nonatomic,strong) HLScreenCutBtn *screenCutBtn;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *viewControllerArr;
@end

@implementation HomePageViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [@[@"HlScrollSegmentControlDemo",@"HLAlertDemo",@"BBSDemo"]mutableCopy];
    self.viewControllerArr = [@[@"ScrollViewSegmentControlCtrl",@"HLAlertDemoViewController",@"BBSDemoViewController"] mutableCopy];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"首页";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.bottomView];
    HLScreenCutBtn *screenCutBtn = [HLScreenCutBtn shareZHLScreenCutBtn];
    screenCutBtn.offsetY = 49;
    [self.view addSubview:screenCutBtn];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld、%@",(long)indexPath.row,[_dataArray objectAtIndex:indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *controllerName = [self.viewControllerArr objectAtIndex:indexPath.row];
    HLBaseViewController *ctrl = (HLBaseViewController*)[[NSClassFromString(controllerName) alloc] init];
    ctrl.title = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:ctrl animated:YES];
}



#pragma mark - Setter Methods
-(void)setTitle:(NSString *)title{
    [super setTitle:title];
    self.navView.titleLabel.text = title;
}

#pragma mark - Getter Methods
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:ccr(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setParallaxHeaderView:self.advHeaderView
                                          mode:VGParallaxHeaderModeFill
                                        height:200];
    }
    return _tableView;
}
-(HLAdvScrollView *)advHeaderView{
    if (_advHeaderView == nil) {
        _advHeaderView = [[HLAdvScrollView alloc] initWithFrame:ccr(0, 0, SCREEN_WIDTH, 200) images:@[@"adv1",@"adv2",@"adv3"] timesInterval:4 andAnimateDureation:1 addToRunloop:NO delegate:self];
        _advHeaderView.backgroundColor = [UIColor grayColor];
    }
    return _advHeaderView;
}
-(HLNavView *)navView{
    if (_navView == nil) {
        _navView = [[HLNavView alloc] initWithFrame:ccr(0, 0, SCREEN_WIDTH, 64)];
    }
    return _navView;
}
-(HLZheDieView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[HLZheDieView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-90-49, SCREEN_WIDTH, 90)];
        _bottomView.delegate = self;
        _bottomView.offsetY = 49;
    }
    return _bottomView;
}
#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.bottomView.state = HLZheDieViewAnimationSate_shouqi;
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 5 && offsetY < 64) {
        self.navView.bgView.alpha = offsetY/64.0*0.95;
    }else if(offsetY<5){
        self.navView.bgView.alpha = 0.0;
    }else{
        self.navView.bgView.alpha = 1.0;
    }
    // This must be called in order to work
    [scrollView shouldPositionParallaxHeader];
    
    // scrollView.parallaxHeader.progress - is progress of current scroll
//    NSLog(@"Progress: %f", scrollView.parallaxHeader.progress);
    
    // This is how you can implement appearing or disappearing of sticky view
    [scrollView.parallaxHeader.stickyView setAlpha:scrollView.parallaxHeader.progress];
}
#pragma mark - < - HLAdvScrollViewDelegate - >
-(void)hlAdvScrollView:(HLAdvScrollView *)scrollView ClickedImgVAtIndex:(NSInteger)index{
    
}
#pragma mark - < - HLZheDieViewDelegate - >
-(void)HLZheDieViewItemClickedAtIndex:(NSInteger)index{
    NSLog(@"zhedieIndex - - -%ld",(long)index);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
