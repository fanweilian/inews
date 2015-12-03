//
//  NewsCommitModel.h
//  UI_爱新闻
//
//  Created by fanweilian on 15/10/13.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "JSONModel.h"

@interface NewsCommitModel : JSONModel
@property(nonatomic,copy) NSString *uesrName;
@property(nonatomic,copy) NSString *date;
@property(nonatomic,copy) NSString *content;
@end
