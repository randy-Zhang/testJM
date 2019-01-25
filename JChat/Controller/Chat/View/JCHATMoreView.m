//
//  JPIMMore.m
//  JPush IM
//
//  Created by Apple on 14/12/30.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "JCHATMoreView.h"
#import "JChatConstants.h"
#import "FaceCell.h"

@implementation JCHATMoreView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (void)drawRect:(CGRect)rect {
  
}

- (IBAction)photoBtnClick:(id)sender {
  
  if (self.delegate &&[self.delegate respondsToSelector:@selector(photoClick)]) {
    [self.delegate photoClick];
  }
}
- (IBAction)cameraBtnClick:(id)sender {
  if (self.delegate &&[self.delegate respondsToSelector:@selector(cameraClick)]) {
    [self.delegate cameraClick];
  }
}
@end

@interface JCHATMoreViewContainer()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

static NSString *const cellId = @"faceCell";

@implementation JCHATMoreViewContainer

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
  }
  return self;
}

- (void)awakeFromNib {
  [super awakeFromNib];
  
    [self.collectionView reloadData];
    self.collectionView.hidden = YES;
    
    
    _moreView = NIB(JCHATMoreView);
    
    _moreView.frame =CGRectMake(0, 0, kScreenWidth, 227);
    
    
    //  [_toolbar drawRect:_toolbar.frame];
    
    //  _toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:_moreView];
    _moreView.hidden = YES;
}

- (void)setMoreViewType:(MoreViewType)moreViewType {
    _moreViewType = moreViewType;
    
    if (self.moreViewType == MV_FaceType) {
        
        self.collectionView.hidden = NO;
        _moreView.hidden = YES;
    }else{
        
        self.collectionView.hidden = YES;
        _moreView.hidden = NO;
    }
}

#pragma mark - CollectionView Delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FaceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((CGRectGetWidth(self.frame) - 5) / 5.f, 113);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

// 设置最小行间距，也就是前一行与后一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.1f;
}

// 设置最小列间距，也就是左行与右一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.1f;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    NSLog(@"点击了%zd", indexPath.item);
}


#pragma mark - lazy
- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 227) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerNib:[UINib nibWithNibName:@"FaceCell" bundle:nil] forCellWithReuseIdentifier:cellId];
         
        [self addSubview:_collectionView];
    }
    return _collectionView;
}

@end

