//
//  NBDataManager.h
//  UI_01数据库
//
//  Created by YuTengxiao on 15/10/1.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import <Foundation/Foundation.h>


@class AppsModel;
// 数据库管理类，用来管理数据库中一个表
// 单例类（多个页面，都要使用这个表的数据）

@interface NBDataManager : NSObject

+ (instancetype)sharedManager;
// 插入一条数据
- (void)insertModel:(AppsModel *)model;
// 根据APPID，删除一条数据
- (void)deleteModelForAPPID:(NSString *)appID;
// 删除所有的数据
- (void)deleteAllModels;
// 查找所有的数据
- (NSArray *)allModels;
// 是否存在此数据模型对象
- (BOOL)isModelExists:(AppsModel *)model;

@end
