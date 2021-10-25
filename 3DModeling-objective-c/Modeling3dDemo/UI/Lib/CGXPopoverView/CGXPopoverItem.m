//
//  CGXPopoverItem.m
//  CGXPopoverVIew
//
//  Created by CGX on 2018/6/6.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import "CGXPopoverItem.h"
@interface CGXPopoverItem ()

@end

@implementation CGXPopoverItem


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleFont = [UIFont systemFontOfSize:14];
        self.titleColor = [UIColor blackColor];
        
        self.alignment = NSTextAlignmentCenter;
        
        self.isSelect= NO;
    }
    return self;
}
+ (instancetype)actionWithTitle:(NSString *)title
{
    return [self actionWithImage:nil Title:title];
}

+ (instancetype)actionWithImage:(UIImage *)image
                          Title:(NSString *)title
{
    return [self actionWithImage:image Title:title TitleFont:[UIFont systemFontOfSize:15] TitleColor:[UIColor blackColor] UserInfo:@{} Alignment:NSTextAlignmentLeft IsSelect:NO];
}
+ (instancetype)actionWithImage:(UIImage *)image
                          Title:(NSString *)title
                       IsSelect:(BOOL)isSelect
{
      return [self actionWithImage:image Title:title TitleFont:[UIFont systemFontOfSize:15] TitleColor:[UIColor blackColor] UserInfo:@{} Alignment:NSTextAlignmentLeft IsSelect:isSelect];
}
+ (instancetype)actionWithImage:(UIImage *)image
                          Title:(NSString *)title
                      TitleFont:(UIFont *)titleFont
                     TitleColor:(UIColor *)titleColor
                       UserInfo:(NSDictionary *)userInfo
                      Alignment:(NSTextAlignment)alignment
                       IsSelect:(BOOL)isSelect;
{
    CGXPopoverItem *action = [[self alloc] init];
    action.image = image;
    action.title = title ? : @"";
    action.userInfo = userInfo;
    action.titleFont = titleFont;
    action.titleColor = titleColor;
    action.alignment = alignment;
    action.isSelect = isSelect;
    return action;
}
@end
