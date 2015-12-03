//
//  NBMore.m
//  UI_爱新闻
//
//  Created by fanweilian on 15/10/12.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "NBMore.h"
@interface NBMore(){

    NSDictionary *_dict;
}

@end

@implementation NBMore

+(instancetype)sharedManager{
    static NBMore *manager;
    if (manager==nil) {
        manager=[[NBMore alloc]init];
    }
    return manager;
    
}

-(instancetype)init{
    if (self=[super init]) {
         _dict=[NBHelper dictionaryWithPlistFile:@"More.plist"];
    }
   
    return self;
    
}
-(NSArray *)allSectionsName{
    return _dict[@"sections"];
    
}
-(NSArray *)allRowsName{

    return _dict[@"allRows"];
}
-(NSString *)detailTitleWithRowTitle:(NSString *)rowTitle{

    NSDictionary *dict=_dict[rowTitle];
    NSString *detail=dict[@"detailTitle"];
    return detail;
    
}
-(NSDictionary *)dictionaryWithRowTitle:(NSString *)rowTitle{
    return _dict[rowTitle];

}
-(MoreType)moreTypeWithDictionary:(NSDictionary *)dictionary{
    MoreType type=MTNothing;
    if ([dictionary[@"viewController"] length]>0) {
        type=MTViewController;
    }else if ([dictionary[@"clearCache"] length]>0){
    
        type=MTClearCache;
    }else if ([dictionary[@"url"] length]>0){
    
        type= MTConnectURL;
    }else if ([dictionary[@"mail"] length] >0){
    
        type=MTMail;
    }else if ([dictionary[@"infoView"] length] >0){
    
        type=MTShowHUD;
    }
    return type;
    
}

-(NSString *)viewControllerWithDictionary:(NSDictionary *)dictionary{

    return dictionary[@"viewController"];
}
-(NSString *)infoViewWithDictionary:(NSDictionary *)dictionary{

    return dictionary[@"infoView"];
    
}
-(NSString *)urlWithDictionary:(NSDictionary *)dictionary{
    return dictionary[@"url"];

}

-(NSString *)mailWithDictionary:(NSDictionary *)dictionary{
    return dictionary[@"mail"];

    
}
@end
