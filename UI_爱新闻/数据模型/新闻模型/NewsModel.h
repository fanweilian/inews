//
//  NewsModel.h
//  UI_爱新闻
//
//  Created by YuTengxiao on 15/10/10.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "JSONModel.h"

@interface NewsModel : JSONModel

@property (nonatomic, copy) NSString *litpic;
@property (nonatomic, copy) NSString *litpic_2;
@property (nonatomic, copy) NSString *writer;
@property (nonatomic, copy) NSString *news_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *pubDate;
@property (nonatomic, copy) NSString *views;
@property (nonatomic, copy) NSString *tags;
@property (nonatomic, copy) NSString *desc;

@end
