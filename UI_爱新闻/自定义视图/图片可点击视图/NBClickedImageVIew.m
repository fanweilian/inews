//
//  NBClickedImageVIew.m
//  UI_爱新闻
//
//  Created by fanweilian on 15/10/12.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import "NBClickedImageVIew.h"

@implementation NBClickedImageVIew

-(instancetype)initWithFrame:(CGRect)frame{

    if (self=[super initWithFrame:frame]) {
        self.userInteractionEnabled=YES;
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{

    if (self=[super initWithCoder:aDecoder]) {
        self.userInteractionEnabled=YES;
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    if (self.tapBlock) {
        self.tapBlock(self.tapTag);
    }
}
@end
