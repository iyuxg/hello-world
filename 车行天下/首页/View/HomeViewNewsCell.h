//
//  HomeViewNewsCell.h
//  车行天下
//
//  Created by 剑试蔷薇 on 15/11/9.
//  Copyright (c) 2015年 余晓光. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeViewNewsCellFrame;
@interface HomeViewNewsCell : UITableViewCell


@property (nonatomic, strong) HomeViewNewsCellFrame *homeViewNewsCellFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end