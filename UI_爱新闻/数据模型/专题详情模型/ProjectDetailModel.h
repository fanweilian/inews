//
//  ProjectDetailModel.h
//  UI_爱新闻
//
//  Created by YuTengxiao on 15/10/11.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "JSONModel.h"
#import "AppsModel.h"

@interface ProjectDetailModel : JSONModel

@property (nonatomic, copy) NSString *litpic;
@property (nonatomic, copy) NSString *post_name;
@property (nonatomic, copy) NSString *post_title;
@property (nonatomic, copy) NSString *post_parent;
@property (nonatomic, copy) NSString *post_excerpt;
@property (nonatomic, copy) NSString *post_content;
@property (nonatomic, copy) NSArray <AppsModel> *apps;

@end
