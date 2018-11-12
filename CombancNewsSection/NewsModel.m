//
//  NewsModel.m
//  OANoticeNews
//
//  Created by Golden on 2018/9/26.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import "NewsModel.h"
#import "MJExtension.h"

@implementation NewsModel

@end

@implementation NewslistModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"files":@"NewsFileImgsModel",
             @"imgs":@"NewsFileImgsModel"
             };
}

@end

@implementation NewsFileImgsModel

@end
