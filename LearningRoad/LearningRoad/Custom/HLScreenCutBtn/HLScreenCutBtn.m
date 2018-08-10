//
//  HLScreenCutBtn.m
//  Quartz2d
//
//  Created by CH10 on 15/11/9.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "HLScreenCutBtn.h"
#import "AppDelegate.h"
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define btnX self.frame.origin.x
#define btnY self.frame.origin.y
#define btnWidth self.frame.size.width
#define btnHeight self.frame.size.height
@interface HLScreenCutBtn ()<UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation HLScreenCutBtn
+(HLScreenCutBtn *)shareZHLScreenCutBtn{
    static HLScreenCutBtn *btn;
    if (btn == nil) {
        btn = [HLScreenCutBtn buttonWithType:UIButtonTypeCustom];
        [btn createBtn];
    }
    return btn;
}
-(void)createBtn{

    self.frame = CGRectMake(0, SCREEN_HEIGHT-64-50, 50, 50);


    self.layer.borderColor = [[UIColor redColor] CGColor];
    self.layer.borderWidth = 4;
    self.layer.cornerRadius = 25;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor blackColor];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveBtn:)];
    [self addGestureRecognizer:pan];
    [self setTitle:@"截屏" forState:UIControlStateNormal];
    [self addTarget:self action:@selector(screenCutBtnClick) forControlEvents:UIControlEventTouchUpInside];
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app.window addSubview:self];
    [app.window bringSubviewToFront:self];
}
-(void)moveBtn:(UIPanGestureRecognizer *)sender{
    CGPoint deltaPoint = [sender translationInView:sender.view];
    self.transform = CGAffineTransformTranslate(self.transform, deltaPoint.x, deltaPoint.y);
    [sender setTranslation:CGPointZero inView:self];
    

    if (sender.state == UIGestureRecognizerStateEnded) {
        CGFloat edgeTop,edgeBottom,edgeLeft,edgeRight;
        edgeTop = btnY;
        edgeBottom = SCREEN_HEIGHT - btnHeight-btnY-_offsetY;
        edgeLeft = btnX;
        edgeRight = SCREEN_WIDTH - btnX-btnWidth;
        NSInteger finalState = 0;
        CGRect frame = self.frame;
        if (edgeLeft+btnWidth/2.0<=SCREEN_WIDTH/2.0) {//左移
            finalState = 0;
            
        }else{//右移
            finalState = 1;
            
        }
        if (edgeTop<=btnHeight*2) {//上移
            finalState = 2;
            
        }
        if (edgeBottom<=btnHeight*2) {//下移
            finalState =3;
            
        }
        
        
        switch (finalState) {
            case 0:
                frame.origin.x = 0;
                break;
            case 1:
                frame.origin.x = SCREEN_WIDTH-btnWidth;
                break;
            case 2:
                frame.origin.y = 0;
                break;
            case 3:
                frame.origin.y=SCREEN_HEIGHT-btnHeight-_offsetY;
                break;
            default:
                break;
        }
        
        
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = frame;
        }];
        
    }
    
    
    if(btnX<0){
        self.frame = CGRectMake(0, btnY, btnWidth, btnHeight);
    }else if (btnX+btnWidth>SCREEN_WIDTH){
        self.frame = CGRectMake(SCREEN_WIDTH-btnWidth, btnY, btnWidth, btnHeight);
    }else if (btnY< 0){
        self.frame = CGRectMake(btnX, 0, btnWidth, btnHeight);
    }else if (btnY+btnHeight>SCREEN_HEIGHT-_offsetY){
        self.frame = CGRectMake(btnX, SCREEN_HEIGHT-btnHeight-_offsetY, btnWidth, btnHeight);
    }

    
    

}
//截屏
-(void)screenCutBtnClick{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //获取上下文
        UIGraphicsBeginImageContext(self.superview.frame.size);
        //将view绘制到图形上下文中
        [self.superview.layer renderInContext:UIGraphicsGetCurrentContext()];
        //从上下文对象获取图片
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        //把图片保存到相册
        UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        
    });
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        NSLog(@"%@",error);
        NSLog(@"失败");
    }else{
        NSLog(@"保存成功");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"💡" message:@"截屏成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去看看", nil];
        [alert show];
        
    }
}
#pragma mark -  UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        UIImagePickerController *pic=[[UIImagePickerController alloc] init];
        pic.delegate = self;
        [[LRTools hl_getCurrentNav] presentViewController:pic animated:YES completion:nil];
    }
}
#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
