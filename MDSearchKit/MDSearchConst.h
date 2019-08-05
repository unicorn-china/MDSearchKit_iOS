//
//  MDSearchConst.h
//  Pods
//
//  Created by 李永杰 on 2019/7/24.
//

#ifndef MDSearchConst_h
#define MDSearchConst_h

#define kMDSearch_WeakSelf __weak typeof(self) weakSelf = self;



#define kMDSearchScreenWidth        [UIScreen mainScreen].bounds.size.width
#define kMDSearchStatusBarHeight    [[UIApplication sharedApplication] statusBarFrame].size.height
#define kMDSearchNavBarHeight       44.0
#define kMDSearchBarLeftMargin      5.0
#define kMDSearchBarTopMargin       7.0

#define kMDSearchMainHeaderHeight       50
#define kMDSearchMainHeaderLeftMargin   15
#define kMDSearchMainHeaderTopMargin    5

#define kMDSearchMainHeaderRightMargin  15



#define KMDHistorySearchPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"MDSearchHistories.plist"]

#define kMDHistoryNotificationName   @"kMDHistoryNotificationName"

#endif /* MDSearchConst_h */
