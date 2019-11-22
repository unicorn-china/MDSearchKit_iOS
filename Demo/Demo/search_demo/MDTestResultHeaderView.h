//
//  MDTestResultHeaderView.h
//  Demo
//
//  Created by 李永杰 on 2019/11/22.
//  Copyright © 2019 muheda. All rights reserved.
//

#import <UIKit/UIKit.h>
 
@interface MDTestResultHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) UILabel   *titleLabel;
@property (nonatomic, strong) UIView    *lineView;

+(instancetype)headerViewWithTableView:(UITableView *)tableView;

@end 
