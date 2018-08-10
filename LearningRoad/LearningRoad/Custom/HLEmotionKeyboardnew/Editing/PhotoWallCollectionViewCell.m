//
//  PhotoWallCollectionViewCell.m
//  HandicapWin
//
//  Created by CH10 on 16/5/9.
//  Copyright © 2016年 赢盘. All rights reserved.
//

#import "PhotoWallCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIView+Layout.h"

@interface PhotoWallCollectionViewCell ()<UIGestureRecognizerDelegate,UIScrollViewDelegate,UIActionSheetDelegate>{
    CGFloat _aspectRatio;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *imageContainerView;
@end

@implementation PhotoWallCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(0, 0, self.width, self.height);
        _scrollView.bouncesZoom = YES;
        _scrollView.maximumZoomScale = 2.5;
        _scrollView.minimumZoomScale = 1.0;
        _scrollView.multipleTouchEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.scrollsToTop = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _scrollView.delaysContentTouches = NO;
        _scrollView.canCancelContentTouches = YES;
        _scrollView.alwaysBounceVertical = NO;
        [self addSubview:_scrollView];
        
        _imageContainerView = [[UIView alloc] init];
        _imageContainerView.clipsToBounds = YES;
        [_scrollView addSubview:_imageContainerView];
        
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.500];
        _imageView.clipsToBounds = YES;
        _imageView.userInteractionEnabled = YES;
        [_imageContainerView addSubview:_imageView];
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGesture:)];
//        longGesture.minimumPressDuration=2;
        [_imageView addGestureRecognizer:longGesture];
//        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
//        [self addGestureRecognizer:tap1];
//        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
//        tap2.numberOfTapsRequired = 2;
//        [tap1 requireGestureRecognizerToFail:tap2];
//        [self addGestureRecognizer:tap2];
    }
    return self;
}
-(void)longGesture:(UILongPressGestureRecognizer*)gesture{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存图片", nil];
        [sheet showInView:self];
    }
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {//保存图片
        UIImage *img = _imageView.image;
        //把图片保存到相册
        UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [LRTools hl_showAlertViewWithString:@"保存失败"];
        

    }else{
        [LRTools hl_showAlertViewWithString:@"保存成功"];
    }
}
- (void)setModel:(CTPhotoModel*)model {
    _model = model;
    if (_model) {
        [_scrollView setZoomScale:1.0 animated:NO];
        __weak PhotoWallCollectionViewCell *this = self;
        if ([_model.type isEqualToString:@"0"]) {
            NSString *str = nil;
            if (model.largeImgUrl.length) {
                str = model.largeImgUrl;
            }else{
                str = model.thumbnailImgUrl;
            }
            NSString *url = nil;
            if (![str hasPrefix:@"http"]) {
                url = [NSString stringWithFormat:@"%@%@",@"",str];
            }else{
                url = model.largeImgUrl;
            }
            __block UIProgressView *pv =[[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
            CGFloat w=200,h=20,x=SCREEN_WIDTH/2.0-w/2.0,y=self.contentView.height/2.0-h/2.0;
            pv.frame = CGRectMake(x, y, w, h);
            pv.backgroundColor = [UIColor cyanColor];
            pv.progress = 0;
            [self.contentView addSubview:pv];
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageDelayPlaceholder progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                float currentProgress = (float)receivedSize/(float)expectedSize;
                pv.progress = currentProgress;
//                [this.contentView addSubview:pv];
                [this.contentView bringSubviewToFront:pv];
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [pv removeFromSuperview];
                [this resizeSubviews];
            }];
        }else if([_model.type isEqualToString:@"1"]){
            _imageView.image = _model.largeImage;
            [_scrollView setZoomScale:1.0 animated:NO];
            [self resizeSubviews];
        }
    }
}
-(void)setImg:(UIImage *)img{
    _img = img;
    _imageView.image = _img;
    [_scrollView setZoomScale:1.0 animated:NO];
    [self resizeSubviews];
}
- (void)resizeSubviews {
    _imageContainerView.origin = CGPointZero;
    _imageContainerView.width = self.width;
    
    UIImage *image = _imageView.image;
    if (image.size.height / image.size.width > self.height / self.width) {
        _imageContainerView.height = floor(image.size.height / (image.size.width / self.width));
    } else {
        CGFloat height = image.size.height / image.size.width * self.width;
        if (height < 1 || isnan(height)) height = self.height;
        height = floor(height);
        _imageContainerView.height = height;
        _imageContainerView.centerY = self.height / 2;
    }
    if (_imageContainerView.height > self.height && _imageContainerView.height - self.height <= 1) {
        _imageContainerView.height = self.height;
    }
    _scrollView.contentSize = CGSizeMake(self.width, MAX(_imageContainerView.height, self.height));
    [_scrollView scrollRectToVisible:self.bounds animated:NO];
    _scrollView.alwaysBounceVertical = _imageContainerView.height <= self.height ? NO : YES;
    _imageView.frame = _imageContainerView.bounds;
}

#pragma mark - UITapGestureRecognizer Event

- (void)doubleTap:(UITapGestureRecognizer *)tap {
    if (_scrollView.zoomScale > 1.0) {
        [_scrollView setZoomScale:1.0 animated:YES];
    } else {
        CGPoint touchPoint = [tap locationInView:self.imageView];
        CGFloat newZoomScale = _scrollView.maximumZoomScale;
        CGFloat xsize = self.frame.size.width / newZoomScale;
        CGFloat ysize = self.frame.size.height / newZoomScale;
        [_scrollView zoomToRect:CGRectMake(touchPoint.x - xsize/2, touchPoint.y - ysize/2, xsize, ysize) animated:YES];
    }
}

- (void)singleTap:(UITapGestureRecognizer *)tap {
//    if (self.singleTapGestureBlock) {
//        self.singleTapGestureBlock();
//    }
}

#pragma mark - UIScrollViewDelegate

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageContainerView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat offsetX = (scrollView.width > scrollView.contentSize.width) ? (scrollView.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.height > scrollView.contentSize.height) ? (scrollView.height - scrollView.contentSize.height) * 0.5 : 0.0;
    self.imageContainerView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY);
}

@end
