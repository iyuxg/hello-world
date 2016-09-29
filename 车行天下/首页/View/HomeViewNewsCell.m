//
//  HomeViewNewsCell.m
//  车行天下
//
//  Created by 剑试蔷薇 on 15/11/9.
//  Copyright (c) 2015年 余晓光. All rights reserved.
//

#import "HomeViewNewsCell.h"
#import "HomeViewNewsView.h"
#import "HomeViewNewsCellFrame.h"

#import "UIImageView+WebCache.h"

@interface HomeViewNewsCell ()

/* 父视图 */
@property (nonatomic, weak) HomeViewNewsView *homeViewNewsView;

@end

@implementation HomeViewNewsCell

static NSString * const kCellIdentifier = @"HOMEVIEWNEWS";

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    // 1.从重用对象池中找不用的cell对象
    HomeViewNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    // 2.如果没有找到就自己创建对象
    if (cell == nil) {
        cell = [[HomeViewNewsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 设置cell的背景色
        self.backgroundColor = [UIColor clearColor];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        // 设置主页新闻的frame
        [self setupHomeViewNewsView];
    }
    return self;
}

/*
 *  设置主页新闻的frame
 */
- (void)setupHomeViewNewsView {
    /** 父视图 */
    HomeViewNewsView *homeViewNewsView = [[HomeViewNewsView alloc] init];
    [self.contentView addSubview:homeViewNewsView];
    self.homeViewNewsView = homeViewNewsView;
}

/*
 *  override setter
 */
- (void)setHomeViewNewsCellFrame:(HomeViewNewsCellFrame *)homeViewNewsCellFrame {
    _homeViewNewsCellFrame = homeViewNewsCellFrame;
    // 设置主页新闻数据
    [self setupHomeViewNewsData];
}

/*
 *  设置主页新闻数据
 */
- (void)setupHomeViewNewsData {
    self.homeViewNewsView.homeViewNewsCellFrame = self.homeViewNewsCellFrame;
    self.homeViewNewsView.frame = self.homeViewNewsCellFrame.homeViewNewsViewFrame;
}

/*
 *  在系统初始化cell的frame之前拦截设置cell的frame
 */
- (void)setFrame:(CGRect)frame {
    frame.origin.x = kHomeViewNewsTableViewMargin;
    frame.origin.y += kHomeViewNewsTableViewMargin;
    frame.size.width -= kHomeViewNewsTableViewMargin;
    frame.size.height -= kHomeViewNewsTableViewMargin;
    [super setFrame:frame];
}

@end