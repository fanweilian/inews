//
//  ProjectDetailHeaderView.m
//  UI_爱新闻
//
//  Created by YuTengxiao on 15/10/11.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "ProjectDetailHeaderView.h"
#import "ProjectDetailModel.h"
#import "UIImageView+WebCache.h"

@implementation ProjectDetailHeaderView

- (instancetype)initWithModel:(ProjectDetailModel *)model {
    if (self = [super init]) {
        [self createUIWithModel:model];
    }
    return self;
}

- (void)createUIWithModel:(ProjectDetailModel *)model {
    UIImageView *imageView = [NBControl createImageViewWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-10-10, 200) tag:0 image:@"placeholder-zt" cornerRadius:0];
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.litpic] placeholderImage:[UIImage imageNamed:@"placeholder-zt"]];
    [self addSubview:imageView];
    
    UILabel *label = [NBControl createLabelWithFrame:CGRectMake(10, 10+200+5, SCREEN_WIDTH-10-10, 10) tag:0 title:@"" font:15];
    label.text = model.post_content;
    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 0;
    CGFloat height = [NBHelper sizeWithText:model.post_content size:CGSizeMake(SCREEN_WIDTH-10-10, CGFLOAT_MAX) fontSize:15].height;
    CGRect frame = label.frame;
    frame.size.height = height;
    label.frame = frame;
    [self addSubview:label];
    // 更新self的frame
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 10+200+5+height+10);
}

@end
