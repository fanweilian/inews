//
//  NewsCommitCell.h
//  UI_爱新闻
//
//  Created by fanweilian on 15/10/13.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsCommitModel;
@interface NewsCommitCell : UITableViewCell

-(void)updateCellWithModel:(NewsCommitModel *)model row:(NSInteger)row;

@end
