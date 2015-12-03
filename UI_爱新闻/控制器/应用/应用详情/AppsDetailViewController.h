//
//  AppsDetailViewController.h
//  UI_爱新闻
//
//  Created by fanweilian on 15/10/14.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "ParentViewController.h"
#import "AppsModel.h"
@interface AppsDetailViewController : ParentViewController
@property(nonatomic,copy) NSString *appID;
@property(nonatomic,strong) AppsModel *model;
@end
