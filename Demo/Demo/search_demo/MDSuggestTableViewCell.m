//
//  MDSuggestTableViewCell.m
//  MDUI_Example
//
//  Created by 李永杰 on 2019/7/25.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import "MDSuggestTableViewCell.h"

@interface MDSuggestTableViewCell ()

@property (nonatomic, strong) UIImageView   *avatorImageView;
@property (nonatomic, strong) UILabel       *nameLabel;

@end

@implementation MDSuggestTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.avatorImageView];
        [self.contentView addSubview:self.nameLabel];
    }
    return self;
}
- (void)setName:(NSString *)name {
    _name = name;
    self.nameLabel.text = [NSString stringWithFormat:@"%@我是自定义的cell",name];
}
-(UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 250, 80)];
    }
    return _nameLabel;
}

- (UIImageView *)avatorImageView {
    if (!_avatorImageView) {
        _avatorImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
        _avatorImageView.image = [UIImage imageNamed:@"rightImage576.jpg"];
    }
    return _avatorImageView;
}
@end
