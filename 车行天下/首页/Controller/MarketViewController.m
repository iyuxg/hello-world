//
//  MarketViewController.m
//  车行天下
//
//  Created by 剑试蔷薇 on 15/11/10.
//  Copyright (c) 2015年 余晓光. All rights reserved.
//
#import "MarketViewController.h"

#import "NavigationController.h"
#import "WebViewController.h"
#import "BarButtonItem.h"

#import "MJExtension.h"
#import "MJRefresh.h"

#import "HttpTool.h"
#import "HomeViewNews.h"
#import "HomeViewNewsCell.h"
#import "HomeViewNewsCellFrame.h"

#import "Public.h"

@interface MarketViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *marketNewsFrame;

@property (nonatomic, weak) WebViewController *webVC;
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, assign) int offset;
@property (nonatomic, assign) int count;

@end

@implementation MarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tableView
    [self setupTableView];
    
    // 下拉加载最新数据
    [self pullDownToRefreshMarketNews];
    
    // 上拉加载更多数据
    [self pullUpToLoadMoreMarketNews];
}

#pragma mark - 刷新数据
/*
 *  下拉加载最新数据
 */
- (void)pullDownToRefreshMarketNews {
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requesMarketNews)];
    // 设置header
    [self.tableView.header beginRefreshing];
}

/*
 *  上拉加载更多数据
 */
- (void)pullUpToLoadMoreMarketNews {
    __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestMoreMarketNews];
    }];
}

- (void)requesMarketNews {
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[LIMIT] = @10;
    paras[OFFSET] = @0;
    paras[TYPE] = @5;
    paras[VER] = @"6.2";
    
    [HttpTool get:kGetCarNewsURL params:paras success:^(id json) {
//        TSELog(@"carnews------/n%@", json);
        
        // 通过数组字典返回模型，该数组中装的都是TSEHomeViewNews模型
        NSArray *marketNewsArr = [HomeViewNews objectArrayWithKeyValuesArray:json[@"newsList"]];
        
        // 创建frame模型对象
        NSMutableArray *newsArray = [NSMutableArray array];
        for (HomeViewNews *news in marketNewsArr) {
            HomeViewNewsCellFrame *f = [[HomeViewNewsCellFrame alloc] init];
            f.homeViewNews = news;
            [newsArray addObject:f];
        }
        
        self.marketNewsFrame = newsArray;
        // 刷新tableView
        [self.tableView reloadData];
        // 结束刷新状态
        [self.tableView.header endRefreshing];
        
    } failure:^(NSError *error) {
        NSLog(@"error:%@", error);
        // 结束刷新状态
        [self.tableView.header endRefreshing];
    }];
}

- (void)requestMoreMarketNews {
    _count += 10;
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[LIMIT] = @10;
    _offset = _count; // 每次上拉刷新参数"offset"会动态加10
    paras[OFFSET] = [NSString stringWithFormat:@"%d", _offset];
    paras[TYPE] = @5;
    paras[VER] = @"6.2";
    
    [HttpTool get:kGetCarNewsURL params:paras success:^(id json) {
        // 通过数组字典返回模型，该数组中装的都是XZMDoesticCarNews模型
        NSArray *marketNewsArr = [HomeViewNews objectArrayWithKeyValuesArray:json[@"newsList"]];
        
        // 创建frame模型对象
        NSMutableArray *newsArray = [NSMutableArray array];
        for (HomeViewNews *news in marketNewsArr) {
            HomeViewNewsCellFrame *f = [[HomeViewNewsCellFrame alloc] init];
            f.homeViewNews = news;
            [newsArray addObject:f];
        }
        
        [self.marketNewsFrame addObjectsFromArray:newsArray];
        // 刷新tableView
        [self.tableView reloadData];
        // 停止刷新
        [self.tableView.footer endRefreshing];
        
    } failure:^(NSError *error) {
        NSLog(@"fail------%@", error);
        [self.tableView.footer endRefreshing];
    }];
}

#pragma mark - Table view datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.marketNewsFrame.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1.创建TSEHomeViewNews
    HomeViewNewsCell *cell = [HomeViewNewsCell cellWithTableView:tableView];
    // 2.设置cell的属性
    cell.homeViewNewsCellFrame = self.marketNewsFrame[indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate methods
/**
 *  根据相应的数据设置cell的高度
 *
 *  @param indexPath cell的位置
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeViewNewsCellFrame *lnf = self.marketNewsFrame[indexPath.row];
    return lnf.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeViewNewsCellFrame *f = self.marketNewsFrame[indexPath.row];
    HomeViewNews *news = f.homeViewNews;
    WebViewController *webVC = [[WebViewController alloc] init];
    webVC.urlStr = news.newsLink;
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    // 设置tableView的额外滚动区域
    [tableView setContentInset:UIEdgeInsetsMake(0, 0, TableViewContentInset, 0)];
    [tableView setBackgroundColor:Color(248, 248, 248)];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

@end
