//
//  HotPostsViewController.m
//  车行天下
//
//  Created by 剑试蔷薇 on 15/11/10.
//  Copyright (c) 2015年 余晓光. All rights reserved.
//

#import "HotPostsViewController.h"

#import "NavigationController.h"
#import "WebViewController.h"
#import "BarButtonItem.h"

#import "MJExtension.h"
#import "MJRefresh.h"

#import "HotPostCellFrame.h"
#import "HotPostCell.h"
#import "HotPost.h"


#import "HttpTool.h"

#import "Public.h"

@interface HotPostsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) WebViewController *webVC;
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *hotPostFrame;
@property (nonatomic, strong) NSMutableDictionary *paras;

@property (nonatomic, assign) int offset;
@property (nonatomic, assign) int count;

@end

@implementation HotPostsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tableView
    [self setupTableView];
    // 下拉刷新最新数据
    [self pullDownToRefreshHotPostData];
    // 上拉加载更多数据
    [self pullUpToLoadMoreHotPostData];
}

#pragma mark - 刷新数据
/*
 *  下拉加载最新数据
 */
- (void)pullDownToRefreshHotPostData {
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestHotPostData)];
    // 设置header
    [self.tableView.header beginRefreshing];
}

/*
 *  上拉加载更多数据
 */
- (void)pullUpToLoadMoreHotPostData {
    __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestMoreHotPostData];
    }];
}

- (void)requestHotPostData {
    [HttpTool get:kGetHotPostURL params:self.paras success:^(id json) {
        
        NSArray *postsArr = [HotPost objectArrayWithKeyValuesArray:json[@"postList"]];

        // 创建frame模型对象
        NSMutableArray *hotPostArray = [NSMutableArray array];
        for (HotPost *post in postsArr) {
            HotPostCellFrame *f = [[HotPostCellFrame alloc] init];
            f.hotPost = post;
            [hotPostArray addObject:f];
        }
        
        self.hotPostFrame = hotPostArray;
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
        
    } failure:^(NSError *error) {
        NSLog(@"error:%@", error);
        [self.tableView.header endRefreshing];
    }];
}

- (void)requestMoreHotPostData {
    _count += 10;
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[LIMIT] = @10;
    _offset = _count; // 每次上拉刷新参数"offset"会动态加10
    paras[OFFSET] = [NSString stringWithFormat:@"%d", _offset];
    paras[VER] = @"6.2";
    
    [HttpTool get:kGetHotPostURL params:paras success:^(id json) {
        // 通过数组字典返回模型，该数组中装的都是TSEHotPost模型
        NSArray *postsArr = [HotPost objectArrayWithKeyValuesArray:json[@"postList"]];
        
        // 创建frame模型对象
        NSMutableArray *postArray = [NSMutableArray array];
        for (HotPost *post in postsArr) {
            HotPostCellFrame *f = [[HotPostCellFrame alloc] init];
            f.hotPost = post;
            [postArray addObject:f];
        }
        
        [self.hotPostFrame addObjectsFromArray:postArray];
        // 刷新tableView
        [self.tableView reloadData];
        // 停止刷新
        [self.tableView.footer endRefreshing];
        
    } failure:^(NSError *error) {
        NSLog(@"fail:%@", error);
        [self.tableView.footer endRefreshing];
    }];
}


#pragma mark - TableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.hotPostFrame count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HotPostCell *cell = [HotPostCell cellWithTableView:tableView];
    cell.hotPostCellFrame = self.hotPostFrame[indexPath.row];
    
    return cell;
}

#pragma mark - TableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HotPostCellFrame *h = self.hotPostFrame[indexPath.row];
    return h.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HotPostCellFrame *f = self.hotPostFrame[indexPath.row];
    HotPost  *post = f.hotPost;WebViewController *webVC = [[WebViewController alloc] init];
    webVC.urlStr = post.postLink;
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - 懒加载
- (NSMutableDictionary *)paras {
    if (!_paras) {
        _paras = [NSMutableDictionary dictionary];
        _paras[LIMIT] = @20;
        _paras[OFFSET] = @0;
        _paras[VER] = @"6.2";
    }
    return _paras;
}
// tableView相关
- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    // 设置tableView的额外滚动区域
    [tableView setContentInset:UIEdgeInsetsMake(0, 0, TableViewContentInset - 30, 0)];
    [tableView setBackgroundColor:Color(248, 248, 248)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
