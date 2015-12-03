//
//  WallPaperModel.h
//  UI_爱新闻
//
//  Created by fanweilian on 15/10/12.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "JSONModel.h"

@interface WallPaperModel : JSONModel
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *thumb;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *tags;
@property (nonatomic, copy) NSString *edit_time;
@property (nonatomic, copy) NSString *cid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString <Optional> *desc;
@property (nonatomic, copy) NSString *size;
@property (nonatomic, copy) NSString *good;
@property (nonatomic, copy) NSString *bad;
@property (nonatomic, copy) NSString *commend;
@property (nonatomic, copy) NSString *nums;
@property (nonatomic, copy) NSString *add_time;
@property (nonatomic, copy) NSString *imgs;
@property (nonatomic, copy) NSString *views;
@end
