//
//  MDSearchViewController.h
//  MDUI
//
//  Created by 李永杰 on 2019/7/24.
//

#import <UIKit/UIKit.h>
#import "MDSearchConst.h"
#import "MDSearchMainViewController.h"
#import "MDSearchSuggestViewController.h"
#import "MDSearchResultViewController.h"

typedef enum : NSInteger{
    MDSearchTypeMain = 0,
    MDSearchTypeSuggest,
    MDSearchTypeResult,
    MDSearchTypeOther
} MDSearchType;

@class MDSearchViewController;
typedef void(^MDSearchDidClickItemBlock)(MDSearchViewController *search, NSString *searchText, NSIndexPath *indexPath, MDSearchType type);
typedef void(^MDSearchDidClickItemResultBlock)(MDSearchViewController *search, NSString *searchText, NSIndexPath *indexPath, MDSearchType type);
typedef void(^MDSearchDidClickItemOtherBlock)(MDSearchViewController *search, NSString *searchText, NSIndexPath *indexPath, MDSearchType type);


typedef void(^MDSearchResultBlock)(MDSearchViewController *search, NSString *result, NSIndexPath *indexPath);

@protocol MDSearchViewControllerDelegate <NSObject>

/**
 监听文字改变

 @param searchViewController 主控制器
 @param searchBar 搜索框
 @param searchText 文字
 */
- (void)searchViewController:(MDSearchViewController *)searchViewController
         searchTextDidChange:(UISearchBar *)searchBar
                  searchText:(NSString *)searchText;
@end
 
@interface MDSearchViewController : UIViewController

/// 默认间隔
@property (nonatomic, assign) CGFloat               textSpace;
/// 点击任何都保存到历史
@property (nonatomic, assign) BOOL                  saveAll;
/**
 搜索导航
 */
@property (nonatomic, strong) UIView                *navigationBarView;
/*
 搜索框
 */
@property (nonatomic, strong) UISearchBar           *searchBar;
/**
 取消按钮
 */
@property (nonatomic, strong) UIButton              *cancelButton;
/**
 是否有模糊查找
 */
@property (nonatomic, assign) BOOL                                  haveSuggest;
/**
 搜索页
 */
@property (nonatomic, strong) MDSearchMainViewController            *mainVC;
/**
 模糊查找
 */
@property (nonatomic, strong) MDSearchSuggestViewController         *suggestVC;
/**
 结果展示
 */
@property (nonatomic, strong) MDSearchResultViewController          *resultVC;

/**
 文字改变代理
 */
@property (nonatomic, weak)   id<MDSearchViewControllerDelegate>    delegate;
/**
 是否在当前页展示结果
 */
@property (nonatomic, assign) BOOL                                  showResult;
/**
 haveResult = NO,点击搜索item,不展示结果
 */
@property (nonatomic, copy)   MDSearchDidClickItemBlock             didClickItemNoResultBlock;
/**
 haveResult = YES,展示结果
 */
@property (nonatomic, copy)   MDSearchDidClickItemResultBlock       didClickItemResultBlock;
/**
 点击其他类型item
 */
@property (nonatomic, copy)   MDSearchDidClickItemOtherBlock        didClickItemOtherBlock;
/**
 结果页点击item
 */
@property (nonatomic, copy)   MDSearchResultBlock                   resultBlock;

@property (nonatomic, assign) NSInteger                             maxHistoryCount;

#pragma mark set方法
- (void)setSearhIcon:(UIImage *)image;

- (void)setTextFieldBackgroundColor:(UIColor *)color;
// 从数据库中获取
- (void)setSuggests:(NSArray *)suggests;
// 默认文字对齐
- (void)setTextAlignment:(NSTextAlignment)alignment;

+(instancetype)searchViewControllerWithHotSearches:(NSArray *)hots histories:(NSMutableArray *)histories datas:(NSMutableArray *)datas placeholder:(NSString *)placeholder;
@end

