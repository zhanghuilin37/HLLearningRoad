//
//  FacePackageView.m
//  demo
//
//  Created by Zhl on 16/10/10.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import "FacePackageView.h"
#import "FacePackageViewCell.h"
@interface FacePackageView ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)UIButton *sendBtn;
@property(nonatomic,strong)UICollectionView *packageCollectionView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation FacePackageView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        

        
        [self addSubview:self.addBtn];
        [self addSubview:self.sendBtn];
        [self addSubview:self.packageCollectionView];
    }
    return self;
}
#pragma mark - Actions
-(void)addBtnClick{
    
}
-(void)sendBtnClick{
    
}
#pragma getter methods
-(UIButton *)addBtn{
    if (_addBtn == nil) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
        _addBtn.backgroundColor = [UIColor whiteColor];
        _addBtn.frame = CGRectMake(0, 0, 40, 40);
        [_addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(self.addBtn.right-1, 0, 1, _addBtn.height)];
        line.backgroundColor = [UIColor grayColor];
        [_addBtn addSubview:line];
    }
    return _addBtn;
}
-(UIButton *)sendBtn{
    if (_sendBtn == nil) {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendBtn.frame = CGRectMake(self.width-60, 0, 60, 40);
        _sendBtn.backgroundColor = [UIColor whiteColor];
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_sendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_sendBtn addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, _sendBtn.height)];
        line.backgroundColor = [UIColor grayColor];
        [_sendBtn addSubview:line];
    }
    return _sendBtn;
}
-(UICollectionView *)packageCollectionView{
    if (_packageCollectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setItemSize:CGSizeMake(40, 40)];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _packageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.addBtn.right, 0, self.width-self.addBtn.width-self.sendBtn.width, self.height) collectionViewLayout:layout];
        _packageCollectionView.delegate = self;
        _packageCollectionView.dataSource = self;
        _packageCollectionView.backgroundColor = [UIColor whiteColor];
        [_packageCollectionView registerClass:[FacePackageViewCell class] forCellWithReuseIdentifier:@"packageCollectionViewIdentifier"];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [_packageCollectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
//        [self collectionView:_packageCollectionView didSelectItemAtIndexPath:indexPath];
    }
    return _packageCollectionView;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FacePackageViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"packageCollectionViewIdentifier" forIndexPath:indexPath];
    cell.imgV.image = [UIImage imageNamed:@"d_hehe"];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.packageClickedIndex) {
        self.packageClickedIndex(indexPath.row);
    }
    NSLog(@"index:%ld",indexPath.row);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
