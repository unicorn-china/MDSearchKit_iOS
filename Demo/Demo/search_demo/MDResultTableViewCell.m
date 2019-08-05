//
//  MDResultTableViewCell.m
//  MDUI_Example
//
//  Created by 李永杰 on 2019/7/29.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import "MDResultTableViewCell.h"

@interface MDResultTableViewCell ()

@property (nonatomic, strong) UIImageView   *avatorImageView;
@property (nonatomic, strong) UILabel       *nameLabel;

@end

@implementation MDResultTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.avatorImageView];
        [self.contentView addSubview:self.nameLabel];
    }
    return self;
}
- (void)setName:(NSString *)name {
    _name = name;
    self.nameLabel.text = [NSString stringWithFormat:@"%@",name];
}
- (void)setModel:(MDSearchDemoModel *)model {
    _model = model;
    _nameLabel.textColor = self.model.uiModel.textColor;

}
-(UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 250, self.frame.size.height)];
    }
    return _nameLabel;
}
- (UIImageView *)avatorImageView {
    if (!_avatorImageView) {
        _avatorImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.height)];
        _avatorImageView.image = [UIImage imageNamed:@"face"];
    }
    return _avatorImageView;
}
@end
