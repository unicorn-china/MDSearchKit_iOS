//
//  MDHuyaCollectionReusableView.h
//  MDUI_Example
//
//  Created by 李永杰 on 2019/7/29.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MDHuyaCollectionReusableViewDelegate <NSObject>

- (void)clearHistory;

@end

@interface MDHuyaCollectionReusableView : UICollectionReusableView


@property (nonatomic, strong) UILabel   *titleLabel;

@property (nonatomic, strong) UIButton  *rightButton;

@property (nonatomic, copy)   NSString  *rightTitle;

@property (nonatomic, assign) BOOL      isHistory; 

@property (nonatomic, weak)     id<MDHuyaCollectionReusableViewDelegate> delegate;

@end
