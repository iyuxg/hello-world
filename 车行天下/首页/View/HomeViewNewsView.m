//
//  HomeViewNewsView.m
//  车行天下
//
//  Created by 剑试蔷薇 on 15/11/9.
//  Copyright (c) 2015年 余晓光. All rights reserved.
//

#import "HomeViewNewsView.h"
#import "HomeViewNewsCellFrame.h"
#import "HomeViewNews.h"
#import "UIImageView+WebCache.h"

#import "Public.h"

@interface HomeViewNewsView ()

/* 新闻类别 */
@property (nonatomic, weak) UILabel *categoryLabel;

/* 新闻评论 */
@property (nonatomic, weak) UILabel *commentLabel;

/* 新闻评论(image) */
@property (nonatomic, weak) UIImageView *commentView;

/* 新闻图片 */
@property (nonatomic, weak) UIImageView *newsImageView;

/* 新闻标题 */
@property (nonatomic, weak) UILabel *titleLabel;


/* 分割线 */
@property (nonatomic, weak) UIView *separatorView;


@end

@implementation HomeViewNewsView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 添加主页新闻的各控件
        [self setupHomeViewNewsView];
        // 设置背景颜色
        [self setBackgroundColor:Color(251, 251, 251)];
    }
    return self;
}

/*
 *  添加主页新闻的各控件
 */
- (void)setupHomeViewNewsView {
    /* 新闻标题 */
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFont:kHomeViewNewsTitleFont];
    titleLabel.numberOfLines = 0;
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    /* 新闻图片 */
    UIImageView *newsImageView = [[UIImageView alloc] init];
    newsImageView.layer.masksToBounds = YES;
    [newsImageView.layer setCornerRadius:5.0];
    newsImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:newsImageView];
    self.newsImageView = newsImageView;
    
    /* 新闻类别 */
    UILabel *categoryLabel = [[UILabel alloc] init];
    [categoryLabel setFont:kHomeViewNewsCategoryFont];
    categoryLabel.textColor = kSubtitleColor;
    [self addSubview:categoryLabel];
    self.categoryLabel = categoryLabel;
    
    /* 新闻评论(image) */
    UIImageView *commentView = [[UIImageView alloc] init];
    [self addSubview:commentView];
    self.commentView = commentView;
    
    /* 新闻评论 */
    UILabel *commentLabel = [[UILabel alloc] init];
    commentLabel.textColor = kSubtitleColor;
    [commentLabel setFont:kHomeViewNewsCommentFont];
//    [commentLabel setBackgroundColor:[UIColor orangeColor]];
    [self addSubview:commentLabel];
    self.commentLabel = commentLabel;
    
    /* 分割线 */
    UIView *separatorView = [[UIView alloc] init];
    [separatorView setBackgroundColor:Color(226, 226, 226)];
    [self addSubview:separatorView];
    self.separatorView = separatorView;
}

/*
 *  根据传入的homeViewNewsCellFrame对各控件进行赋值
 */
- (void)setHomeViewNewsCellFrame:(HomeViewNewsCellFrame *)homeViewNewsCellFrame {
    _homeViewNewsCellFrame = homeViewNewsCellFrame;
    HomeViewNews *news = homeViewNewsCellFrame.homeViewNews;
    
    /* 新闻标题 */
    self.titleLabel.frame = homeViewNewsCellFrame.titleFrame;
    [self.titleLabel setText:news.newsTitle];
    
    /* 新闻图片 */
    self.newsImageView.frame = homeViewNewsCellFrame.newsImageFrame;
    NSURL *newsImageURL = [NSURL URLWithString:news.newsImage];
    [self.newsImageView sd_setImageWithURL:newsImageURL];
    
    /* 新闻类别 */
    if (news.newsCategory) {
        self.categoryLabel.frame = homeViewNewsCellFrame.categotyFrame;
        [self.categoryLabel setText:news.newsCategory];
    }
    
    /* 新闻评论(image) */
    if (news.commentCount) {
        self.commentView.frame = homeViewNewsCellFrame.commentViewFrame;
        [self.commentView setImage:[UIImage imageNamed:@"iconfont-pinglun"]];
    }
    
    /* 新闻评论 */
    if (news.commentCount) {
        self.commentLabel.frame = homeViewNewsCellFrame.commentFrame;
        NSString *comment = [NSString stringWithFormat:@"%ld评", news.commentCount];
        _commentLabel.textAlignment=NSTextAlignmentRight;
        [self.commentLabel setText:comment];
    }
    
    
    
    /* 分割线 */
    self.separatorView.frame = homeViewNewsCellFrame.separatorViewFrame;
}

@end

