//
//  UIColor+NewsCategory.h
//  OANoticeNews
//
//  Created by Golden on 2018/9/26.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (NewsCategory)

+ (UIColor *)colorWithHex:(NSString *)hexColor;

+ (UIImage *)createImageWithColor:(UIColor *)color;

@end
