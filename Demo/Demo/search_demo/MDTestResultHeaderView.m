//
//  MDTestResultHeaderView.m
//  Demo
//
//  Created by 李永杰 on 2019/11/22.
//  Copyright © 2019 muheda. All rights reserved.
//

#import "MDTestResultHeaderView.h"

@implementation MDTestResultHeaderView


+(instancetype)headerViewWithTableView:(UITableView *)tableView {
    NSString *headerId = @"MDBillTitleView";
    MDTestResultHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerId];
    if (headerView == nil) {
        headerView = [[MDTestResultHeaderView alloc]initWithReuseIdentifier:headerId];
    }
    return headerView;
}
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.lineView];
    }
    return self;
}
-(void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(15, 10, 120, 21);

}

-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}


@end
