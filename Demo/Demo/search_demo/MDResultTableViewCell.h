//
//  MDResultTableViewCell.h
//  MDUI_Example
//
//  Created by 李永杰 on 2019/7/29.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDSearchDemoModel.h"

@interface MDResultTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString  *name;
 
@property (nonatomic, strong) MDSearchDemoModel *model;

@end
