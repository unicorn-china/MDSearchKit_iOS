//
//  MDSearchMainViewController.h
//  MDUI
//
//  Created by 李永杰 on 2019/7/25.
//

#import <UIKit/UIKit.h>
#import "MDSearchMainModel.h"
typedef void(^MDSearchMainSelectedIndexPathBlock)(NSString *mainText, NSIndexPath *indexPath, NSInteger type);

@protocol MDSearchMainViewDataSource <NSObject>
@optional
- (CGSize)searchMainView:(UICollectionView *)searchMainView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
- (UICollectionViewCell *)searchMainView:(UICollectionView *)searchMainView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

- (NSInteger)numberOfSectionsInSearchMainView:(UICollectionView *)searchMainView;
- (NSInteger)searchMainView:(UICollectionView *)searchMainView numberOfItemsInSection:(NSInteger)section;
- (CGSize)searchMainView:(UICollectionView *)searchMainView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
- (UICollectionReusableView *)searchMainView:(UICollectionView *)searchMainView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;

@end

@interface MDSearchMainViewController : UIViewController

@property (nonatomic, strong) UICollectionView  *collectionView;

@property (nonatomic, copy)   NSArray               *hots;

@property (nonatomic, strong) NSMutableArray        *histories;

@property (nonatomic, strong) NSMutableArray        *datas;

@property (nonatomic, copy)   MDSearchMainSelectedIndexPathBlock  selectedIndexPathBlock;

@property (nonatomic, weak)   id<MDSearchMainViewDataSource>        dataSource;

+ (instancetype)searchMainViewControllerWithHotSearches:(NSArray *)hots histories:(NSMutableArray *)histories datas:(NSMutableArray *)datas
                                     didSearchBlock:(MDSearchMainSelectedIndexPathBlock)block;
@end

