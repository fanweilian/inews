//
//  AppsModel.h
//  UI_爱新闻
//
//  Created by YuTengxiao on 15/10/11.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "JSONModel.h"

@protocol AppsModel

@end

@interface AppsModel : JSONModel

@property (nonatomic, copy) NSString *app_id;
@property (nonatomic, copy) NSString *app_category;
@property (nonatomic, copy) NSString *app_icon;
@property (nonatomic, copy) NSString *app_size;
@property (nonatomic, copy) NSString *app_name;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString <Optional> *post_stitle;
@property (nonatomic, copy) NSString <Optional> *app_apple_rated;
@property (nonatomic, copy) NSString *app_top;
@property (nonatomic, copy) NSString *app_pricedrop;
@property (nonatomic, copy) NSString *post_title;
@property (nonatomic, copy) NSString *app_price;
@property (nonatomic, copy) NSString *app_device;
@property (nonatomic, copy) NSString *post_date;
@property (nonatomic, copy) NSString *app_desc;

@end
