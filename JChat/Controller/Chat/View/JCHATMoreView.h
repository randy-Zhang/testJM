//
//  JPIMMore.h
//  JPush IM
//
//  Created by Apple on 14/12/30.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

typedef NS_ENUM(NSUInteger, MoreViewType) {
    MV_FaceType,//表情
    MV_FunctionType,//功能
};

#import <UIKit/UIKit.h>
@protocol AddBtnDelegate <NSObject>
@optional
- (void)photoClick;
- (void)cameraClick;
@end
@interface JCHATMoreView : UIView
@property (weak, nonatomic) IBOutlet UIButton *photoBtn;
@property (weak, nonatomic) IBOutlet UIButton *cameraBtn;
@property (assign, nonatomic)  id<AddBtnDelegate>delegate;

@end


@interface JCHATMoreViewContainer : UIView

/** 视图类型 */
@property (nonatomic, assign) MoreViewType moreViewType;

@property (strong, nonatomic) JCHATMoreView *moreView;

/** collectionView */
@property (nonatomic, strong) UICollectionView *collectionView;

@end
