//
//  MDSearchDemoModel.h
//  MDUI_Example
//
//  Created by 李永杰 on 2019/7/30.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import "MDSearchResultBaseModel.h"

@interface MDSearchDemoModel : MDSearchResultBaseModel
 
@property (nonatomic, copy)     NSString    *server_icon;
@property (nonatomic, copy)     NSString    *server_code;
@property (nonatomic, copy)     NSString    *server_url;

-(instancetype)initWithDic:(NSDictionary *)dic;

@end
