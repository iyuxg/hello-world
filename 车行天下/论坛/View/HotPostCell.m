//
//  HotPostCell.m
//  车行天下
//
//  Created by 剑试蔷薇 on 15/11/10.
//  Copyright (c) 2015年 余晓光. All rights reserved.
//

#import "HotPostCell.h"

#import "HotPostCellFrame.h"
#import "HotPostsView.h"

#import "Public.h"

@interface HotPostCell ()

/* 父视图 */
@property (nonatomic, weak) HotPostsView *hotPostView;

@end

@implementation HotPostCell

static NSString * const kCellIdentifier = @"HOTPOST";

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    // 1.从重用对象池中找不用的cell对象
    HotPostCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    // 2.如果没有找到就自己创建对象
    if (cell == nil) {
        cell = [[HotPostCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 设置背景颜色
        [self setBackgroundColor:Color(251, 251, 251)];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        // 设置热门帖子视图的frame
        [self setupHotPostsView];
    }
    return self;
}

/*
 *  设置热门帖子视图的frame
 */
- (void)setupHotPostsView {
    /* 父视图 */
    HotPostsView *hotPostView = [[HotPostsView alloc] init];
    [self.contentView addSubview:hotPostView];
    self.hotPostView = hotPostView;
}

/*
 *  override setter
 */
- (void)setHotPostCellFrame:(HotPostCellFrame *)hotPostCellFrame {
    _hotPostCellFrame = hotPostCellFrame;
    // 设置热门帖子数据
    [self setupHotPostData];
}

/*
 *  设置热门帖子数据
 */
- (void)setupHotPostData {
    self.hotPostView.hotPostCellFrame = self.hotPostCellFrame;
    self.hotPostView.frame = self.hotPostCellFrame.hotPostViewFrame;
}

/*
 *  在系统初始化cell的frame之前拦截设置cell的frame
 */
- (void)setFrame:(CGRect)frame {
    frame.origin.x = kHotPostTableViewMargin;
    frame.origin.y += kHotPostTableViewMargin;
    frame.size.width -= kHotPostTableViewMargin;
    frame.size.height -= kHotPostTableViewMargin;
    [super setFrame:frame];
}

@end
