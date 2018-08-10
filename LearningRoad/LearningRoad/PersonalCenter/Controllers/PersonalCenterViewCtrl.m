//
//  PersonalCenterViewCtrl.m
//  LearningRoad
//
//  Created by Zhl on 2017/6/2.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import "PersonalCenterViewCtrl.h"
#import "UserManager.h"
#import "LoginViewController.h"
#import "PersonalCenterCell.h"
#import "GestureSettingViewController.h"
#import "SDImageCache.h"
@interface PersonalCenterViewCtrl ()<UITableViewDataSource,UITableViewDelegate,HLBaseTableViewDelegate>
@property(nonatomic,strong)HLBaseTableView *myTableView;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation PersonalCenterViewCtrl
#pragma mark - Life time
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavItemWithTitle:@"退出" Color:[UIColor whiteColor] IsLeft:NO Target:self Sel:@selector(rightClick:)];
    [self.view addSubview:self.myTableView];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    if (![self.myTableView isRefresh]) {
        [self.myTableView beginRefreshing];
    }
}
#pragma mark - Actions
-(void)rightClick:(UIButton *)btn{
    
    UserModel *userModel = [[UserManager sharedInstance] getLoginUser];
    userModel.isLogin = NO;
    userModel.user = nil;
    userModel.isGestureLock = NO;
    userModel.gesturePsword = nil;
    [[UserManager sharedInstance] setLoginUser:userModel];
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:loginVC];
    
    [self presentViewController:nvc animated:YES completion:nil];
}

#pragma  - mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonalCenterCell *cell = [PersonalCenterCell cellWithTableView:tableView indexPath:indexPath];
    cell.titleLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        PersonalCenterCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell.openGesture.on) {
            GestureSettingViewController *vc = [[GestureSettingViewController alloc] init];
            vc.type = 1;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [LRTools hl_showAlertViewWithString:@"请先开启手势密码"];
        }
        
    }else if (indexPath.row == 1){
        [[SDImageCache sharedImageCache] clearDisk];
        [[SDImageCache sharedImageCache] clearMemory];
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}
#pragma mark - CTBaseTableViewDelegate
-(void)hlBaseTableViewDidPullDownRefreshed:(HLBaseTableView *)tableView{
    if (self.dataArray.count) {
        [self.dataArray removeAllObjects];
    }
    [self.dataArray addObject:@"手势密码"];
    [self.dataArray addObject:@"清理缓存"];
    [self.myTableView reloadData];
    [tableView reloadDeals];
}
-(void)hlBaseTableViewDidPullUpRefreshed:(HLBaseTableView *)tableView{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Getter methods
-(HLBaseTableView *)myTableView{
    if (_myTableView  == nil) {
        //myTableView
        CGFloat x,y,w,h;
        x = 0;  y = 0;  w = SCREEN_WIDTH;   h = SCREEN_HEIGHT-64;
        HLBaseTableView *tableView = [[HLBaseTableView alloc] initWithFrame:ccr(x, y, w, h) style:UITableViewStylePlain hasFooter:NO];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.refreshDelegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView = tableView;
    }
    return _myTableView;
}
-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
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
