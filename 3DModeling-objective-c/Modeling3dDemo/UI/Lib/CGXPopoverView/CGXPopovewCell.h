//
//  CGXPopovewCell.h
//  CGXPopoverVIew
//
//  Created by CGX on 2018/6/6.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXPopoverItem.h"
#import "CGXPopoverManager.h"
UIKIT_EXTERN float const CGXPopovewCellHorizontalMargin; ///< 水平间距边距
UIKIT_EXTERN float const CGXPopovewCellVerticalMargin; ///< 垂直边距
UIKIT_EXTERN float const CGXPopovewCellTitleLeftEdge; ///< 标题左边边距

@interface CGXPopovewCell : UITableViewCell

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, assign) CGXPopoverManagerItemStyle style;

/*! @brief 底部线条颜色
 */
+ (UIColor *)bottomLineColorForStyle:(CGXPopoverManagerItemStyle)style;

- (void)setAction:(CGXPopoverItem *)action;

- (void)showBottomLine:(BOOL)show;

@end
