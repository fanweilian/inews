//
//  NewsDetailModel.h
//  UI_爱新闻
//
//  Created by fanweilian on 15/10/12.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "JSONModel.h"

@interface NewsDetailModel : JSONModel
@property (nonatomic, copy) NSString *writer;
@property (nonatomic, copy) NSString *post_cid;
@property (nonatomic, copy) NSString *news_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *pubDate;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *views;
@property (nonatomic, copy) NSString *catename;
@end
