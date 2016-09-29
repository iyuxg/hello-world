//
//  MainController.m
//  车行天下
//
//  Created by 剑试蔷薇 on 15/11/9.
//  Copyright (c) 2015年 余晓光. All rights reserved.
//

#import "MainController.h"
#import "NavigationController.h"

#import "LatestNewsViewController.h"
#import "VideoViewController.h"
#import "GuideViewController.h"
#import "EvaluatingViewController.h"
#import "MarketViewController.h"

#import "ChoicePostsViewController.h"
#import "HotPostsViewController.h"
#import "GodPostViewController.h"

#import "AboutMeViewController.h"



#import "WMPageController.h"

#import "Public.h"

#define kTitlesNormalColor Color(45, 48, 53)
#define kTitleSelectedColor Color(63, 169, 213)

@interface MainController ()

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMainViewController];
}

- (void)initMainViewController {
    
    // 1.
    // 1.1
    NSMutableArray *homeVCs = [[NSMutableArray alloc] init];
    NSMutableArray *homeVCTitles = [[NSMutableArray alloc] init];
    for (int i = 0; i < 5; i++) {
        Class vcClass;
        NSString *title;
        switch (i) {
            case 0:
                vcClass = [LatestNewsViewController class];
                title = @"最新";
                break;
            case 1:
                vcClass = [VideoViewController class];
                title = @"视频";
                break;
            case 2:
                vcClass = [GuideViewController class];
                title = @"导购";
                break;
            case 3:
                vcClass = [EvaluatingViewController class];
                title = @"测评";
                break;
            case 4:
                vcClass = [MarketViewController class];
                title = @"行情";
                break;
        }
        [homeVCs addObject:vcClass];
        [homeVCTitles addObject:title];
    }
    
    WMPageController *homeVC = [[WMPageController alloc] initWithViewControllerClasses:homeVCs andTheirTitles:homeVCTitles];
    UINavigationController *homeNav =  [[UINavigationController alloc] initWithRootViewController:homeVC];
    homeVC.menuViewStyle = WMMenuViewStyleLine;
    homeVC.menuItemWidth = 66;
    homeVC.titleColorNormal = kTitlesNormalColor;
    homeVC.titleColorSelected = kTitleSelectedColor;
    homeVC.postNotification = YES;
    
    UILabel *homelabel=[[UILabel alloc]init];
    homelabel.textAlignment=NSTextAlignmentCenter;
    homelabel.frame=CGRectMake(0, 0, 40, 21);
    homelabel.text=@"首页";
    homelabel.textColor=kTitleSelectedColor;
    homeVC.navigationItem.titleView=homelabel;
    
    // 1.2
    NSMutableArray *bbsVCs = [[NSMutableArray alloc] init];
    NSMutableArray *bbsVCTitles = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i++) {
        Class vcClass;
        NSString *title;
        switch (i) {
            case 0:
                vcClass = [ChoicePostsViewController class];
                title = @"精选";
                break;
            case 1:
                vcClass = [HotPostsViewController class];
                title = @"热帖";
                break;
                
            case 2:
                vcClass =[GodPostViewController class];
                title = @"神帖";
                break;
            
        }
        [bbsVCs addObject:vcClass];
        [bbsVCTitles addObject:title];
    }
    
    WMPageController *bbsVC = [[WMPageController alloc] initWithViewControllerClasses:bbsVCs andTheirTitles:bbsVCTitles];
    UINavigationController *bbsNav =  [[UINavigationController alloc] initWithRootViewController:bbsVC];
    bbsVC.menuViewStyle = WMMenuViewStyleLine;
    bbsVC.menuItemWidth = 106;
    bbsVC.titleColorNormal = kTitlesNormalColor;
    bbsVC.titleColorSelected = kTitleSelectedColor;
    bbsVC.postNotification = YES;
    
    UILabel *bbslabel=[[UILabel alloc]init];
    bbslabel.textAlignment=NSTextAlignmentCenter;
    bbslabel.frame=CGRectMake(0, 0, 40, 21);
    bbslabel.text=@"论坛";
    bbslabel.textColor=kTitleSelectedColor;
    bbsVC.navigationItem.titleView=bbslabel;
    
    
    // 1.3
    AboutMeViewController *about=[[AboutMeViewController alloc]init];
    UINavigationController *aboutNav=[[UINavigationController alloc]initWithRootViewController:about];
    UILabel *label=[[UILabel alloc]init];
    label.textAlignment=NSTextAlignmentCenter;
    label.frame=CGRectMake(0, 0, 40, 21);
    label.text=@"关于车行天下";
    label.textColor=kTitleSelectedColor;
    about.navigationItem.titleView=label;
    
    
    // 2.初始化tabBarCtr
    NSArray *viewCtrs = @[homeNav, bbsNav,aboutNav];
    [self setViewControllers:viewCtrs animated:YES];
    UITabBar *tabBar = self.tabBar;
    
    // 3.设置控制器属性
    [self setupChildViewController:homeVC title:@"首页1" imageName:@"tab_shouye_baitian" selectedImageName:@"tab_shouye_baitian_hit" tabBar:tabBar index:0];
    
    [self setupChildViewController:bbsVC title:@"论坛" imageName:@"tab_luntan_baitian" selectedImageName:@"tab_luntan_baitian_hit" tabBar:tabBar index:1];
    
    [self setupChildViewController:aboutNav title:@"汽车" imageName:@"tab_zhaoche_baitian" selectedImageName:@"tab_zhaoche_baitian_hit" tabBar:tabBar index:2];
    
    
    // 改变UITabBarItem字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:Color(43, 177, 223),NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
}

- (void)setupChildViewController:(UIViewController *)childVC
                           title:(NSString *)title
                       imageName:(NSString *)imageName
               selectedImageName:(NSString *)selectedImageName
                          tabBar:(UITabBar *)tabBar
                           index:(NSUInteger)index {
    childVC.title = title;
    UITabBarItem *item = [tabBar.items objectAtIndex:index];
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    // 设置不对图片进行蓝色的渲染
    [item setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item setSelectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
