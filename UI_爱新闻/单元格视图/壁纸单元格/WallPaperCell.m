//
//  WallPaperCell.m
//  UI_爱新闻
//
//  Created by fanweilian on 15/10/12.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "WallPaperCell.h"
#import "UIImageView+WebCache.h"
#import "WallPaperModel.h"
#import "NBClickedImageVIew.h"
@interface WallPaperCell()
@property (weak, nonatomic) IBOutlet NBClickedImageVIew *lefeImage;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet NBClickedImageVIew *middleImage;
@property (weak, nonatomic) IBOutlet UILabel *middleLabel;
@property (weak, nonatomic) IBOutlet NBClickedImageVIew *rightImage;

@property (weak, nonatomic) IBOutlet UILabel *rightLabel;


@end
@implementation WallPaperCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)updateCellWithModelArray:(NSArray *)modeArray tapBlock:(void (^)(NSInteger))block{
    
    if (modeArray.count >0) {
        WallPaperModel *model=modeArray[0];
        [self.lefeImage sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@"placeholder-pic"]];
        self.lefeImage.tapTag=0;
        self.lefeImage.tapBlock=block;
        self.leftLabel.text=model.title;
    }
    if (modeArray.count>1) {
        WallPaperModel *model=modeArray[1];
        [self.middleImage sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@"placeholder-pic"]];
        self.middleImage.tapTag=1;
        self.middleImage.tapBlock=block;
        self.middleLabel.text=model.title;
    }
    if (modeArray.count>2) {
        WallPaperModel *model=modeArray[2];
        [self.rightImage sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@"placeholder-pic"]];
        self.rightImage.tapTag=2;
        self.rightImage.tapBlock=block;
        self.rightLabel.text=model.title;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
