//
//  ChoicePostsCell.m
//  车行天下
//
//  Created by 剑试蔷薇 on 15/11/10.
//  Copyright (c) 2015年 余晓光. All rights reserved.
//

#import "ChoicePostsCell.h"

#import "ChoicePostsView.h"
#import "ChoicePostCellFrame.h"

#import "UIImageView+WebCache.h"

@interface ChoicePostsCell ()

/* 父视图 */
@property (nonatomic, weak) ChoicePostsView *choicePostView;

@end

@implementation ChoicePostsCell

static NSString * const kCellIdentifier = @"CHOICEPOST";

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    // 1.从重用对象池中找不用的cell对象
    ChoicePostsCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    // 2.如果没有找到就自己创建对象
    if (cell == nil) {
        cell = [[ChoicePostsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 设置cell的背景色
        self.backgroundColor = [UIColor clearColor];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        // 设置精选帖子视图的frame
        [self setupChoicePostsView];
    }
    return self;
}

/*
 *  设置精选帖子视图的frame
 */
- (void)setupChoicePostsView {
    /** 父视图 */
    ChoicePostsView *choicePostView = [[ChoicePostsView alloc] init];
    [self.contentView addSubview:choicePostView];
    self.choicePostView = choicePostView;
}

/*
 *  override setter
 */
- (void)setChoicePostCellFrame:(ChoicePostCellFrame *)choicePostCellFrame {
    _choicePostCellFrame = choicePostCellFrame;
    // 设置精选帖子数据
    [self setupChoicePostData];
}

/*
 *  设置精选帖子数据
 */
- (void)setupChoicePostData {
    self.choicePostView.choicePostCellFrame = self.choicePostCellFrame;
    self.choicePostView.frame = self.choicePostCellFrame.choicePostViewFrame;
}

/*
 *  在系统初始化cell的frame之前拦截设置cell的frame
 */
- (void)setFrame:(CGRect)frame {
    frame.origin.x = kChoicePostTableViewMargin;
    frame.origin.y += kChoicePostTableViewMargin;
    frame.size.width -= kChoicePostTableViewMargin;
    frame.size.height -= kChoicePostTableViewMargin;
    [super setFrame:frame];
}

@end
