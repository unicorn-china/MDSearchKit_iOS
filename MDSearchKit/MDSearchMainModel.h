//
//  MDSearchMainModel.h
//  MDUI
//
//  Created by 李永杰 on 2019/8/4.
//

#import <Foundation/Foundation.h>

typedef enum : NSInteger {
    MDSearchMainSectionTypeHistory,
    MDSearchMainSectionTypeHot,
    MDSearchMainSectionTypeOther
} MDSearchMainSectionType;

@class MDSearchMainModel;
@interface MDSearchMainSectionModel : NSObject

@property (nonatomic, assign)   MDSearchMainSectionType sectionType;

@property (nonatomic, copy)     NSString        *title;

@property (nonatomic, strong)   NSMutableArray  *models;

+(NSMutableArray *)combine:(NSArray *)array;

-(instancetype)initWithDic:(NSDictionary *)dic;

@end

@interface MDSearchMainModel : NSObject

@end
