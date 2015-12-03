//
//  NewsCommitCell.m
//  UI_爱新闻
//
//  Created by fanweilian on 15/10/13.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "NewsCommitCell.h"
#import "NewsCommitModel.h"
@interface NewsCommitCell()

@property (weak, nonatomic) IBOutlet UILabel *uesrName;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *content;

@property (weak, nonatomic) IBOutlet UIImageView *contentBG;


@end



@implementation NewsCommitCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateCellWithModel:(NewsCommitModel *)model row:(NSInteger)row{
    self.uesrName.text=model.uesrName;
    self.date.text=model.date;
    self.content.text=model.content;
    CGFloat height=[NBHelper sizeWithText:model.content size:CGSizeMake(self.content.frame.size.width, CGFLOAT_MIN) fontSize:17].height;
    CGRect frame=self.content.frame;
    frame.size.height=height;
    self.content.frame=frame;
    
    frame=self.contentBG.frame;
    frame.size.height=20+height;
    self.contentBG.frame=frame;
    
    
    NSString *imageName=row%2 ? @"bubble" :@"blue";
    self.contentBG.image=[[UIImage imageNamed:imageName] stretchableImageWithLeftCapWidth:22 topCapHeight:15];
    
    

    
}
@end
