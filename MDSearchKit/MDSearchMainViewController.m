//
//  MDSearchMainViewController.m
//  MDUI
//
//  Created by 李永杰 on 2019/7/25.
//

#import "MDSearchMainViewController.h"
#import "MDSearchConst.h"
#import "MDSearchViewController.h"

@interface MDSearchMainCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign)   CGFloat    textSpace;

@property (nonatomic, copy)     NSString   *title;

@property (nonatomic, strong)   UILabel   *titleLabel;

@end

@implementation MDSearchMainCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(self.textSpace, 0, self.contentView.bounds.size.width - 2*self.textSpace, self.contentView.bounds.size.height);
}

- (void)configUI {
    self.backgroundColor  = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0f];

    [self.contentView addSubview:self.titleLabel];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = YES;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0f];
    }
    return _titleLabel;
}
@end

@protocol MDSearchMainReusableViewDelegate <NSObject>

- (void)clearHistory;

@end

@interface MDSearchMainReusableView : UICollectionReusableView

@property (nonatomic, strong)   UILabel   *titleLabel;

@property (nonatomic, strong)   UIButton  *clearButton;

@property (nonatomic, copy)     NSString  *title;

@property (nonatomic, assign)   BOOL      isHistory;

@property (nonatomic, assign)   id<MDSearchMainReusableViewDelegate> delegate;

@end

@implementation MDSearchMainReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    [self addSubview:self.titleLabel];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)setIsHistory:(BOOL)isHistory {
    _isHistory = isHistory;
    if (_isHistory) {
        [self addSubview:self.clearButton];
    } else {
        [self.clearButton removeFromSuperview];
    }
}

- (void)didClickClear {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clearHistory)]) {
        [self.delegate clearHistory];
    }
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kMDSearchMainHeaderLeftMargin, kMDSearchMainHeaderTopMargin, 200, kMDSearchMainHeaderHeight - 2*kMDSearchMainHeaderTopMargin)];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UIButton *)clearButton {
    if (!_clearButton) {
        _clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle bundleForClass:[self class]] bundlePath]] pathForResource:@"md_clear" ofType:@"png"];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:filePath]];
        [_clearButton setImage:image forState:UIControlStateNormal];
        CGFloat clearWidth = self.frame.size.height - 2*kMDSearchMainHeaderTopMargin;
        [_clearButton setFrame:CGRectMake(self.frame.size.width - kMDSearchMainHeaderRightMargin - clearWidth, kMDSearchMainHeaderTopMargin, clearWidth, clearWidth)];
        [_clearButton setImageEdgeInsets:UIEdgeInsetsMake(12.5, 25, 12.5, 0)];
        [_clearButton addTarget:self action:@selector(didClickClear) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearButton;
}
@end

@interface MDSearchMainViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MDSearchMainReusableViewDelegate>

@end

@implementation MDSearchMainViewController

#pragma mark life
+ (instancetype)searchMainViewControllerWithHotSearches:(NSArray *)hots histories:(NSMutableArray *)histories datas:(NSMutableArray *)datas didSearchBlock:(MDSearchMainSelectedIndexPathBlock)block {
    
    MDSearchMainViewController *mainVC = [[MDSearchMainViewController alloc]init];
    mainVC.selectedIndexPathBlock = block;
    mainVC.hots = hots;
    mainVC.histories = histories;
    mainVC.datas = datas;
    return mainVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeHistory:) name:kMDHistoryNotificationName object:nil];
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
}

- (void)changeHistory:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSMutableArray *history = userInfo[@"history"];
    self.histories = history;
    BOOL haveHistory = NO;
    for (MDSearchMainSectionModel *model in self.datas) {
        if (model.sectionType == MDSearchMainSectionTypeHistory) {
            haveHistory = YES;
        }
    }
    
    if (!haveHistory) {
        MDSearchMainSectionModel *historySection = [[MDSearchMainSectionModel alloc]
                                                    initWithDic:@{
                                                                  @"type":@(MDSearchMainSectionTypeHistory),
                                                                  @"title":@"历史搜索",
                                                                  @"data":_histories
                                                                  }];
        [self.datas insertObject:historySection atIndex:0];
    }
    
    [self.collectionView reloadData];
}
- (void)clearHistory {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(didClickClearAction)]) {
        [self.dataSource didClickClearAction];
    }
    [self.histories removeAllObjects];
    [self.datas removeObjectAtIndex:0];
    [self.datas removeObject:self.histories];
    [NSKeyedArchiver archiveRootObject:self.histories toFile:KMDHistorySearchPath];
    [self.collectionView reloadData];
}
#pragma mark 代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInSearchMainView:)]) {
        return [self.dataSource numberOfSectionsInSearchMainView:collectionView];
    }
    return self.datas.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([self.dataSource respondsToSelector:@selector(searchMainView:numberOfItemsInSection:)]) {
        return [self.dataSource searchMainView:collectionView numberOfItemsInSection:section];
    }
    MDSearchMainSectionModel *sectionModel = self.datas[section];
    return sectionModel.models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.dataSource respondsToSelector:@selector(searchMainView:cellForItemAtIndexPath:)]) {
        UICollectionViewCell *cell= [self.dataSource searchMainView:collectionView cellForItemAtIndexPath:indexPath];
        if (cell) return cell;
    }
    MDSearchMainSectionModel *sectionModel = self.datas[indexPath.section];
    NSArray *models = sectionModel.models;
    // 默认cell
    MDSearchMainCollectionViewCell *cell = (MDSearchMainCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"MDSearchMainCollectionViewCell" forIndexPath:indexPath];
    cell.textSpace = self.textSpace;
    cell.title = models[indexPath.row];
    cell.titleLabel.textAlignment = self.textAlignment;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString: UICollectionElementKindSectionHeader ]){
        
        if ([self.dataSource respondsToSelector:@selector(searchMainView:viewForSupplementaryElementOfKind:atIndexPath:)]) {
            UICollectionReusableView *view = [self.dataSource searchMainView:collectionView viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];
            return view;
        }
        MDSearchMainReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MDSearchMainReusableView" forIndexPath:indexPath];
        view.delegate = self;
        MDSearchMainSectionModel *sectionModel = self.datas[indexPath.section];
        NSArray *models = sectionModel.models;
        
        NSString *title = sectionModel.title;
        NSArray  *array = models;
    
        view.title = title;
        view.isHistory = sectionModel.sectionType == MDSearchMainSectionTypeHistory ?  YES : NO;

        if (array.count == 0) {
            return nil;
        }
        return view;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.dataSource respondsToSelector:@selector(searchMainView:layout:sizeForItemAtIndexPath:)]) {
        CGSize size = [self.dataSource searchMainView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
        return size;
    }
    MDSearchMainSectionModel *sectionModel = self.datas[indexPath.section];

    NSArray *models = sectionModel.models;
    
    NSArray  *array = models;
    NSString *text = array[indexPath.row];
    CGSize size = [self textSizeWithFont:[UIFont systemFontOfSize:15]constrainedToSize:CGSizeMake(80, 23) lineBreakMode:NSLineBreakByWordWrapping text:text];
    if (size.width > kMDSearchScreenWidth - 2*kMDSearchMainHeaderLeftMargin - 20) {
        size.width = kMDSearchScreenWidth - 2*kMDSearchMainHeaderLeftMargin - 20;
    }
    // 字体宽度+20
    return CGSizeMake(size.width + 20, 30);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if ([self.dataSource respondsToSelector:@selector(searchMainView:layout:referenceSizeForHeaderInSection:)]) {
        CGSize size = [self.dataSource searchMainView:collectionView layout:collectionViewLayout referenceSizeForHeaderInSection:section];
        return size;
    }
    return CGSizeMake(collectionView.frame.size.width, kMDSearchMainHeaderHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, kMDSearchMainHeaderLeftMargin, 0, kMDSearchMainHeaderLeftMargin);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (self.selectedIndexPathBlock) {
        MDSearchMainSectionModel *sectionModel = self.datas[indexPath.section];
        if (sectionModel.sectionType > MDSearchMainSectionTypeHot) { // 超出历史和热门
            self.selectedIndexPathBlock(@"", indexPath, MDSearchTypeOther);
        } else {
            MDSearchMainSectionModel *sectionModel = self.datas[indexPath.section];
            NSArray  *array = sectionModel.models;
            NSString *text = array[indexPath.row];
            self.selectedIndexPathBlock(text, indexPath,MDSearchTypeMain);
        }
    }
}
- (void)scrollViewWillBeginDragging:(UITableView *)scrollView {
    [self.view endEditing:YES];
}
#pragma mark lazy
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[MDSearchMainCollectionViewCell class] forCellWithReuseIdentifier:@"MDSearchMainCollectionViewCell"];
        [_collectionView registerClass:[MDSearchMainReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MDSearchMainReusableView"];
        _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _collectionView;
}

- (NSMutableArray *)histories {
    if (!_histories) {
        _histories = [NSKeyedUnarchiver unarchiveObjectWithFile:KMDHistorySearchPath];
        if (!_histories) {
            _histories = [NSMutableArray array];
        }
    }
    return _histories;
}
#pragma mark 计算文字size
- (CGSize)textSizeWithFont:(UIFont *)font
         constrainedToSize:(CGSize)size
             lineBreakMode:(NSLineBreakMode)lineBreakMode text:(NSString *)text {
    CGSize textSize;
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        textSize = [text sizeWithAttributes:attributes];
    } else {
        NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        CGRect rect = [text boundingRectWithSize:size
                                         options:option
                                      attributes:attributes
                                         context:nil];
        
        textSize = rect.size;
    }
    return textSize;
}
@end
