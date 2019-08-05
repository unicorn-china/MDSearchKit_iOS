//
//  MDSearchResultBaseModel.m
//  MDUI
//
//  Created by 李永杰 on 2019/7/30.
//

#import "MDSearchResultBaseModel.h"

@implementation MDSearchResultBaseModel

- (instancetype)init {
    if (self = [super init]) {
        _uiModel = [[MDResultUIModel alloc]init];
    }
    return self;
}

@end

@implementation MDResultUIModel

- (instancetype)init {
    if (self = [super init]) {
        _rowHeight = 44.0;
        _textColor = [UIColor blackColor];
    }
    return self;
}

@end


