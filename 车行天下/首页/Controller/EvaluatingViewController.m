//
//  EvaluatingViewController.m
//  车行天下
//
//  Created by 剑试蔷薇 on 15/11/10.
//  Copyright (c) 2015年 余晓光. All rights reserved.
//

#import "EvaluatingViewController.h"

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

@interface EvaluatingViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *evaluatingNewsFrame;

@property (nonatomic, weak) WebViewController *webVC;
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, assign) int offset;
@property (nonatomic, assign) int count;

@end

@implementation EvaluatingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tableView
    [self setupTableView];
    // 下拉加载最新数据
    [self pullDownToRefreshEvaluatingNews];
    // 上拉加载更多数据
    [self pullUpToLoadMoreVideoNews];
}

#pragma mark - 刷新数据
/*
 *  下拉加载最新数据
 */
- (void)pullDownToRefreshEvaluatingNews {
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requesEvaluatingNews)];
    // 设置header
    [self.tableView.header beginRefreshing];
}

/*
 *  上拉加载更多数据
 */
- (void)pullUpToLoadMoreVideoNews {
    __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestMoreEvaluatingNews];
    }];
}

- (void)requesEvaluatingNews {
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[LIMIT] = @10;
    paras[OFFSET] = @0;
    paras[TYPE] = @3;
    paras[VER] = @"6.2";
    
    [HttpTool get:kGetCarNewsURL params:paras success:^(id json) {
        // 通过数组字典返回模型，该数组中装的都是TSEHomeViewNews模型
        NSArray *evaNewsArr = [HomeViewNews objectArrayWithKeyValuesArray:json[@"newsList"]];
        
        // 创建frame模型对象
        NSMutableArray *newsArray = [NSMutableArray array];
        for (HomeViewNews *news in evaNewsArr) {
            HomeViewNewsCellFrame *f = [[HomeViewNewsCellFrame alloc] init];
            f.homeViewNews = news;
            [newsArray addObject:f];
        }
        
        self.evaluatingNewsFrame = newsArray;
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

- (void)requestMoreEvaluatingNews {
    _count += 10;
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[LIMIT] = @10;
    _offset = _count; // 每次上拉刷新参数"offset"会动态加10
    paras[OFFSET] = [NSString stringWithFormat:@"%d", _offset];
    paras[TYPE] = @3;
    paras[VER] = @"6.2";
    
    [HttpTool get:kGetCarNewsURL params:paras success:^(id json) {
        // 通过数组字典返回模型，该数组中装的都是XZMDoesticCarNews模型
        NSArray *evaNewsArr = [HomeViewNews objectArrayWithKeyValuesArray:json[@"newsList"]];
        
        // 创建frame模型对象
        NSMutableArray *newsArray = [NSMutableArray array];
        for (HomeViewNews *news in evaNewsArr) {
            HomeViewNewsCellFrame *f = [[HomeViewNewsCellFrame alloc] init];
            f.homeViewNews = news;
            [newsArray addObject:f];
        }
        
        [self.evaluatingNewsFrame addObjectsFromArray:newsArray];
        // 刷新tableView
        [self.tableView reloadData];
        // 停止刷新
        [self.tableView.footer endRefreshing];
        
    } failure:^(NSError *error) {
        NSLog(@"fail:%@", error);
        [self.tableView.footer endRefreshing];
    }];
}

#pragma mark - TableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.evaluatingNewsFrame.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1.创建TSEHomeViewNewsCell
    HomeViewNewsCell *cell = [HomeViewNewsCell cellWithTableView:tableView];
    // 2.设置cell的属性
    cell.homeViewNewsCellFrame = self.evaluatingNewsFrame[indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate methods
/**
 *  根据相应的数据设置cell的高度
 *
 *  @param indexPath cell的位置
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeViewNewsCellFrame *lnf = self.evaluatingNewsFrame[indexPath.row];
    return lnf.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeViewNewsCellFrame *f = self.evaluatingNewsFrame[indexPath.row];
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
