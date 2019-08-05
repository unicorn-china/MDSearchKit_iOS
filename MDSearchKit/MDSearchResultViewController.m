//
//  MDSearchResultViewController.m
//  MDUI
//
//  Created by 李永杰 on 2019/7/24.
//

#import "MDSearchResultViewController.h"
#import "MDSearchResultBaseModel.h"

@interface MDSearchResultViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation MDSearchResultViewController

+ (instancetype)searchResultViewControllerWithIndexPathBlock:(MDSearchResultSelectedIndexPathBlock)indexPathBlock {
    MDSearchResultViewController *resultVC = [[MDSearchResultViewController alloc]init];
    resultVC.selectedIndexPathBlock = indexPathBlock;
    return resultVC;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}
-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}
#pragma mark 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInSearchResultView:)]) {
        return [self.dataSource numberOfSectionsInSearchResultView:tableView];
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.dataSource respondsToSelector:@selector(searchResultView:numberOfRowsInSection:)]) {
        return [self.dataSource searchResultView:tableView numberOfRowsInSection:section];
    }
    return self.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.dataSource respondsToSelector:@selector(searchResultView:cellForRowAtIndexPath:)]) {
        UITableViewCell *cell= [self.dataSource searchResultView:tableView cellForRowAtIndexPath:indexPath];
        if (cell) return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellId"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellId"];
    }
    MDSearchResultBaseModel *resultModel = self.results[indexPath.row];
    cell.textLabel.text = resultModel.resultName;
    cell.textLabel.textColor = resultModel.uiModel.textColor;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataSource respondsToSelector:@selector(searchResultView:heightForRowAtIndexPath:)]) {
        return [self.dataSource searchResultView:tableView heightForRowAtIndexPath:indexPath];
    }
    MDSearchResultBaseModel *resultModel = self.results[indexPath.row];
    return resultModel.uiModel.rowHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([self.dataSource respondsToSelector:@selector(searchResultView:viewForHeaderInSection:)]) {
        [self.dataSource searchResultView:tableView viewForHeaderInSection:section];
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self.dataSource respondsToSelector:@selector(searchResultView:heightForHeaderInSection:)]) {
        [self.dataSource searchResultView:tableView heightForHeaderInSection:section];
    }
    return 0;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.selectedIndexPathBlock) {
        self.selectedIndexPathBlock(self.results[indexPath.row],indexPath);
    }
}
#pragma mark set get
- (void)setResults:(NSMutableArray *)results {
    _results = results;
    [self.tableView reloadData];
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCellId"];
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _tableView;
}
@end
