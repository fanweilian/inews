//
//  NewsCell.m
//  UI_爱新闻
//
//  Created by YuTengxiao on 15/10/10.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "NewsCell.h"
#import "RoundRectImageview.h"
#import "NewsModel.h"
#import "UIImageView+WebCache.h"

@interface NewsCell ()

@property (weak, nonatomic) IBOutlet RoundRectImageview *litPic;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *pubDate;

@end

@implementation NewsCell

- (void)updateCellWithModel:(NewsModel *)model {
    [self.litPic sd_setImageWithURL:[NSURL URLWithString:model.litpic] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.title.text = model.title;
    self.desc.text = model.desc;
    self.pubDate.text = model.pubDate;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
