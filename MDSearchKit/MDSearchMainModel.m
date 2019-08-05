//
//  MDSearchMainModel.m
//  MDUI
//
//  Created by 李永杰 on 2019/8/4.
//

#import "MDSearchMainModel.h"

@implementation MDSearchMainSectionModel

+ (NSMutableArray *)combine:(NSArray *)array {
    NSMutableArray *sections = [NSMutableArray array];

    for (int i = 0; i<array.count; i++) {
        NSDictionary *dic = array[i];
        NSArray *data = dic[@"data"];
        if (data.count != 0) {
            MDSearchMainSectionModel *sectionModel = [[MDSearchMainSectionModel alloc]initWithDic:dic];
            [sections addObject:sectionModel];
        }
    }
    return sections;
}

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.title = dic[@"title"];
        self.sectionType = [dic[@"type"] integerValue];
        self.models = dic[@"data"];
    }
    return self;
}

@end

@implementation MDSearchMainModel

@end
