//
//  NBHelper.m
//  UI_01爱限免
//
//  Created by YuTengxiao on 15/10/2.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "NBHelper.h"

@implementation NBHelper

+ (NSArray *)arrayWithPlistFile:(NSString *)file {
    NSString *path = [[NSBundle mainBundle] pathForResource:file ofType:nil];
    return [NSArray arrayWithContentsOfFile:path];
}

+ (NSDictionary *)dictionaryWithPlistFile:(NSString *)file {
    NSString *path = [[NSBundle mainBundle] pathForResource:file ofType:nil];
    return [NSDictionary dictionaryWithContentsOfFile:path];
}

+ (CGFloat)widthWithText:(NSString *)text font:(UIFont *)font {
    CGSize size = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 30) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
    return size.width;
}

+ (CGSize)sizeWithText:(NSString *)text size:(CGSize)size fontSize:(CGFloat)fontSize {
    return [text boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
}

// "2015-10-02 20:23:17.0"    03:23:1x
//             17:00:00
+ (NSString *)restOfTimeByTimeString:(NSString *)timeString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.S";
    NSDate *date = [formatter dateFromString:timeString];
    NSInteger interval = [date timeIntervalSinceNow];
    NSInteger hour = interval/3600;
    interval %= 3600;
    NSInteger min = interval/60;
    interval %= 60;
    return [NSString stringWithFormat:@"剩余:%02ld:%02ld:%02ld",hour, min, interval];
}

+ (void)createModelWithDictionary:(NSDictionary *)dict {
    for (NSString *key in dict) {
        printf("@property (nonatomic, copy) NSString *%s;\n",[key UTF8String]);
    }
}

+ (NSString *)today {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    return [formatter stringFromDate:[NSDate date]];
}

@end
