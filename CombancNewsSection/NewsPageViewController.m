//
//  NewsPageViewController.m
//  OANoticeNews
//
//  Created by Golden on 2018/9/11.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import "NewsPageViewController.h"
#import "NewsListViewController.h"
#import "UIColor+NewsCategory.h"
#import "NewsInterfaceMacro.h"

@interface NewsPageViewController ()

@end

@implementation NewsPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (instancetype)init {
    if (self = [super init]) {
        self.pageAnimatable = NO;
        self.titleSizeSelected = 16;
        self.titleSizeNormal = 16;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.titleColorSelected = [UIColor colorWithHex:@"#007aff"];
        self.titleColorNormal = [UIColor colorWithHex:@"#38383d"];
        self.titleFontName = @"PingFangSC-Medium";
        self.menuHeight = 50.0f;
        self.menuItemWidth = 40.0f;
        self.menuBGColor = [UIColor whiteColor];
        self.progressWidth = 40.0f;
    }
    return self;
}

- (void)setToken:(NSString *)token {
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:NewsToken];
}

- (NSArray *)titles {
    return @[@"教学",@"公示",@"考试",@"教育"];
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titles.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.titles[index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    NewsListViewController *newsListVC = [[NewsListViewController alloc]init];
    return newsListVC;
}

@end
