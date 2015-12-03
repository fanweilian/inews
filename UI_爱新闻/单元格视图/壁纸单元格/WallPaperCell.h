//
//  WallPaperCell.h
//  UI_爱新闻
//
//  Created by fanweilian on 15/10/12.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WallPaperCell : UITableViewCell

-(void)updateCellWithModelArray:(NSArray *)modeArray tapBlock:(void (^)(NSInteger taptag))block;
@end
