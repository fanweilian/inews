//
//  NBRequest.m
//  UI_爱新闻
//
//  Created by YuTengxiao on 15/10/11.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "NBRequest.h"
#import "AFNetworking.h"
#import "MMProgressHUD.h"
#import "AppDelegate.h"
#import "NBCacheManager.h"
@implementation NBRequest

+ (void)requestWithURL:(NSString *)url type:(NBRequestType)type success:(void (^)(NSData *data))success failed:(void (^)(NSError *error))failed {
    // 请求数据的时候，显示进度
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD showWithStatus:@"正在加载..."];
    NBCacheManager *cacheManager=[NBCacheManager sharedManager];
    if ((NetWorkStatus==AFNetworkReachabilityStatusNotReachable && [cacheManager isFileExistWithUrl:url]) ||(NetWorkStatus==AFNetworkReachabilityStatusReachableViaWWAN && [cacheManager isFileExistWithUrl:url] &&[cacheManager isOutTimeWithUrl:url time:1*60]==NO)  || ((NetWorkStatus==AFNetworkReachabilityStatusReachableViaWiFi && [cacheManager isOutTimeWithUrl:url time:3*60]==NO)  &&(type!=RequestRefresh))) {
        //读取缓存
        NSLog(@"从缓存读取数据");
        NSData *data=[cacheManager cacheDataWithUrl:url];
        if (success) {
            success(data)
            ;
        }
        [MMProgressHUD dismissWithSuccess:@"加载成功"];
        return;
    }
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {//下载成功，写入缓存
            [cacheManager cacheData:responseObject forUrl:url];
            success(responseObject);
            
        }
        [MMProgressHUD dismissWithSuccess:@"加载成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failed) {
            failed(error);
        }
        [MMProgressHUD dismissWithError:@"加载失败"];
    }];
}

@end
