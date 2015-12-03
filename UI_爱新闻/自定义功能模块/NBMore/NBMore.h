//
//  NBMore.h
//  UI_爱新闻
//
//  Created by fanweilian on 15/10/12.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, MoreType) {
    MTNothing,  // 社么堵不做
    MTClearCache, //
    MTShowHUD,//显示HUD视图
    MTViewController, //退出视图控制器
    MTConnectURL,//  跳转到对应链接
    MTMail //  发邮件
    
};

@interface NBMore : NSObject
+(instancetype)sharedManager;
//返回字典中所有的组名
-(NSArray *)allSectionsName;
//返回字典中所有的行，（二维数组）
-(NSArray *)allRowsName;
//根据行内容返回对应字典
-(NSDictionary *)dictionaryWithRowTitle:(NSString *)rowTitle;

//   根据字典返回对应行为
-(MoreType)moreTypeWithDictionary:(NSDictionary *)dictionary;

//根据 返回详情
-(NSString *)detailTitleWithRowTitle:(NSString *)rowTitle;

-(NSString *)viewControllerWithDictionary:(NSDictionary *)dictionary;
//根据字典，返回url的字符串
-(NSString *)urlWithDictionary:(NSDictionary *)dictionary;
//根据字典，返回infoView字符串

-(NSString *)infoViewWithDictionary:(NSDictionary *)dictionary;
//根据字典，返回mail字符串
-(NSString *)mailWithDictionary:(NSDictionary *)dictionary;
@end
