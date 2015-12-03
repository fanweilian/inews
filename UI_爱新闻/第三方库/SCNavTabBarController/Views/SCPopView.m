//
//  SCPopView.m
//  SCNavTabBarController
//
//  Created by ShiCang on 14/11/17.
//  Copyright (c) 2014年 SCNavTabBarController. All rights reserved.
//

#import "SCPopView.h"
#import "CommonMacro.h"

@interface SCPopView () {
    NSMutableArray *_buttonArray;
}

@end

@implementation SCPopView

#pragma mark - Private Methods
#pragma mark -
- (NSArray *)getButtonsWidthWithTitles:(NSArray *)titles;
{
    NSMutableArray *widths = [@[] mutableCopy];
    
    for (NSString *title in titles)
    {
        /* yutx modified 2015-09-10 iOS7以后，废弃了这个方法，因此这里进行判断，兼容iOS7及以上 */
        /*
        CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
        
         */
        CGSize size;
        if (IS_OS_7_OR_LATER) {
            NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:[UIFont systemFontSize]]};
            size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
        } else {
            size = [title sizeWithFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
        }
        /* yutx modified end 2015-09-10 */
        NSNumber *width = [NSNumber numberWithFloat:size.width + 40.0f];
        [widths addObject:width];
    }
    
    return widths;
}

- (void)updateSubViewsWithItemWidths:(NSArray *)itemWidths;
{
    /* yutx added 2015-09-10 增加一个数组，来管理button */
    if (!_buttonArray) {
        _buttonArray = [[NSMutableArray alloc] init];
    }
    /* yutx added end 2015-09-10 */

    CGFloat buttonX = DOT_COORDINATE;
    CGFloat buttonY = DOT_COORDINATE;
    for (NSInteger index = 0; index < [itemWidths count]; index++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = index;
        button.frame = CGRectMake(buttonX, buttonY, [itemWidths[index] floatValue], ITEM_HEIGHT);
        [button setTitle:_itemNames[index] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
        /* yutx added 2015-09-10 */
        [_buttonArray addObject:button];
        /* yutx added end 2015-09-10 */

        [self addSubview:button];
        
        buttonX += [itemWidths[index] floatValue];
        
        @try {
            /* yutx modified 2015-09-10 更改了_popView的显示位置，会对_arrowButton造成影响 */
            /*
            if ((buttonX + [itemWidths[index + 1] floatValue]) >= SCREEN_WIDTH)
             */
            if ((buttonX + [itemWidths[index + 1] floatValue]) >= SCREEN_WIDTH - (buttonY == 0 ? ARROW_BUTTON_WIDTH : 0))
            /* yutx modified end 2015-09-10 */
            {
                buttonX = DOT_COORDINATE;
                buttonY += ITEM_HEIGHT;
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }
}

/* yutx added 2015-09-10 */
- (void)markCurrentButtonWithIndex:(NSInteger)currentIndex {
    for (int i=0; i<_buttonArray.count; i++) {
        UIButton *button = (UIButton *)_buttonArray[i];
        if (i == currentIndex) {
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        } else {
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
    }
}
/* yutx added end 2015-09-10 */

- (void)itemPressed:(UIButton *)button
{
    [_delegate itemPressedWithIndex:button.tag];
}

#pragma mark - Public Methods
#pragma marl -
- (void)setItemNames:(NSArray *)itemNames
{
    _itemNames = itemNames;
    
    NSArray *itemWidths = [self getButtonsWidthWithTitles:itemNames];
    [self updateSubViewsWithItemWidths:itemWidths];
}

@end
