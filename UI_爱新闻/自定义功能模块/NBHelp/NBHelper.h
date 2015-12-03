//
//  NBHelper.h
//  UI_01爱限免
//
//  Created by YuTengxiao on 15/10/2.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NBHelper : NSObject

// 根据plist文件名字，返回一个数组
+ (NSArray *)arrayWithPlistFile:(NSString *)file;
// 根据plist文件名字，返回一个字典
+ (NSDictionary *)dictionaryWithPlistFile:(NSString *)file;


// 获取某个字体，所占的宽度
+ (CGFloat)widthWithText:(NSString *)text font:(UIFont *)font;

// 返回一个大小，参数是文字内容，大小，和文字大小
+ (CGSize)sizeWithText:(NSString *)text size:(CGSize)size fontSize:(CGFloat)fontSize;

// 通过一个时间的字符串，返回一个剩余时间的字符串
+ (NSString *)restOfTimeByTimeString:(NSString *)timeString;

// 传入一个数据模型的字典，打印出数据模型
+ (void)createModelWithDictionary:(NSDictionary *)dict;

// One项目用到的，返回今天的字符串 格式:2015-05-21
+ (NSString *)today;

@end
