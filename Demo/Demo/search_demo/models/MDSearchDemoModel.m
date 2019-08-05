//
//  MDSearchDemoModel.m
//  MDUI_Example
//
//  Created by 李永杰 on 2019/7/30.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import "MDSearchDemoModel.h"

@implementation MDSearchDemoModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.resultName = dic[@"server_name"];

        self.server_code = dic[@"server_code"];
        self.server_url  = dic[@"server_url"];
        self.server_icon = dic[@"server_icon"];
        self.uiModel.textColor = [UIColor blueColor];
    }
    return self;
}

@end
// 数据驱动于ui
