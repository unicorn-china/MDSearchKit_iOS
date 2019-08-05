//
//  MDSearchResultViewController.h
//  MDUI
//
//  Created by 李永杰 on 2019/7/24.
//

#import <UIKit/UIKit.h>

typedef void(^MDSearchResultSelectedIndexPathBlock)(NSString *resultText, NSIndexPath *indexPath);

// 这个接口，让外界提供数据源
@protocol MDSearchResultViewDataSource <NSObject>

- (NSInteger)searchResultView:(UITableView *)searchResultView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)searchResultView:(UITableView *)searchResultView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@optional
- (NSInteger)numberOfSectionsInSearchResultView:(UITableView *)searchResultView;
- (CGFloat)searchResultView:(UITableView *)searchResultView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)searchResultView:(UITableView *)searchResultView heightForHeaderInSection:(NSInteger)section;
- (UIView *)searchResultView:(UITableView *)searchResultView viewForHeaderInSection:(NSInteger)section;
 
@end

@interface MDSearchResultViewController : UIViewController

@property (nonatomic, strong)   NSMutableArray                          *results;
@property (nonatomic, weak)     id<MDSearchResultViewDataSource>        dataSource;
@property (nonatomic, copy)     MDSearchResultSelectedIndexPathBlock    selectedIndexPathBlock;
@property (nonatomic, strong)   UITableView *tableView;

+(instancetype)searchResultViewControllerWithIndexPathBlock:(MDSearchResultSelectedIndexPathBlock )indexPathBlock;


@end
