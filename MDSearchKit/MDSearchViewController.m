//
//  MDSearchViewController.m
//  MDUI
//
//  Created by 李永杰 on 2019/7/24.
//

#import "MDSearchViewController.h"
#import "MDSearchConst.h"

@interface MDSearchViewController ()<UISearchBarDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView                *contentView;

@property (nonatomic, copy)   NSArray               *hots;

@property (nonatomic, strong) NSMutableArray        *histories;

@property (nonatomic, strong) NSMutableArray        *datas;

@property (nonatomic, strong) NSMutableArray        *sectionModels;

@end

@implementation MDSearchViewController

#pragma mark life

+(instancetype)searchViewControllerWithHotSearches:(NSArray *)hots histories:(NSMutableArray *)histories datas:(NSMutableArray *)datas placeholder:(NSString *)placeholder {
    MDSearchViewController *searchVC = [[self alloc] init];
    searchVC.hots = hots;
    searchVC.histories = histories;
    searchVC.datas = datas;
    searchVC.searchBar.placeholder = placeholder;
    [searchVC configUI];

    return searchVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self initProperty];
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    if (!self.searchBar.isFirstResponder) {
        [self.searchBar becomeFirstResponder];
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchBar resignFirstResponder];
}
#pragma mark private
-(void)configUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.navigationBarView];
    [self.navigationBarView addSubview:self.searchBar];
    [self initSearchBar];
    
    [self.view addSubview:self.contentView];
    
    self.mainVC.view.frame = self.contentView.bounds;
    [self.contentView addSubview:self.mainVC.view];
    [self addChildViewController:self.mainVC];
    
    self.suggestVC.view.frame = self.contentView.bounds;
    [self.contentView addSubview:self.suggestVC.view];
    [self addChildViewController:self.suggestVC];
    
    self.resultVC.view.frame = self.contentView.bounds;
    [self.contentView addSubview:self.resultVC.view];
    [self addChildViewController:self.resultVC];
    
    self.resultVC.view.hidden = YES;
    self.suggestVC.view.hidden = YES;
    [self.contentView bringSubviewToFront:self.mainVC.view];
    
}
-(void)initProperty {
    self.haveSuggest = YES;
    self.showResult  = YES;
    self.textSpace = 10;
}
-(void)initSearchBar {
    
    UIButton *cancelButton = [_searchBar valueForKey:@"cancelButton"];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.cancelButton = cancelButton;
    for (UIView *view in self.searchBar.subviews.lastObject.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            view.backgroundColor = [UIColor colorWithRed:234/255.0 green:235/255.0 blue:237/255.0 alpha:1];
            view.layer.contents = nil;
            view.hidden = YES;
            view.layer.borderColor = [UIColor whiteColor].CGColor;
            view.layer.borderWidth = 1;
            break;
        }
    }
    [self setTextFieldBackgroundColor:[UIColor colorWithRed:234/255.0 green:235/255.0 blue:237/255.0 alpha:1]];
}
// 跳转到结果页
- (void)pushToSearchResultView:(NSString *)searchText indexPath:(NSIndexPath *)indexPath type:(MDSearchType)type {
    self.searchBar.text = searchText;
    
    if (self.showResult) {
        if (type == MDSearchTypeOther) { // other,直接跳转到下一页
            self.didClickItemOtherBlock(self, searchText, indexPath, type);
            return;
        }
        [self showRelatedView:MDSearchTypeResult];
        // 顺便block出去,请求网络数据
        if (self.didClickItemResultBlock) {
            self.didClickItemResultBlock(self, searchText, indexPath, type);
        }
    }else {
        if (type == MDSearchTypeOther) { // other,直接跳转到下一页
            self.didClickItemOtherBlock(self, searchText, indexPath, type);
            return;
        }
        if (self.didClickItemNoResultBlock) { // 跳转到下一页展示，block出去，组件内部不做处理
            self.didClickItemNoResultBlock(self, searchText, indexPath, type);
        }
    }
}

- (void)showRelatedView:(MDSearchType)type {
    if (type == MDSearchTypeMain) {
        self.mainVC.view.hidden = NO;
        [self.contentView bringSubviewToFront:self.mainVC.view];
        self.suggestVC.view.hidden = YES;
        self.resultVC.view.hidden = YES;
    } else if (type == MDSearchTypeSuggest) {
        self.suggestVC.view.hidden = NO;
        [self.contentView bringSubviewToFront:self.suggestVC.view];
        self.mainVC.view.hidden = YES;
        self.resultVC.view.hidden = YES;
    } else if (type == MDSearchTypeResult) {
        self.resultVC.view.hidden = NO;
        [self.contentView bringSubviewToFront:self.resultVC.view];
        self.suggestVC.view.hidden = YES;
        self.mainVC.view.hidden = YES;
    }
}

- (void)didClickResult:(NSIndexPath *)indexPath resultText:(NSString *)resultText {
    if (self.resultBlock) {
        self.resultBlock(self, resultText, indexPath);
    }
}
- (void)setHistoryArrWithSearchText:(NSString *)searchText {
    if ([searchText isEqualToString:@""]) return;
    for (int i = 0; i < self.histories.count; i++) {
        if ([_histories[i] isEqualToString:searchText]) {
            [_histories removeObjectAtIndex:i];
            break;
        }
    }
    
    if (_maxHistoryCount != 0) { // 做下历史最大限制数
        if (_histories.count >= _maxHistoryCount) {
            [_histories removeLastObject];
        }
    }
    [_histories insertObject:searchText atIndex:0];
    [NSKeyedArchiver archiveRootObject:_histories toFile:KMDHistorySearchPath];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kMDHistoryNotificationName object:nil userInfo:@{@"history":_histories}];
}
- (void)searchCancelResponder {
    [self.searchBar resignFirstResponder];
}
#pragma mark input delegate
// 文字改变,切换view，默认搜索页/建议页/结果页
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchBar.text == nil || [searchBar.text length] <= 0) { // 依然显示默认页
        [self showRelatedView:MDSearchTypeMain];
    } else {
        if (_haveSuggest) {
            [self showRelatedView:MDSearchTypeSuggest];
            // 模糊查找
            if ([self.delegate respondsToSelector:@selector(searchViewController:searchTextDidChange:searchText:)]) {
                [self.delegate searchViewController:self searchTextDidChange:searchBar searchText:searchText];
            }
        } else {
            [self showRelatedView:MDSearchTypeMain];
        }
    }
}
// 点击取消
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}
// 键盘点击搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self setHistoryArrWithSearchText: searchBar.text];
    [self pushToSearchResultView:searchBar.text indexPath:nil type:MDSearchTypeMain];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}
#pragma mark 手势代理
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"] || [touch.view isDescendantOfView:self.mainVC.collectionView]) {
        if ([touch.view isKindOfClass:[UICollectionView class]]) {
            return YES;
        }
        return NO; // 响应tableView和collectionView点击事件
    } else {
        return YES;// 响应手势
    }
}
#pragma mark - set
-(void)setSearhIcon:(UIImage *)image {
    [self.searchBar setImage:image forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
}
- (void)setTextFieldBackgroundColor:(UIColor *)color {
    UITextField *searchTextField = [self.searchBar valueForKey:@"searchField"];
    
    searchTextField.backgroundColor = color;
}
-(void)setSuggests:(NSArray *)suggests {
    if (self.haveSuggest) {
        self.suggestVC.suggests = suggests;
    }
}
- (void)setTextAlignment:(NSTextAlignment)alignment {
    _mainVC.textAlignment = alignment;
}
#pragma mark lazy
- (UIView *)navigationBarView {
    if (!_navigationBarView) {
        _navigationBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMDSearchScreenWidth, kMDSearchStatusBarHeight + kMDSearchNavBarHeight)];
    }
    return _navigationBarView;
}
- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(kMDSearchBarLeftMargin, kMDSearchStatusBarHeight + kMDSearchBarTopMargin, self.navigationBarView.frame.size.width - 2*kMDSearchBarLeftMargin, self.navigationBarView.frame.size.height - kMDSearchStatusBarHeight - 2*kMDSearchBarTopMargin)];
        _searchBar.delegate = self;
        _searchBar.showsCancelButton = YES;
    }
    return _searchBar;
}
-(UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.navigationBarView.frame), kMDSearchScreenWidth, self.view.frame.size.height - CGRectGetHeight(self.navigationBarView.frame))];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchCancelResponder)];
        tap.delegate = self;
        [_contentView addGestureRecognizer:tap];
    }
    return _contentView;
}
-(MDSearchMainViewController *)mainVC {
    if (!_mainVC) {
        kMDSearch_WeakSelf;
        _mainVC = [MDSearchMainViewController searchMainViewControllerWithHotSearches:self.hots histories:self.histories datas:self.datas didSearchBlock:^(NSString *mainText, NSIndexPath *indexPath, NSInteger type) {
            if (weakSelf.saveAll) {
                [weakSelf setHistoryArrWithSearchText:mainText];
            }
            [weakSelf.searchBar resignFirstResponder];
            [weakSelf pushToSearchResultView:mainText indexPath:indexPath type:type];
        }];
        _mainVC.textSpace = self.textSpace;
    }
    return _mainVC;
}
-(MDSearchSuggestViewController *)suggestVC {
    if (!_suggestVC) {
        kMDSearch_WeakSelf;
        _suggestVC = [MDSearchSuggestViewController searchSuggestionViewControllerWithIndexPathBlock:^(NSString *suggestText, NSIndexPath *indexPath, NSInteger type) {
            
            if (weakSelf.saveAll) {
                [weakSelf setHistoryArrWithSearchText:suggestText];
            }
            [weakSelf.searchBar resignFirstResponder];
            [weakSelf pushToSearchResultView:suggestText indexPath:indexPath type:type];
        }];
    }
    return _suggestVC;
}
-(MDSearchResultViewController *)resultVC {
    if (!_resultVC) {
        kMDSearch_WeakSelf;
        _resultVC = [MDSearchResultViewController searchResultViewControllerWithIndexPathBlock:^(NSString *resultText, NSIndexPath *indexPath) {
            [weakSelf didClickResult:indexPath resultText:resultText];
        }];
    }
    return _resultVC;
}
- (NSMutableArray *)histories {
    if (!_histories) {
        _histories = [NSKeyedUnarchiver unarchiveObjectWithFile:KMDHistorySearchPath];
        if (!_histories) {
            self.histories = [NSMutableArray array];
        }
    }
    return _histories;
}
- (void)dealloc {
    NSLog(@"释放了");
}
@end
