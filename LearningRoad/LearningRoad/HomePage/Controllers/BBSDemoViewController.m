//
//  BBSViewController.m
//  LearningRoad
//
//  Created by CH10 on 16/4/6.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "BBSDemoViewController.h"
#import "ReadLocalData.h"
#import "BBSEditingViewController.h"
#import "BBSLetterTool.h"
#import "BBSTableViewCell.h"
#import "CommentInputBar.h"
@interface BBSDemoViewController  ()<BBSLetterToolDelegate,UITableViewDataSource,UITableViewDelegate,CommentInputBarDelegate>
@property(nonatomic,strong)NSArray *topicArr;
@property(nonatomic,strong)NSArray *atArr;

@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UITableView *myTableView;
@property (nonatomic,strong) CommentInputBar *commentBar;
@end

@implementation BBSDemoViewController
#pragma mark - life time
-(instancetype)init{
    self = [super init];
    if (self) {
        _dataArray = [[NSMutableArray alloc] init];
        for (int i = 0; i<2; i++) {
            BBSFModel *fmodel = [[BBSFModel alloc] init];
            fmodel.text = [NSString stringWithFormat:@"哈哈哈哈[给力]哈哈哈哈哈[哈哈][神马]"];
            [_dataArray addObject:fmodel];
        }
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self p_createNavgationView];
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.commentBar];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
#pragma mark - Actions
-(void)rightNavClick{
    BBSEditingViewController *vc = [[BBSEditingViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.navigationController presentViewController:nvc animated:YES completion:nil];
    __weak BBSDemoViewController *this = self;
    [vc setSendSuccess:^(NSString *text) {
        BBSFModel *fmodel = [[BBSFModel alloc] init];
        fmodel.text = text;
        [this.dataArray addObject:fmodel];
        [this.myTableView reloadData];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"BBSCellID";
    BBSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[BBSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    if (_dataArray.count) {
        BBSFModel *fModel = [_dataArray objectAtIndex:indexPath.row];
        [cell setData:fModel];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_dataArray.count) {
        BBSFModel *fModel = [_dataArray objectAtIndex:indexPath.row];
        return fModel.cellHeight;
    }else{
        return 0.000001;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.commentBar startEditing];
}
#pragma mark - <CommentInputBarDelegate>
//发送按钮被点击
-(void)sendBtnClicked:(NSString *)text{
    
}
#pragma mark - getter Methods
-(CommentInputBar *)commentBar{
    if (_commentBar == nil) {
        _commentBar = [CommentInputBar commentInputBarWithPoint:CGPointMake(0, self.myTableView.bottom) AndDelegate:self];
    }
    return _commentBar;
}
-(UITableView *)myTableView{
    if (_myTableView == nil) {
        CGFloat x = 0,y=0,w=SCREEN_WIDTH,h=SCREEN_HEIGHT-k_NavBar_H-k_X_HomeSafeArea_H-CommentNormalToolBarHeight;
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(x, y, w, h) style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myTableView;
}
#pragma mark - PrivateMethod
-(void)p_createNavgationView{
    UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 30);
    [button setTitle:@"编辑" forState:UIControlStateNormal];
    [button setTitleColor:rgb(0, 120, 200, 1) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightNavClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
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
