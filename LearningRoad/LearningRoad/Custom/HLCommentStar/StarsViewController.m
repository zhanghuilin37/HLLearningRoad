//
//  StarsViewController.m
//  LearningRoad
//
//  Created by CH10 on 16/1/21.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "StarsViewController.h"
#import "StarsView.h"
@interface StarsViewController ()<StarsViewDelegate>
{
    StarsView *view;
    UIButton *btn;
}
@end

@implementation StarsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评分星星";
    view = [[StarsView alloc] initWithStarSize:CGSizeMake(20, 20) space:5 numberOfStar:5];
    view.score = 0.1;
    view.delegate =self;
    view.frame = CGRectMake(100, 100, view.frame.size.width, view.frame.size.height);
    [self.view addSubview:view];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 200, 100, 100);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)btnClick:(UIButton*)btn{
    
    view.score+=0.5;
}
-(void)starChanged:(CGFloat)score{
    [btn setTitle:[NSString stringWithFormat:@"评级：%.1f",score] forState:UIControlStateNormal];
    NSLog(@"%f",score);
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
