//
//  AppsCell.h
//  UI_爱新闻
//
//  Created by YuTengxiao on 15/10/11.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppsModel;

@interface AppsCell : UITableViewCell

- (void)updateCellWithModel:(AppsModel *)model row:(NSInteger)row;

@end
