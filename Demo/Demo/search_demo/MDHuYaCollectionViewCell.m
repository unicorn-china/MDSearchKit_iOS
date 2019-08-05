//
//  MDHuYaCollectionViewCell.m
//  MDUI_Example
//
//  Created by 李永杰 on 2019/7/27.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import "MDHuYaCollectionViewCell.h"

@implementation MDHuYaHistoryItemView

-(instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
    
    self.titleLabel.frame = self.bounds;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.backgroundColor = [UIColor lightGrayColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
@end

@implementation MDHuYaHotItemView

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.scoreLabel];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.scoreLabel.frame = CGRectMake(15, 0, self.frame.size.height, self.frame.size.height);
    self.scoreLabel.layer.cornerRadius = self.frame.size.height / 2.0;
    self.scoreLabel.layer.masksToBounds = YES;
    
    
    self.titleLabel.frame = CGRectMake(self.frame.size.height + 15, 0, self.frame.size.width - self.frame.size.height - 15, self.frame.size.height);
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)setRow:(NSInteger)row {
    _row = row;
    self.scoreLabel.text = [NSString stringWithFormat:@"%ld",row+1];
    if (row == 0) {
        self.scoreLabel.backgroundColor = [UIColor redColor];
    } else if (row == 1) {
        self.scoreLabel.backgroundColor = [UIColor blueColor];

    }else if (row == 2) {
        self.scoreLabel.backgroundColor = [UIColor yellowColor];
    }else {
        self.scoreLabel.backgroundColor = [UIColor orangeColor];
    }
}

- (UILabel *)scoreLabel {
    if (!_scoreLabel) {
        _scoreLabel = [[UILabel alloc]init];
        _scoreLabel.backgroundColor = [UIColor orangeColor];
        _scoreLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _scoreLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
    }
    return _titleLabel;
}
@end

@implementation MDHuYaNewsItemView

-(instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = self.bounds;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
    }
    return _titleLabel;
}
@end


@implementation MDHuYaCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    if (_historyView) {
        _historyView.frame = self.bounds;
    }
    
    if (_hotView) {
        _hotView.frame = self.bounds;
    }
    
    if (_newsView) {
        _newsView.frame = self.bounds;
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    if (_historyView) {
        _historyView.title = title;
    }
    
    if (_hotView) {
        _hotView.title = title;
    }
    
    if (_newsView) {
        _newsView.title = title;
    }
}

- (void)setRow:(NSInteger)row {
    _row = row;
    if (_hotView) {
        _hotView.row = row;
    }
}

- (void)setSection:(NSInteger)section {
    _section = section;
    
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (self.histories.count != 0) {
        if (section == 0) {
            [self.contentView addSubview:self.self.historyView];
        }else if (section == 1) {
            [self.contentView addSubview:self.hotView];
        }else if (section == 2) {
            [self.contentView addSubview:self.newsView];
        }
    }else {
        if (section == 0) {
            [self.contentView addSubview:self.self.hotView];
        }else if (section == 1) {
            [self.contentView addSubview:self.newsView];
        }
    }
}

- (MDHuYaHistoryItemView *)historyView {
    if (!_historyView) {
        _historyView = [[MDHuYaHistoryItemView alloc]init];
    }
    return _historyView;
}

- (MDHuYaHotItemView *)hotView {
    if (!_hotView) {
        _hotView = [[MDHuYaHotItemView alloc]init];
    }
    return _hotView;
}

- (MDHuYaNewsItemView *)newsView {
    if (!_newsView) {
        _newsView = [[MDHuYaNewsItemView alloc]init];
    }
    return _newsView;
}
@end


