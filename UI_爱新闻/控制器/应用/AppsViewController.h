//
//  AppsViewController.h
//  UI_爱新闻
//
//  Created by YuTengxiao on 15/10/11.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "ParentTableViewController.h"

@interface AppsViewController : ParentTableViewController

// 对应请求的第三个参数 all 所有, free 免费，pricedrop 限免，paid 付费
@property (nonatomic, copy) NSString *price;

@end
