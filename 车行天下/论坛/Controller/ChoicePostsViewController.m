//
//  ChoicePostsViewController.m
//  车行天下
//
//  Created by 剑试蔷薇 on 15/11/10.
//  Copyright (c) 2015年 余晓光. All rights reserved.
//

#import "ChoicePostsViewController.h"

#import "NavigationController.h"
#import "WebViewController.h"
#import "BarButtonItem.h"

#import "MJExtension.h"
#import "MJRefresh.h"

#import "ChoicePostCellFrame.h"
#import "ChoicePostsCell.h"
#import "ChoicePost.h"
#import "ChoiceFocusPost.h"
#import "XCARLoopView.h"

#import "HttpTool.h"

#import "Public.h"

@interface ChoicePostsViewController () <UITableViewDataSource, UITableViewDelegate, XCARLoopViewDelegate>

@property (nonatomic, strong) NSMutableDictionary *paras;
@property (nonatomic, strong) NSMutableArray *choicePostFrame;
@property (nonatomic, strong) NSArray *focusPost;
@property (nonatomic, strong) NSMutableArray *imgsArr;

@property (nonatomic, weak) WebViewController *webVC;
@property (nonatomic, weak) XCARLoopView *loopView;
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, assign) int offset;
@property (nonatomic, assign) int count;

@end

@implementation ChoicePostsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTopView];
    [self setupHeaderView];
    // 下拉加载最新数据
    [self pullDownToRefreshChoicePost];
    // 上拉加载更多数据
    [self pullUpToLoadMoreChoicePost];
}

#pragma mark - 刷新数据

//下拉加载最新数据

- (void)pullDownToRefreshChoicePost {
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestChoiceNewsData)];
    // 设置header
    [self.tableView.header beginRefreshing];
}


//上拉加载更多数据

- (void)pullUpToLoadMoreChoicePost {
    __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestMoreChoiceNewsData];
    }];
}

- (void)requestChoiceNewsData {
    [HttpTool get:kGetForumInfoURL params:self.paras success:^(id json) {

        
        // 获取滚动新闻
        self.focusPost = [ChoiceFocusPost objectArrayWithKeyValuesArray:json[@"focusPost"]];
        // 设置tableView header
        [self setupTableHeaderViewWithFocusPosts:self.focusPost];
        
        // 通过数组字典返回模型，该数组中装的都是TSEChoicePost模型
        NSArray *postsArr = [ChoicePost objectArrayWithKeyValuesArray:json[@"postList"]];
        // 创建frame模型对象
        NSMutableArray *postArray = [NSMutableArray array];
        for (ChoicePost *post in postsArr) {
            ChoicePostCellFrame *f = [[ChoicePostCellFrame alloc] init];
            f.choicePost = post;
            [postArray addObject:f];
        }
        
        self.choicePostFrame = postArray;
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

- (void)requestMoreChoiceNewsData {
    _count += 10;
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[LIMIT] = @10;
    _offset = _count; // 每次上拉刷新参数"offset"会动态加10
    paras[OFFSET] = [NSString stringWithFormat:@"%d", _offset];
    paras[TYPE] = @1;
    paras[VER] = @"6.2";
    
    [HttpTool get:kGetForumInfoURL params:paras success:^(id json) {
        // 通过数组字典返回模型，该数组中装的都是TSEChoicePost模型
        NSArray *postsArr = [ChoicePost objectArrayWithKeyValuesArray:json[@"postList"]];
        
        // 创建frame模型对象
        NSMutableArray *postArray = [NSMutableArray array];
        for (ChoicePost *post in postsArr) {
            ChoicePostCellFrame *f = [[ChoicePostCellFrame alloc] init];
            f.choicePost = post;
            [postArray addObject:f];
        }
        
        [self.choicePostFrame addObjectsFromArray:postArray];
        // 刷新tableView
        [self.tableView reloadData];
        // 停止刷新
        [self.tableView.footer endRefreshing];
        
    } failure:^(NSError *error) {
        NSLog(@"fail:%@", error);
        [self.tableView.footer endRefreshing];
    }];
}

- (void)setupTableHeaderViewWithFocusPosts:(NSArray *)focusPosts {
    // 异步下载图片
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{

        self.imgsArr = [NSMutableArray array];
        for (ChoiceFocusPost *post in focusPosts) {
            NSString *urlStr = post.focusImage;
            NSURL *imageUrl = [NSURL URLWithString:urlStr];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
            [self.imgsArr addObject:image];
        }
        
        // 当图片下载完成后，在主线程设置tableHeaderView的数据
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.loopView setLoopViewImages:self.imgsArr autoPlay:YES delay:4.0];
        });
    });
}

#pragma mark - TableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.choicePostFrame count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChoicePostsCell *cell = [ChoicePostsCell cellWithTableView:tableView];
    cell.choicePostCellFrame = self.choicePostFrame[indexPath.row];
    
    return cell;
}

#pragma mark - TableViewdelegate
//根据相应的数据设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChoicePostCellFrame *c = self.choicePostFrame[indexPath.row];
    return c.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ChoicePostCellFrame *f = self.choicePostFrame[indexPath.row];
    ChoicePost  *post = f.choicePost;
    WebViewController *webVC = [[WebViewController alloc] init];
    webVC.urlStr = post.postLink;
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - LoopView delegate
- (void)loopViewDidSelectedImage:(XCARLoopView *)loopView index:(int)index {
    
    ChoiceFocusPost *post = self.focusPost[index];
    WebViewController *webVC = [[WebViewController alloc] init];
    webVC.urlStr = post.focusLink;
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - 懒加载
- (NSMutableDictionary *)paras {
    if (!_paras) {
        _paras = [NSMutableDictionary dictionary];
        _paras[LIMIT] = @20;
        _paras[OFFSET] = @0;
        _paras[TYPE] = @1;
        _paras[VER] = @"6.2";
    }
    return _paras;
}

#pragma mark - tableview相关
- (void)setupTopView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight ) style:UITableViewStylePlain];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    // 设置tableView的额外滚动区域
    [tableView setBackgroundColor:Color(248, 248, 248)];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
}

//广告回滚图片
- (void)setupHeaderView {
    XCARLoopView *loopView = [[XCARLoopView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width / 1.8f)];
    loopView.delegate = self;
    self.tableView.tableHeaderView = loopView;
    self.loopView = loopView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
