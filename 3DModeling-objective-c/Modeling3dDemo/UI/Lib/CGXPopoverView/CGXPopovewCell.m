//
//  CGXPopovewCell.m
//  CGXPopoverVIew
//
//  Created by CGX on 2018/6/6.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import "CGXPopovewCell.h"
// extern
float const CGXPopovewCellHorizontalMargin = 15.f; ///< 水平边距
float const CGXPopovewCellVerticalMargin = 3.f; ///< 垂直边距
float const CGXPopovewCellTitleLeftEdge = 8.f; ///< 标题左边边距

@interface CGXPopovewCell ()



@end

@implementation CGXPopovewCell
#pragma mark - Life Cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = self.backgroundColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        self.backgroundColor = _style == CGXPopoverManagerItemDark ? [UIColor colorWithRed:0.23 green:0.23 blue:0.23 alpha:1.00] :  [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.00];
    } else {
        [UIView animateWithDuration:0.3f animations:^{
            self.backgroundColor = [UIColor clearColor];
        }];
    }
}
#pragma mark - Setter
- (void)setStyle:(CGXPopoverManagerItemStyle)style {
    _style = style;
    _bottomLine.backgroundColor = [self.class bottomLineColorForStyle:style];
    if (_style == CGXPopoverManagerItemDefault) {
        [_button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    } else {
        [_button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    }
}
- (UIView *)bottomLine
{
    if (!_bottomLine) {
        // 底部线条
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1.00];
        _bottomLine.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_bottomLine];
        _bottomLine.frame = CGRectMake(0, self.contentView.frame.size.height-1, self.contentView.frame.size.width, 1);
    }
    return _bottomLine;
}
- (UIButton *)button
{
    if (!_button) {
        // UI
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.userInteractionEnabled = NO; // has no use for UserInteraction.
        _button.translatesAutoresizingMaskIntoConstraints = NO;
        _button.titleLabel.font = [UIFont systemFontOfSize:15.f];
        _button.backgroundColor = self.contentView.backgroundColor;
        _button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [self.contentView addSubview:_button];
        // Constraint
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[_button]-margin-|" options:kNilOptions metrics:@{@"margin" : @(CGXPopovewCellHorizontalMargin)} views:NSDictionaryOfVariableBindings(_button)]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[_button]-margin-|" options:kNilOptions metrics:@{@"margin" : @(CGXPopovewCellVerticalMargin)} views:NSDictionaryOfVariableBindings(_button)]];
    }
    return _button;
}


/*! @brief 底部线条颜色 */
+ (UIColor *)bottomLineColorForStyle:(CGXPopoverManagerItemStyle)style {
    return style == CGXPopoverManagerItemDark ? [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1.00] : [UIColor colorWithRed:0.29 green:0.29 blue:0.29 alpha:1.00];
}

- (void)setAction:(CGXPopoverItem *)action {
    [self.button setTitle:action.title forState:UIControlStateNormal];
    if (action.image) {
        [self.button setImage:action.image forState:UIControlStateNormal];
    }
    if (action.titleColor) {
        [self.button setTitleColor:action.titleColor forState:UIControlStateNormal];
    }
    if (action.titleFont) {
        [self.button.titleLabel setFont:action.titleFont];
    }
    self.button.titleEdgeInsets = action.image ? UIEdgeInsetsMake(0, CGXPopovewCellTitleLeftEdge, 0, -CGXPopovewCellTitleLeftEdge) : UIEdgeInsetsZero;
}

- (void)showBottomLine:(BOOL)show {
    _bottomLine.hidden = !show;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
