//
//  MDHuYaCollectionViewCell.h
//  MDUI_Example
//
//  Created by 李永杰 on 2019/7/27.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDHuYaHistoryItemView : UIView

@property (nonatomic, copy)   NSString                  *title;

@property (nonatomic, strong) UILabel                   *titleLabel;

@end

@interface MDHuYaHotItemView : UIView

@property (nonatomic, copy)   NSString                  *title;

@property (nonatomic, assign) NSInteger                 row;

@property (nonatomic, strong) UILabel                   *scoreLabel;

@property (nonatomic, strong) UILabel                   *titleLabel;

@end

@interface MDHuYaNewsItemView : UIView

@property (nonatomic, copy)   NSString                  *title;

@property (nonatomic, strong) UILabel                   *titleLabel;

@end

@interface MDHuYaCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) NSMutableArray            *histories;

@property (nonatomic, assign) NSInteger                 section;

@property (nonatomic, assign) NSInteger                 row;

@property (nonatomic, copy)   NSString                  *title;

@property (nonatomic, strong) MDHuYaHistoryItemView     *historyView;

@property (nonatomic, strong) MDHuYaHotItemView         *hotView;

@property (nonatomic, strong) MDHuYaNewsItemView        *newsView;

@end

