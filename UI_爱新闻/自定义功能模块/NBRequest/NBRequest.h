//
//  NBRequest.h
//  UI_爱新闻
//
//  Created by YuTengxiao on 15/10/11.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//


/*
 1. 如果没有网络连接， 直接从缓存读取数据
 2. 如果是3G连接， 先从缓存，超时时间2个小时
 3. 如果是WiFi，先从缓存，超时时间30分钟
 4. 如果是下拉刷新，直接从网络请求数据
 */

#import <Foundation/Foundation.h>

// 用系统的方式，来定义枚举
typedef NS_ENUM(NSInteger, NBRequestType) {
    RequestNormal,  // 普通请求
    RequestRefresh, // 下拉刷新
    RequestMore     // 上拉加载
};

@interface NBRequest : NSObject

+ (void)requestWithURL:(NSString *)url type:(NBRequestType)type success:(void (^)(NSData *requestData))success failed:(void (^)(NSError *error))failed;

@end
