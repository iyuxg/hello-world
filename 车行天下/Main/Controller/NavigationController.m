//
//  NavigationController.m
//  车行天下
//
//  Created by 剑试蔷薇 on 15/11/9.
//  Copyright (c) 2015年 余晓光. All rights reserved.
//

#import "NavigationController.h"
#import "Public.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    NSDictionary *attrNavBar = @{NSFontAttributeName : [UIFont systemFontOfSize:18.0f], NSForegroundColorAttributeName : Color(41, 51, 57)};
    [navBar setTitleTextAttributes:attrNavBar];
    [navBar setBackgroundColor:Color(248, 248, 248)];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
