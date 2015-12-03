//
//  NBDataManager.m
//  UI_01数据库
//
//  Created by YuTengxiao on 15/10/1.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

// 使用FMDB的步骤
// 1. 导入fmdb库，这个库，是在sqlite上的封装，所以，要导入sqlite库。
//    导入libsqlite3.dylib
// 2. 在使用的地方，导入头文件就可以了。（fmdb支持arc和mrc，所以，无论工程是社么样式的，都不需要进行混编）

#import "NBDataManager.h"
#import "FMDatabase.h"
#import "AppsModel.h"
// 数据库文件的名字
#define FILENAME @"user.db"

@interface NBDataManager () {
    // 数据库管理对象
    FMDatabase *_database;
}

@end

@implementation NBDataManager

+ (instancetype)sharedManager {
    static NBDataManager *manager = nil;
    if (manager == nil) {
        manager = [[self alloc] init];
    }
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        NSString *path = [self filePathWithName:FILENAME];
        // 对FMDataBase对象，进行初始化，使用一个数据库文件的完整路径
        _database = [[FMDatabase alloc] initWithPath:path];
        // 对象创建完成，需要打开文件
        // 如果文件存在，则直接打开，如果不存在的话，则先创建，再打开
        if ([_database open]) {
            // 打开数据库后，做的事情，创建表(打开表)
            [self createTable];
        } else {
            // 获取_database里，最后一条错误信息
            NSLog(@"数据库打开失败 : %@", [_database lastErrorMessage]);
        }
    }
    return self;
}

- (void)createTable {
    // 可以创建多个表
    NSArray *createSQLs =  @[@"create table if not exists apps(serial integer Primary Key Autoincrement, app_icon varchar(256), app_id varchar(64), post_title varchar(128), post_stitle varchar(256), app_apple_rated varchar(64), app_price varchar(64), app_size varchar(64), app_pricedrop varchar(64), app_desc varchar(1024))"];
    for (NSString *createSQL in createSQLs) {
        // executedUpdate，执行一条数据库语句，返回YES，表示执行成功，返回NO，表示执行失败!
        if (![_database executeUpdate:createSQL]) {
            NSLog(@"创建表失败 : %@",[_database lastErrorMessage]);
        }
    }
}

// 获取文件的完整路径
- (NSString *)filePathWithName:(NSString *)name {
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [doc stringByAppendingPathComponent:name];
}

- (BOOL)isModelExists:(AppsModel *)model {
    BOOL isExists = NO;
    // ? 表示占位符号，表示一个对象
    NSString *selectSQL = @"select * from apps where app_id = ?";
    // FMResultSet 结果的集合
    // executeQuery: 返回一个查找结果的集合
    // 相当于把model.num 替换到 ？这个地方了!
    FMResultSet *set = [_database executeQuery:selectSQL, model.app_id];
    // 通过调用集合的next方法，可以逐个获取每一条数据
    while ([set next]) {
        // 如果进来了，说明，有数据了
        isExists = YES;
    }
    return isExists;
}

- (void)insertModel:(AppsModel *)model {
    if ([self isModelExists:model]) {
        NSLog(@"插入失败，对象已存在");
    } else {
        NSString *insertSQL = @"insert into apps (app_icon, app_id, post_title, post_stitle, app_apple_rated, app_price, app_size, app_pricedrop, app_desc) values (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        if (![_database executeUpdate:insertSQL, model.app_icon, model.app_id, model.post_title, model.post_stitle, model.app_apple_rated, model.app_price, model.app_size, model.app_pricedrop, model.app_desc]) {
            NSLog(@"插入失败 : %@",[_database lastErrorMessage]);
        }
    }
}

- (void)deleteModelForAPPID:(NSString *)appID {
    NSString *deleteSQL = @"delete from apps where app_id = ?";
    if (![_database executeUpdate:deleteSQL, appID]) {
        NSLog(@"删除数据失败 : %@", [_database lastErrorMessage]);
    }
}

- (void)deleteAllModels {
    NSString *deleteSQL = @"delete from apps";
    if (![_database executeUpdate:deleteSQL]) {
        NSLog(@"删除数据失败 : %@", [_database lastErrorMessage]);
    }
}

// 一个公共的私有方法，返回集合中所有的数据模型对象
- (NSArray *)modelsWithFMResultSet:(FMResultSet *)set {
    NSMutableArray *models = [NSMutableArray array];
    while ([set next]) {
        AppsModel *model = [[AppsModel alloc] init];
        // 通过列的名字获取值
        model.app_icon = [set stringForColumn:@"app_icon"];
        model.app_id = [set stringForColumn:@"app_id"];
        model.post_title = [set stringForColumn:@"post_title"];
        model.post_stitle = [set stringForColumn:@"post_stitle"];
        model.app_apple_rated = [set stringForColumn:@"app_apple_rated"];
        model.app_price = [set stringForColumn:@"app_price"];
        model.app_size = [set stringForColumn:@"app_size"];
        model.app_pricedrop = [set stringForColumn:@"app_pricedrop"];
        model.app_desc = [set stringForColumn:@"app_desc"];
        [models addObject:model];
    }
    return models;
}

- (NSArray *)allModels {
    NSString *selectSQL = @"select * from apps";
    FMResultSet *set = [_database executeQuery:selectSQL];
    return [self modelsWithFMResultSet:set];
}

@end
