//
//  NewsCategoryModel.h
//  UI_爱新闻
//
//  Created by YuTengxiao on 15/10/10.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "JSONModel.h"

@interface NewsCategoryModel : JSONModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *categoryID;

@end
