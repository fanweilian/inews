//
//  AppsStorageView.m
//  UI_爱新闻
//
//  Created by fanweilian on 15/10/14.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "AppsStorageView.h"

@interface AppsStorageView ()

@property(nonatomic,copy) void (^block)(void);


@end

@implementation AppsStorageView
- (IBAction)storageButtonClick:(UIButton *)sender {
    if (self.block) {
        self.block();
        
    }

    
}

-(void)addStorageBlock:(void (^)(void))block{
    self.block=block;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
