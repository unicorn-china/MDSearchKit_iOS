//
//  MDSearchResultBaseModel.h
//  MDUI
//
//  Created by 李永杰 on 2019/7/30.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class MDResultUIModel;
@interface MDSearchResultBaseModel : NSObject

@property (nonatomic, copy) NSString            *resultName;

@property (nonatomic, strong) MDResultUIModel   *uiModel;

@end

@interface MDResultUIModel : NSObject

@property (nonatomic, assign) CGFloat    rowHeight;

@property (nonatomic, strong) UIColor    *textColor;

@end

