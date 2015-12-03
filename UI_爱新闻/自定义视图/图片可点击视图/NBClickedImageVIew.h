//
//  NBClickedImageVIew.h
//  UI_爱新闻
//
//  Created by fanweilian on 15/10/12.
//  Copyright (c) 2015年 YuTengxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NBClickedImageVIew : UIImageView
@property(nonatomic,assign) NSInteger tapTag;
@property(nonatomic,copy) void (^tapBlock)(NSInteger tapTag);
@end
