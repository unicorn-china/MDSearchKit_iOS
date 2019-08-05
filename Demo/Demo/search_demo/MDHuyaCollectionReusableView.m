//
//  MDHuyaCollectionReusableView.m
//  MDUI_Example
//
//  Created by 李永杰 on 2019/7/29.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import "MDHuyaCollectionReusableView.h"
 

@implementation MDHuyaCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.05];
        [self addSubview:self.titleLabel];
        [self addSubview:self.rightButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(15, 0, 100, self.frame.size.height);
    self.rightButton.frame = CGRectMake(self.frame.size.width - 15 - 100, 0, 100, self.frame.size.height);
}
- (void)didClickClear {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clearHistory)]) {
        [self.delegate clearHistory];
    }
}

-(void)setRightTitle:(NSString *)rightTitle {
    _rightTitle = rightTitle;

    [self.rightButton setTitle:rightTitle forState:UIControlStateNormal];
    if (self.isHistory) {
        [self.rightButton addTarget:self action:@selector(didClickClear) forControlEvents:UIControlEventTouchUpInside];
    }else {
        [self.rightButton removeTarget:self action:@selector(didClickClear) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    return _rightButton;
}
@end
