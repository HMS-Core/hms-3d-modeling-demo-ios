//
//  CGXPopoverManager.h
//  CGXPopoverViewDemo
//
//  Created by CGX on 2018/6/13.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, CGXPopoverManagerItemStyle) {
    CGXPopoverManagerItemDefault, // 默认风格, 白色
    CGXPopoverManagerItemDark // 黑色风格
};

// 弹窗箭头的样式
typedef NS_ENUM(NSUInteger, CGXPopoverManagerArrowStyle) {
    CGXPopoverManagerArrowStyleRound, // 圆角
    CGXPopoverManagerArrowStyleTriangle   // 菱角
};

@interface CGXPopoverManager : NSObject


@property (nonatomic, strong) NSMutableArray *modleArray;

@property (nonatomic, strong) NSIndexPath *selectIndexPath;
/**
 是否开启点击外部隐藏弹窗, 默认为YES.
 */
@property (nonatomic, assign) BOOL hideAfterTouchOutside;

/**
 是否显示阴影, 如果为YES则弹窗背景为半透明的阴影层,  默认为YES.
 */
@property (nonatomic, assign) BOOL showShade;
/**
 是否有动画, 默认为YES.
 */
@property (nonatomic, assign) BOOL isAnimate;
/**
 动画时间。默认5秒
 */
@property (nonatomic, assign) CGFloat timeInterval;

/**
 指示箭头的宽 默认30
 */
@property (nonatomic, assign) CGFloat arrowWidth;
/**
 边框圆角 默认6
 */
@property (nonatomic, assign) CGFloat cornerRadius;

/**
 动画选中颜色。默认5秒
 */
@property (nonatomic, strong) UIColor *selectTitleColor;

/**
 弹出窗风格, 默认为 CGXPopoverManagerItemDark(灰色).
 */
@property (nonatomic, assign) CGXPopoverManagerItemStyle style;

/**
 箭头样式, 默认为 PopoverViewArrowStyleRound.
 如果要修改箭头的样式, 需要在显示先设置.
 */
@property (nonatomic, assign) CGXPopoverManagerArrowStyle arrowStyle;


@end
