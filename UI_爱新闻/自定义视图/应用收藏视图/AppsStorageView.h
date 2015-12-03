//
//  AppsStorageView.h
//  UI_爱新闻
//
//  Created by fanweilian on 15/10/14.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppsStorageView : UIView
@property (weak, nonatomic) IBOutlet UIButton *storageButton;
@property (weak, nonatomic) IBOutlet UILabel *storageLabel;
-(void)addStorageBlock:(void(^)(void))block;

@end
