//
//  ProjectModel.h
//  UI_爱新闻
//
//  Created by YuTengxiao on 15/10/11.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "JSONModel.h"

/*
 {
 "ID" : "125996",
 "app_icon" : "http://file.ipadown.com/uploads/20151009/ipadown_20151009224708_3c3e26af5e.jpg",
 "app_view_count" : 273,
 "litpic" :   "http://file.ipadown.com/uploads/20151009/ipadown_20151009224708_3c3e26af5e.jpg",
 "post_name" : "2015-10-08-best-apps",
 "post_title" : "2015-10-08 大作之夜 - 长假归来！ 热门美剧IP降临"
 }
 */

@interface ProjectModel : JSONModel

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *app_icon;
@property (nonatomic, copy) NSString *post_name;
@property (nonatomic, copy) NSString *app_view_count;
@property (nonatomic, copy) NSString *post_title;
@property (nonatomic, copy) NSString *litpic;

@end
