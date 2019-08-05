//
//  MDSearchSuggestViewController.h
//  MDUI
//
//  Created by 李永杰 on 2019/7/24.
//
// 继承于UITableViewController，市场上大多数“建议view”都是tableView

#import <UIKit/UIKit.h>

typedef void(^MDSearchSuggestionSelectedIndexPathBlock)(NSString *suggestText, NSIndexPath *indexPath, NSInteger    type);

// 这个接口，让外界提供数据源
@protocol MDSearchSuggestionViewDataSource <NSObject>

- (NSInteger)searchSuggestionView:(UITableView *)searchSuggestionView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)searchSuggestionView:(UITableView *)searchSuggestionView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@optional
- (NSInteger)numberOfSectionsInSearchSuggestionView:(UITableView *)searchSuggestionView;
- (CGFloat)searchSuggestionView:(UITableView *)searchSuggestionView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface MDSearchSuggestViewController : UIViewController

@property (nonatomic, copy)     NSArray     *suggests;
@property (nonatomic, weak)     id<MDSearchSuggestionViewDataSource>        dataSource;
@property (nonatomic, copy)     MDSearchSuggestionSelectedIndexPathBlock    selectedIndexPathBlock;
@property (nonatomic, strong)   UITableView *tableView;

+(instancetype)searchSuggestionViewControllerWithIndexPathBlock:(MDSearchSuggestionSelectedIndexPathBlock )indexPathBlock;

@end
