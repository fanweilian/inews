//
//  AppsCell.m
//  UI_爱新闻
//
//  Created by YuTengxiao on 15/10/11.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "AppsCell.h"
#import "RoundRectImageview.h"
#import "UIImageView+WebCache.h"
#import "AppsModel.h"

@interface AppsCell ()

@property (weak, nonatomic) IBOutlet RoundRectImageview *app_icon;
@property (weak, nonatomic) IBOutlet UILabel *post_title;
@property (weak, nonatomic) IBOutlet UILabel *app_apple_rated;
@property (weak, nonatomic) IBOutlet UILabel *post_stitle;
@property (weak, nonatomic) IBOutlet UIButton *app_price;
@property (weak, nonatomic) IBOutlet UILabel *app_desc;
@property (weak, nonatomic) IBOutlet UILabel *app_size;

@end

@implementation AppsCell

/*
 "app_price" : "6", 非0
 "app_pricedrop" : "1", 为1  // 降价中
 
 "app_price" : "0",  0
 "app_pricedrop" : "1", 1   // 限免中
 
 "app_price" : "12",
 "app_pricedrop" : "0",    12
 
 "app_price" : "0",
 "app_pricedrop" : "0",  // 免费
 */

- (void)updateCellWithModel:(AppsModel *)model row:(NSInteger)row {
    [self.app_icon sd_setImageWithURL:[NSURL URLWithString:model.app_icon] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.post_title.text = [NSString stringWithFormat:@"%ld.%@",row+1, model.post_title];
    if (model.app_apple_rated == nil || model.app_apple_rated.length == 0) {
         self.app_apple_rated.text = @"未知";
    } else {
        self.app_apple_rated.text = [model.app_apple_rated stringByAppendingString:@"星"];
    }
    self.post_stitle.text = model.post_stitle.length == 0 ? @"神秘应用" : model.post_stitle;
    self.app_desc.text = model.app_desc;
    self.app_size.text = model.app_size;
    
    if ([model.app_pricedrop integerValue]) {
        [self.app_price setBackgroundImage:[UIImage imageNamed:@"price-bg"] forState:UIControlStateNormal];
        if ([model.app_price integerValue]) {
            [self.app_price setTitle:@"降价中" forState:UIControlStateNormal];
        } else {
            [self.app_price setTitle:@"限免中" forState:UIControlStateNormal];
        }
    } else {
        [self.app_price setBackgroundImage:[UIImage imageNamed:@"price-bg-lan"] forState:UIControlStateNormal];
        if ([model.app_price integerValue]) {
            [self.app_price setTitle:[@"¥" stringByAppendingString:model.app_price] forState:UIControlStateNormal];
        } else {
            [self.app_price setTitle:@"免费" forState:UIControlStateNormal];
        }
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
