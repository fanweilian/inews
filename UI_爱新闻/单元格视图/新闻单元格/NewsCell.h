//
//  NewsCell.h
//  UI_爱新闻
//
//  Created by YuTengxiao on 15/10/10.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsModel;

@interface NewsCell : UITableViewCell

- (void)updateCellWithModel:(NewsModel *)model;

@end
