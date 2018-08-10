//
//  BBSEditingViewController.m
//  HandicapWin
//
//  Created by CH10 on 16/4/26.
//  Copyright © 2016年 赢盘. All rights reserved.
//

#import "BBSEditingViewController.h"
#import "EditingInputBar.h"
#import "EditingTableViewCell.h"
#import "ReadLocalData.h"
#import "BBSProtocols.h"
#import "TZImagePickerController.h"
#import "UIView+Layout.h"
#import "TZImageManager.h"
#import "CTPhotoWall.h"
#import "CTPhotoModel.h"
#define CommentMaxLines     4
#define WordNumMax 500
#define inputViewfont 15
@interface BBSEditingViewController ()<UITableViewDataSource,UITableViewDelegate,EditingInputBarDelegate,UITextViewDelegate,UIActionSheetDelegate,PhotoCollectionViewCellDelegate,TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CTPhotoGroupViewDelegate>//图片
//是否有红包
@property(nonatomic,assign)bool hasSelectedRedBag;
@property(nonatomic,strong)NSMutableArray *imgModelArray;
@property (nonatomic,copy)NSMutableString *imgUrlStr;
//at的人
@property(nonatomic,strong)NSMutableArray *atModelArray;
@property (nonatomic,copy)NSMutableString *atSpecialJumpStr;
//侃球
@property (nonatomic,copy)NSMutableString *matchJumpStr;
@property (nonatomic,strong)NSMutableArray *matchJumpArray;

@property(nonatomic,assign)BOOL moveToBottom;
@property (nonatomic,weak)EditingInputBar *inputBar;
@property (nonatomic,weak)UILabel *placeLabel;
@property(nonatomic,weak)UILabel *wordCountLabel;
@property (nonatomic,weak)UITableView *myTableView;
@end

@implementation BBSEditingViewController
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        //监听键盘事件
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    _imgModelArray = [[NSMutableArray alloc] init];
    _atModelArray = [[NSMutableArray alloc] init];
    _matchJumpArray = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"编辑";
    UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 30);
    [button setTitle:@"发布" forState:UIControlStateNormal];
    [button setTitleColor:rgb(0, 120, 200, 1) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightNavClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    UIButton *button1  = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0, 0, 50, 30);
    [button1 setTitle:@"返回" forState:UIControlStateNormal];
    [button1 setTitleColor:rgb(0, 120, 200, 1) forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(leftNavClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button1];
    [self createTableView];
    
    CGFloat x = 0, y = SCREEN_HEIGHT - PostingBarHeight-64,
    w = SCREEN_WIDTH, h = PostingBarHeight + FaceViewHeight;
    EditingInputBar *inputBar = [[EditingInputBar alloc] initWithFrame:ccr(x, y, w, h)];
    inputBar.delegate = self;
    [self.view addSubview:inputBar];
    self.inputBar = inputBar;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.inputView becomeFirstResponder];
}
-(void)createTableView{
    
    CGFloat x = 0, y = 0,w = SCREEN_WIDTH, h = SCREEN_HEIGHT-64;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(x, y, w, h) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.clipsToBounds = NO;
    tableView.backgroundColor = [LRTools hl_colorWithHexString:@"f6f6f6"];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view  addSubview:tableView];
    self.myTableView = tableView;
    
    h=150;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
    bgView.backgroundColor = [UIColor whiteColor];
    x=10;w-=20;
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    textView.delegate =self;
    tableView.tableHeaderView = bgView;
    textView.font = [UIFont systemFontOfSize:15];
    textView.textColor = [LRTools hl_colorWithHexString:@"333333"];
    [bgView addSubview:textView];
    self.inputView = textView;
    
    x=w-100;y=h-20;w=100;h=20;
    UILabel *wordCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    wordCountLabel.text = [NSString stringWithFormat:@"%ld/%d",(long)textView.text.length,WordNumMax];
    wordCountLabel.textAlignment = NSTextAlignmentRight;
    wordCountLabel.font = [UIFont systemFontOfSize:11];
    wordCountLabel.textColor = [LRTools hl_colorWithHexString:@"999999"];
    [tableView addSubview:wordCountLabel];
    self.wordCountLabel = wordCountLabel;
    
    UILabel *placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 8, 120, 13)];
    placeLabel.text = @"说点什么...";
    placeLabel.textColor = [LRTools hl_colorWithHexString:@"999999"];
    placeLabel.font = [UIFont systemFontOfSize:13];
    [textView addSubview:placeLabel];
    self.placeLabel = placeLabel;
}

-(void)leftNavClick{
    if ([self.inputView isFirstResponder]) {
        [self.inputView resignFirstResponder];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)rightNavClick{
    if (_imgModelArray.count==0&&_inputView.text.length==0) {
//        [ZHLTools showAlertViewWithString:@"帖子内容不能为空"];
        return;
    }
    if (self.sendSuccess) {
        self.sendSuccess(_inputView.text);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
//    if(_imgModelArray.count){
//    }else{
//    }
//    NSLog(@"%@",_imgUrlStr);
}

//上传图片缩放
-(UIImage *)scaleImage:(UIImage *)image
{
    CGSize imgSize = CGSizeMake(320, image.size.height*320/image.size.width);
    UIGraphicsBeginImageContext(imgSize);
    [image drawInRect:CGRectMake(0,0,imgSize.width,imgSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
//点击了图片上的删除按钮
-(void)photoDeleteClick:(UIButton *)btn{
    NSLog(@"con----------%ld",(long)btn.tag);
    if (btn.tag<_imgModelArray.count) {
        [_imgModelArray removeObjectAtIndex:btn.tag];
    }
    [self.myTableView reloadData];
}
//图片被点击
-(void)photoClicked:(NSInteger)index{
    if ([self.inputView isFirstResponder]) {
        [self.inputView resignFirstResponder];
    }
    [self inputBarMoveToBottomWithDuration:0.25];
    if (index==_imgModelArray.count) {//点击了加号
        UIActionSheet *actionShee = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"拍照", nil];
        [actionShee showInView:self.view];
    }else{
        [CTPhotoWall photoWallShowWithImgModelDataArr:_imgModelArray Index:index];
    }
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EditingTableViewCell*cell = [EditingTableViewCell EditingTableViewCellWithTableView:tableView indexPath:indexPath];
    cell.delegate = self;
    cell.ctPGViewDelegate = self;
    if (indexPath.row==0) {
        [cell setImgModelArray:_imgModelArray hasRedBag:NO];
    }else{
        
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        CGFloat h = 0.0,w=SCREEN_WIDTH-20;
        if (_imgModelArray.count) {
            NSInteger xishu = _imgModelArray.count+1>9?9:_imgModelArray.count+1;
            CGFloat itemW =(w-10*4)/5.0;
            NSInteger finalXishu = 0;
            if (xishu%5>0) {
                finalXishu = xishu/5+1;
            }else{
                finalXishu = xishu/5;
            }
            h = itemW*finalXishu
            +10.0*(finalXishu-1)+10;
        }
        return h;
    }else{
        return 40;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==1) {//侃球
        if ([self.inputView isFirstResponder]) {
            [self.inputView resignFirstResponder];
        }
        [self inputBarMoveToBottomWithDuration:0.25];
        [self kanQiuClicked];
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.myTableView) {
        if ([self.inputView isFirstResponder]) {
            [self.inputView resignFirstResponder];
        }
        [self inputBarMoveToBottomWithDuration:0.3];
    }
    
}




-(void)keyboardWillShow:(NSNotification *)info{
    NSTimeInterval duration = [info.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect kebordFrame = [info.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect frame = self.inputBar.frame;
    frame.origin.y = SCREEN_HEIGHT-kebordFrame.size.height-PostingBarHeight-64;
    [UIView animateWithDuration:duration animations:^{
        self.inputBar.frame = frame;
    } completion:^(BOOL finished) {
        self.inputBar.faceBtn.selected = NO;
    }];
}
-(void)keyboardWillHide:(NSNotification *)info{
    NSTimeInterval duration = [info.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    
    if (_moveToBottom) {
        [self inputBarMoveToBottomWithDuration:duration];
        _moveToBottom = NO;
    } else {
        [self inputBarShowFaceViewWithDuration:duration];
    }
}
-(void)inputBarMoveToBottomWithDuration:(NSTimeInterval)duration{
    CGRect frame = self.inputBar.frame;
    frame.origin.y = SCREEN_HEIGHT-64;
    __weak BBSEditingViewController *this = self;
    [UIView animateWithDuration:duration animations:^{
        self.inputBar.frame = frame;
    } completion:^(BOOL finished) {
        self.inputBar.faceBtn.selected = NO;
        if (!self.inputView.text.length) {
            this.placeLabel.hidden = NO;
        }else{
            this.placeLabel.hidden = YES;
        }
    }];
}
-(void)inputBarShowFaceViewWithDuration:(NSTimeInterval)duration{
    CGRect frame = self.inputBar.frame;
    frame.origin.y = SCREEN_HEIGHT-FaceViewHeight-PostingBarHeight-64;
    
    [UIView animateWithDuration:duration animations:^{
        self.inputBar.frame = frame;
    } completion:^(BOOL finished) {
        self.inputBar.faceBtn.selected = YES;
    }];
}
#pragma mark - CTPhotoGroupViewDelegate
//图片被点击
-(void)photoGroup:(CTPhotosGroupView *)groupView photoClickedAtIndex:(NSInteger)index isAddBtn:(BOOL)flag isRedBag:(BOOL)isRedBag{
    if ([self.inputView isFirstResponder] && !isRedBag) {
        [self.inputView resignFirstResponder];
    }
    [self inputBarMoveToBottomWithDuration:0.25];
    if (!flag&&!isRedBag) {
        NSArray *arr = [groupView getPhotoModelArray];
        if (self.hasSelectedRedBag) {
            [CTPhotoWall photoWallShowWithImgModelDataArr:arr Index:index-1];
        }else{
            
            [CTPhotoWall photoWallShowWithImgModelDataArr:arr Index:index];
        }
    }
    if (flag) {
        UIActionSheet *actionShee = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"拍照", nil];
        [actionShee showInView:self.view];
    }
    if (isRedBag) {//红包图片被点击
//        GRPAlertView *alertView = [[GRPAlertView alloc] initWithMessage:@"" CancelTitle:@"取消红包" otherTitle:@"重新编辑" buttonClik:^(NSUInteger index) {
//            if (index == 0) {
//                //删除红包的图片也要删除储存红包的内容
//                [[SaveEditedGRPModel sharedManager] setGRPModel:nil];
//                self.hasSelectedRedBag = NO;
//            }
//            if (index == 1) {
//                GRPViewController *gRPViewController = [[GRPViewController alloc] init];
//                gRPViewController.giveRedPacketsType = NormalGRPacketsType;
//                [self.navigationController pushViewController:gRPViewController animated:YES];
//            }
//        }];
//        [alertView showView];
    }
    NSLog(@"isRedBagcon----------%ld",(long)index);
}
//图片上的删除按钮被点击
-(void)photoGroup:(CTPhotosGroupView *)groupView deleteBtnClickedAtIndex:(NSInteger)index isRedBag:(BOOL)isRedBag{
    if (isRedBag) {
        self.hasSelectedRedBag = NO;
        NSLog(@"isRedBagconDelete----------%ld",(long)index);
    }else{
        NSLog(@"con----------%ld",(long)index);
        NSInteger realIndex = self.hasSelectedRedBag?index-1:index;
        if (realIndex<_imgModelArray.count) {
            [_imgModelArray removeObjectAtIndex:realIndex];
        }
    }
    [self.myTableView reloadData];
}
#pragma mark - EditingInputBarDelegate
-(void)goAlbum{
    if ([self.inputView isFirstResponder]) {
        [self.inputView resignFirstResponder];
    }
    [self inputBarMoveToBottomWithDuration:0.25];
    UIActionSheet *actionShee = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"拍照", nil];
    [actionShee showInView:self.view];
}
-(void)goAtFriends{
    if ([self.inputView isFirstResponder]) {
        [self.inputView resignFirstResponder];
    }
    [self inputBarMoveToBottomWithDuration:0.25];
}
-(void)faceBtnClicked:(UIButton *)btn{
    if (btn.selected) {
        //显示表情
        if ([self.inputView isFirstResponder]) {
            [self.inputBar setImgs];
            [self.inputView resignFirstResponder];
        } else {
            [self inputBarShowFaceViewWithDuration:0.25];
        }
    } else {
        //显示键盘
        [self.inputView becomeFirstResponder];
    }
}
-(void)faceWasSelectedName:(NSString *)nameStr{
    NSLog(@"%@",nameStr);
    if (self.inputView.text == nil) {
        self.inputView.text = @"";
    }
    NSString *tmpStr = self.inputView.text;
    
    NSInteger count = WordNumMax - [tmpStr length];
    if (count < [nameStr length]) {
//        [ProgressHUD showWithStatus:[NSString stringWithFormat:@"最多%d字",WordNumMax]];
        return;
    }
    tmpStr = [tmpStr stringByAppendingString:nameStr];
    self.inputView.text = tmpStr;
    
    [self.inputView scrollRangeToVisible:NSMakeRange([self.inputView.text length], 0)];
    
    [self textViewDidChange:self.inputView];
}
//表情键盘上的删除键
-(void)deleteBtnClicked{
    NSLog(@"deletesss");
    
    [self deleteSpecialStrAtLast];
    [self textViewDidChange:self.inputView];
}
-(void)deleteSpecialStrAtLast{
    NSString *str = self.inputView.text;
    
    if ([str length] == 0) {
        return;
    }
    
    NSString *tmpTest = [str substringWithRange:NSMakeRange([str length]-1, 1)];
    if ([tmpTest isEqualToString:@"]"]) {
        for (NSInteger i = ([str length]-1); i > 0; i--) {
            NSString *tmpString = [str substringWithRange:NSMakeRange(i-1, 1)];
            if ([tmpString isEqualToString:@"["]) {
                NSInteger curLength = [str length] - (i-1);
                NSString *tmpStr1 = [str substringWithRange:NSMakeRange(i-1, curLength)];
                //删除表情
                {
                    NSDictionary *dict = [[ReadLocalData defaultReadLocalData] getFaceStrDict];
                    NSString *faceStr = [dict objectForKey:tmpStr1];
                    
                    if (faceStr != nil) {
                        NSString *strOne = [str substringToIndex:i-1];
                        self.inputView.text = strOne;
                        
                        [self.inputView scrollRangeToVisible:NSMakeRange([self.inputView.text length], 0)];
                        
                        [self textViewDidChange:self.inputView];
                        
                        return ;
                    }
                }
            }
        }
        NSString *tmpWZ = [str substringToIndex:[str length]-1];
        self.inputView.text = tmpWZ;
        [self.inputView scrollRangeToVisible:NSMakeRange([self.inputView.text length], 0)];
        return;
    }else if ([tmpTest isEqualToString:@"#"]){
        for (NSInteger i = ([str length]-1); i > 0; i--) {
            NSString *tmpString = [str substringWithRange:NSMakeRange(i-1, 1)];
            if ([tmpString isEqualToString:@"#"]) {
                NSInteger curLength = [str length] - (i-1);
                NSString *tmpStr1 = [str substringWithRange:NSMakeRange(i-1, curLength)];
                //删除话题
                for (NSString *matchJumpStr in _matchJumpArray) {
                    
                    if ([LRTools hl_containString:tmpStr1 sourceString:matchJumpStr]) {
                        NSString *strOne = [str substringToIndex:i-1];
                        self.inputView.text = strOne;
                        [self.inputView scrollRangeToVisible:NSMakeRange([self.inputView.text length], 0)];
                        
                        [self textViewDidChange:self.inputView];
                        [_matchJumpArray removeObject:matchJumpStr];
                        return ;
                    }
                }
            }
        }
        NSString *tmpWZ = [str substringToIndex:[str length]-1];
        self.inputView.text = tmpWZ;
        [self.inputView scrollRangeToVisible:NSMakeRange([self.inputView.text length], 0)];
        return ;
    }
    else if([tmpTest isEqualToString:@" "]){
        for (NSInteger i = ([str length]-1); i > 0; i--) {
            NSString *tmpString = [str substringWithRange:NSMakeRange(i-1, 1)];
            if ([tmpString isEqualToString:@" "]) {
                NSString *tmpWZ = [str substringToIndex:[str length]-1];
                self.inputView.text = tmpWZ;
                [self.inputView scrollRangeToVisible:NSMakeRange([self.inputView.text length], 0)];
                return ;
            }else if([tmpString isEqualToString:@"@"]){
//                NSInteger curLength = [str length] - (i-1);
//                NSString *tmpStr1 = [str substringWithRange:NSMakeRange(i-1, curLength)];
                //删除AT
                {
//                    for (BBSFuns *model in _atModelArray) {
//                        NSString *atStr = [NSString stringWithFormat:@"@%@ ",model.name];
//                        if ([atStr isEqualToString:tmpStr1]) {
                            NSString *strOne = [str substringToIndex:i-1];
                            self.inputView.text = strOne;
                            [self.inputView scrollRangeToVisible:NSMakeRange([self.inputView.text length], 0)];
                            
                            [self textViewDidChange:self.inputView];
//                            [_atModelArray removeObject:model];
                            return;
//                        }
//                    }
                }
                
            }
        }
        NSString *tmpWZ = [str substringToIndex:[str length]-1];
        self.inputView.text = tmpWZ;
        [self.inputView scrollRangeToVisible:NSMakeRange([self.inputView.text length], 0)];
        return ;
    }
    else{
        NSString *tmpWZ = [str substringToIndex:[str length]-1];
        self.inputView.text = tmpWZ;
        [self.inputView scrollRangeToVisible:NSMakeRange([self.inputView.text length], 0)];
        return ;
    }
    
    
}
-(void)deleteSpecialStrAtCenter:(NSString*)str range:(NSRange)range{
    //当在中间删除的时候
    if (range.location == 0 && range.length == 0) {
        return ;
    }
    
    NSString *strOne = [str substringToIndex:range.location+1];
    NSString *strTwo = [str substringFromIndex:range.location+1];
    NSString *tmpTest = [strOne substringWithRange:NSMakeRange([strOne length]-1, 1)];
    
    if ([tmpTest isEqualToString:@"]"]) {
        for (NSInteger i = ([strOne length]-1); i > 0; i--) {
            NSString *tmpString = [strOne substringWithRange:NSMakeRange(i-1, 1)];
            
            if ([tmpString isEqualToString:@"["]) {
                NSInteger curLength = [strOne length] - (i-1);
                
                NSString *tmpStr1 = [strOne substringWithRange:NSMakeRange(i-1, curLength)];
                
                NSDictionary *dict = [[ReadLocalData defaultReadLocalData] getFaceStrDict];
                NSString *faceStr = [dict objectForKey:tmpStr1];
                
                if (faceStr != nil) {
                    NSString *strOness = [strOne substringToIndex:i-1];
                    
                    strOness = [strOness stringByAppendingString:strTwo];
                    self.inputView.text = strOness;
                    self.inputView.selectedRange = NSMakeRange(i-1, 0);
                    return ;
                }
            }
        }
        NSString *tmpWZ = [strOne substringToIndex:[strOne length]-1];
        tmpWZ = [tmpWZ stringByAppendingString:strTwo];
        self.inputView.text = tmpWZ;
        self.inputView.selectedRange = NSMakeRange([strOne length]-1, 0);
        return ;
    }else if ([tmpTest isEqualToString:@"#"]){
        for (NSInteger i = ([strOne length]-1); i > 0; i--) {
            NSString *tmpString = [strOne substringWithRange:NSMakeRange(i-1, 1)];
            if ([tmpString isEqualToString:@"#"]) {
                NSInteger curLength = [strOne length] - (i-1);
                NSString *tmpStr1 = [strOne substringWithRange:NSMakeRange(i-1, curLength)];
                for (NSString *matchJumpStr in _matchJumpArray) {
                    if ([LRTools hl_containString:tmpStr1 sourceString:matchJumpStr]) {
                        NSString *strOness = [strOne substringToIndex:i-1];
                        strOness = [strOness stringByAppendingString:strTwo];
                        self.inputView.text = strOness;
                        self.inputView.selectedRange = NSMakeRange(i-1, 0);
                        [self textViewDidChange:self.inputView];
                        [_matchJumpArray removeObject:matchJumpStr];
                        return ;
                    }
                }
            }
        }
        NSString *tmpWZ = [strOne substringToIndex:[strOne length]-1];
        tmpWZ = [tmpWZ stringByAppendingString:strTwo];
        self.inputView.text = tmpWZ;
        self.inputView.selectedRange = NSMakeRange([strOne length]-1, 0);
        return ;
    }else if([tmpTest isEqualToString:@" "]){
        for (NSInteger i = ([strOne length]-1); i > 0; i--) {
            NSString *tmpString = [strOne substringWithRange:NSMakeRange(i-1, 1)];
            if ([tmpString isEqualToString:@" "]) {
                NSString *tmpWZ = [strOne substringToIndex:[strOne length]-1];
                tmpWZ = [tmpWZ stringByAppendingString:strTwo];
                self.inputView.text = tmpWZ;
                self.inputView.selectedRange = NSMakeRange([strOne length]-1, 0);
                return;
            }else if ([tmpString isEqualToString:@"@"]) {
//                NSInteger curLength = [strOne length] - (i-1);
//                NSString *tmpStr1 = [strOne substringWithRange:NSMakeRange(i-1, curLength)];
//                for (BBSFuns *model in _atModelArray) {
//                    NSString *atStr = [NSString stringWithFormat:@"@%@ ",model.name];
//                    if ([atStr isEqualToString:tmpStr1]) {
                        NSString *strOness = [strOne substringToIndex:i-1];
                        strOness = [strOness stringByAppendingString:strTwo];
                        self.inputView.text = strOness;
                        self.inputView.selectedRange = NSMakeRange(i-1, 0);
                        
                        [self textViewDidChange:self.inputView];
//                        [_atModelArray removeObject:model];
                        return ;
//                    }
//                }
            }
        }
        NSString *tmpWZ = [strOne substringToIndex:[strOne length]-1];
        tmpWZ = [tmpWZ stringByAppendingString:strTwo];
        self.inputView.text = tmpWZ;
        self.inputView.selectedRange = NSMakeRange([strOne length]-1, 0);
        return ;
        
    }
    else{
        NSString *tmpWZ = [strOne substringToIndex:[strOne length]-1];
        tmpWZ = [tmpWZ stringByAppendingString:strTwo];
        self.inputView.text = tmpWZ;
        self.inputView.selectedRange = NSMakeRange([strOne length]-1, 0);
        return ;
    }
    
}
-(void)kanQiuClicked
{

    
}

#pragma mark - UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length) {
        _placeLabel.hidden = YES;
    }else{
        _placeLabel.hidden = NO;
    }
    NSString *lang = textView.textInputMode.primaryLanguage;//键盘输入模式
    static NSInteger length = 0;
    if ([lang isEqualToString:@"zh-Hans"]){
        UITextRange *selectedRange = [textView markedTextRange];
        if (!selectedRange) {//没有有高亮
            length = textView.text.length;
        }else{
            
        }
    }else{
        length = textView.text.length;
    }
    
    NSString *str = textView.text;
    if (length > WordNumMax) {
        
        NSString *str1 = [str substringToIndex:WordNumMax];
//        [ProgressHUD showWithStatus:[NSString stringWithFormat:@"最多%d字",WordNumMax]];
        textView.text = str1;
        length = WordNumMax;
    }
    self.wordCountLabel.text = [NSString stringWithFormat:@"%ld/%d",(long)length,WordNumMax];
    
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (!textView.window.isKeyWindow) {
        [textView.window makeKeyAndVisible];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSString *lang = textView.textInputMode.primaryLanguage;//键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]&&[text isEqualToString:@""]){
        UITextRange *selectedRange = [textView markedTextRange];
        if (selectedRange) {//有高亮
            return YES;
        }
    }
    if ([text isEqualToString:@""]) {//替换是空的时候说明是删除呢
        NSString *str = textView.text;
        if (range.length!=1) {
            return YES;
        }else{
            if (([str length]-1) == range.location) {
                [self deleteSpecialStrAtLast];
            }else{//当在中间删除的时候
                [self deleteSpecialStrAtCenter:str range:range];
            }
            [self textViewDidChange:self.inputView];
            return  NO;
        }
    }else{//替换有值的时候是在输入
        return YES;
    }
    return YES;
}
#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {//相册
        [self toSelectedPic];
    }else if(buttonIndex == 1){//拍照
        [self toCamera];
    }else{
        [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
    }
}
-(void)toSelectedPic{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    __weak BBSEditingViewController *this = self;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        if (assets.count) {
            if (assets.count+this.imgModelArray.count>9) {
                //                [ZHLTools showAlertViewWithString:@"最多可以选择9张图片"];
            }else{
                [this getSourcePhotoWithAsset:assets andIndex:0 andPhotos:photos];
            }
        }

    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
}
-(void)getSourcePhotoWithAsset:(NSArray *)assets andIndex:(NSInteger)index andPhotos:(NSArray*)photos{

    id asset = [assets objectAtIndex:index];
    __weak BBSEditingViewController *this = self;
    __block NSInteger tempNum = index;

    [[TZImageManager manager] getOriginalPhotoWithAsset:asset completion:^(UIImage *photo, NSDictionary *info) {
        tempNum++;
        
        if (tempNum<=assets.count) {
            NSLog(@"assetTempNum=====%ld",tempNum);
            NSData *data = UIImageJPEGRepresentation(photo, 1);
            NSLog(@"%ld",(unsigned long)data.length);
            CTPhotoModel *model = [[CTPhotoModel alloc] init];
            model.thumbnailImage = [photos objectAtIndex:index];
            model.largeImage = photo;
            model.type = @"1";
            model.deleteBtnHidden = NO;
            model.isRedBag = NO;
            model.isAdd = NO;
            [this.imgModelArray addObject:model];
        }
        if (tempNum>=assets.count) {
            [this.myTableView reloadData];
        }else{
            [this getSourcePhotoWithAsset:assets andIndex:tempNum andPhotos:photos];
        }
    }];
}
-(void)toCamera{
    if (_imgModelArray.count==9) {
//        [ZHLTools showAlertViewWithString:@"最多选择9张图片"];
        return;
    }
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *pick = [[UIImagePickerController alloc] init];
        pick.delegate = self;
        pick.allowsEditing = YES;
        pick.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:pick animated:YES completion:nil];
    }else{
//        [ZHLTools showAlertViewWithString:@"无相机访问权限"];
    }
}
#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    NSLog(@"%@",image);
    CTPhotoModel *model = [[CTPhotoModel alloc] init];
    model.thumbnailImage = image;
    model.largeImage = image;
    model.type = @"1";
    model.deleteBtnHidden = NO;
    model.isAdd = NO;
    model.isRedBag = NO;
    [_imgModelArray addObject:model];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.myTableView reloadData];
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - setter methods
-(void)setHasSelectedRedBag:(bool)hasSelectedRedBag{
    _hasSelectedRedBag = hasSelectedRedBag;
    if (_hasSelectedRedBag) {
        NSLog(@"YES");
    }else{
        NSLog(@"NO");
    }
    [self.myTableView reloadData];
}
@end
