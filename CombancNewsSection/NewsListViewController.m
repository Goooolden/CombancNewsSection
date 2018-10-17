//
//  NewsListViewController.m
//  OANoticeNews
//
//  Created by Golden on 2018/9/11.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import "NewsListViewController.h"
#import "NewsListCellTableViewCell.h"
#import "NewsModel.h"
#import "NewsDetailViewController.h"
#import "UIColor+NewsCategory.h"

#import "Masonry.h"

static NSString *const NewsCellID = @"NewsCellID";

@interface NewsListViewController ()<
UITableViewDelegate,
UITableViewDataSource,
UISearchBarDelegate
>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation NewsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)configUI {
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.showsVerticalScrollIndicator = NO;
    self.myTableView.showsHorizontalScrollIndicator = NO;
    self.myTableView.tableFooterView = [UIView new];
    self.myTableView.estimatedRowHeight = 80;
    self.myTableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.myTableView];
    
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectZero];
    [self.searchBar setPlaceholder:@"搜索"];
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:@"取消"];
    [self.searchBar setTintColor:[UIColor blueColor]];
    [self.searchBar setShowsCancelButton:NO animated:YES];
    [self.searchBar setBackgroundImage:[UIColor createImageWithColor:[UIColor colorWithHex:@"#EBEBF1"]]];
    UIView *searchTextField = [[[self.searchBar.subviews firstObject] subviews] lastObject];
    [searchTextField setBackgroundColor:[UIColor whiteColor]];
    self.searchBar.delegate = self;
    [self.searchBar sizeToFit];
    [self.view addSubview:self.searchBar];
    
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.right.equalTo(self.view);
    }];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchBar.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - TableViewDelegate&&DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsListCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NewsCellID];
    if (!cell) {
        cell = [[NewsListCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NewsCellID];
    }
    cell.titleLabel.text = @"关于全面加强乡村小规模和乡镇寄宿制学校建设的指导意见";
    cell.timeLabel.text = @"2018-02-08 12:30:00";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NewsDetailViewController *newsDetailVC = [[NewsDetailViewController alloc]init];
    [self.navigationController pushViewController:newsDetailVC animated:YES];
}

#pragma mark - SearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [self.searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
    [self.searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
}

@end