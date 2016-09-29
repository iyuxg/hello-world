//
//  WebViewController.m
//  车行天下
//
//  Created by 剑试蔷薇 on 15/11/9.
//  Copyright (c) 2015年 余晓光. All rights reserved.
//

#import "WebViewController.h"
#import "BarButtonItem.h"
#import "Public.h"

@interface WebViewController () <UIWebViewDelegate, UIGestureRecognizerDelegate>

@end

@implementation WebViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.hidesBottomBarWhenPushed = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWebView];
}

- (void)initWebView {
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.webView.delegate = self;
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    self.navigationItem.leftBarButtonItem = [BarButtonItem barButtonWithImage:@"iconfont-fanhui" title:@"返回" target:self action:@selector(backToLatesetView)];
    
    self.navigationItem.rightBarButtonItem = [BarButtonItem barButtonWithImage:@"iconfont-111" title:nil target:self action:@selector(refreshButtonClick)];

    UILabel *titlelabel=[[UILabel alloc]init];
    titlelabel.frame=CGRectMake(0, 0, 40, 21);
    titlelabel.textAlignment=NSTextAlignmentCenter;
    titlelabel.textColor=Color(81, 165, 192);
    titlelabel.text=@"资讯详情－数据源自互联网";
    self.navigationItem.titleView=titlelabel;
    
    // 为webView添加点击手势
    UITapGestureRecognizer* singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapGesture:)];
    singleTapGesture.delegate = self; // 设置代理
    [self.webView addGestureRecognizer:singleTapGesture];
    
    [self.view addSubview:self.webView];
    
    UISwipeGestureRecognizer *swipe1=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipe1:)];
    [_webView addGestureRecognizer:swipe1];
    //设置轻滑的方向
    swipe1.direction=UISwipeGestureRecognizerDirectionRight;
    
    
    UISwipeGestureRecognizer *swipe2=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipe2:)];
    [_webView addGestureRecognizer:swipe2];
    //设置轻滑的方向
    swipe2.direction=UISwipeGestureRecognizerDirectionLeft;
}

-(void)handleSwipe1:(UISwipeGestureRecognizer*)sender
{
    NSLog(@"111");
//    [_webView goBack];
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)handleSwipe2:(UISwipeGestureRecognizer*)sender
{
    NSLog(@"222");
    [_webView goForward];
    
}

- (void)backToLatesetView {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)refreshButtonClick {
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)handleSingleTapGesture:(UIGestureRecognizer *)sender {
    NSLog(@"noshalei");
    UIWebView *webView = (UIWebView *)sender.view;
    CGPoint pt = [sender locationInView:webView];
    NSString *urlString = [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", pt.x, pt.y]];
    if (urlString.length > 0) {
        NSLog(@"\nImage_URL:%@", urlString);
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES; // 是否允许同时响应多手势，因为UIWebView自身也响应点击事件
}

#pragma mark - WebView delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
}

//网页加载完成的时候调用
- (void )webViewDidFinishLoad:(UIWebView  *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

//网页加载错误的时候调用
- (void)webView:(UIWebView *)webView  didFailLoadWithError:(NSError *)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}










@end
