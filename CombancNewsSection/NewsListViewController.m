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
#import "NewsInterfaceMacro.h"
#import "NewInterfaceRequest.h"
#import "Masonry.h"
#import "MJRefresh.h"

static NSString *const NewsCellID = @"NewsCellID";

@interface NewsListViewController ()<
UITableViewDelegate,
UITableViewDataSource,
UISearchBarDelegate
>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSize;

@end

@implementation NewsListViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.pageSize = 10;
    [self configUI];
    [self requestNewslistWithSearch:@""];
    [self createRefresh];
}

- (void)createRefresh {
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageSize = 10;
        [self requestNewslistWithSearch:@""];
    }];
    
    self.myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.pageSize += 10;
        [self requestNewslistWithSearch:@""];
    }];
}

- (void)requestNewslistWithSearch:(NSString *)searchStr {
    [NewInterfaceRequest requestNewsList:newslistParam([@(self.page) description], [@(self.pageSize) description], @"", @"", @"", searchStr) success:^(id json) {
        self.dataArray = json;
        [self.myTableView reloadData];
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
    } failed:^(NSError *error) {
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
    }];
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
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsListCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NewsCellID];
    if (!cell) {
        cell = [[NewsListCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NewsCellID];
    }
    NewslistModel *model = self.dataArray[indexPath.row];
    cell.titleLabel.text = model.title;
    cell.timeLabel.text = model.createTime;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NewsDetailViewController *newsDetailVC = [[NewsDetailViewController alloc]init];
    newsDetailVC.model = self.dataArray[indexPath.row];
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
    [self requestNewslistWithSearch:@""];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
    [self requestNewslistWithSearch:searchBar.text];
}

@end
