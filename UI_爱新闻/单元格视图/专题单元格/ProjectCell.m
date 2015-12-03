//
//  ProjectCell.m
//  UI_爱新闻
//
//  Created by YuTengxiao on 15/10/11.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "ProjectCell.h"
#import "UIImageView+WebCache.h"
#import "ProjectModel.h"

@interface ProjectCell ()

@property (nonatomic, strong) UIImageView *app_icon;
@property (nonatomic, strong) UILabel *post_title;

@end

@implementation ProjectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return  self;
}

- (void)createUI {
    self.app_icon = [NBControl createImageViewWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-10-10, 180) tag:0 image:@"placeholder-zt" cornerRadius:0];
    [self.contentView addSubview:self.app_icon];
    
    self.post_title = [NBControl createLabelWithFrame:CGRectMake(10, 200-10-20, SCREEN_WIDTH-10-10, 20) tag:0 title:@"" font:17];
    self.post_title.backgroundColor = [UIColor blackColor];
    self.post_title.textColor = [UIColor whiteColor];
    self.post_title.alpha = 0.5;
    self.post_title.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.post_title];
}

- (void)updateCellWithModel:(ProjectModel *)model {
    [self.app_icon sd_setImageWithURL:[NSURL URLWithString:model.app_icon] placeholderImage:[UIImage imageNamed:@"placeholder-zt"]];
    self.post_title.text = model.post_title;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
