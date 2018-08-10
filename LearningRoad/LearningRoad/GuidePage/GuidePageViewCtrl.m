//
//  GuidePageViewCtrl.m
//  LearningRoad
//
//  Created by Zhl on 2017/6/2.
//  Copyright © 2017年 LearningRoad. All rights reserved.
//

#import "GuidePageViewCtrl.h"

@interface GuidePageViewCtrl ()

@end

@implementation GuidePageViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] initWithFrame:ccr((SCREEN_WIDTH-100)/2.0, (SCREEN_HEIGHT-100)/2.0, 100, 100)];
    label.text = @"引 导 页";
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:25];
    label.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI/4.0);
    [self.view addSubview:label];
    // Do any additional setup after loading the view.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.guideComplete) {
        self.guideComplete(YES);
    }
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
