//
//  MDSearchSuggestViewController.m
//  MDUI
//
//  Created by 李永杰 on 2019/7/24.
//

#import "MDSearchSuggestViewController.h"
#import "MDSearchViewController.h"

@interface MDSearchSuggestViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation MDSearchSuggestViewController

+(instancetype)searchSuggestionViewControllerWithIndexPathBlock:(MDSearchSuggestionSelectedIndexPathBlock )indexPathBlock {
    MDSearchSuggestViewController *suggestVC = [[MDSearchSuggestViewController alloc]init];
    suggestVC.selectedIndexPathBlock = indexPathBlock;
    return suggestVC;
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
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInSearchSuggestionView:)]) {
        return [self.dataSource numberOfSectionsInSearchSuggestionView:tableView];
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.dataSource respondsToSelector:@selector(searchSuggestionView:numberOfRowsInSection:)]) {
        return [self.dataSource searchSuggestionView:tableView numberOfRowsInSection:section];
    }
    return self.suggests.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.dataSource respondsToSelector:@selector(searchSuggestionView:cellForRowAtIndexPath:)]) {
        UITableViewCell *cell= [self.dataSource searchSuggestionView:tableView cellForRowAtIndexPath:indexPath];
        if (cell) return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellId"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellId"];
    }
    cell.textLabel.text = self.suggests[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataSource respondsToSelector:@selector(searchSuggestionView:heightForRowAtIndexPath:)]) {
        return [self.dataSource searchSuggestionView:tableView heightForRowAtIndexPath:indexPath];
    }
    return 44.0;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.selectedIndexPathBlock) {
        self.selectedIndexPathBlock(self.suggests[indexPath.row],indexPath, MDSearchTypeSuggest);
    }
}
#pragma mark set get
- (void)setSuggests:(NSArray *)suggests {
    _suggests = suggests;
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
