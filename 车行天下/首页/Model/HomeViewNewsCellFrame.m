//
//  HomeViewNewsCellFrame.m
//  车行天下
//
//  Created by 剑试蔷薇 on 15/11/9.
//  Copyright (c) 2015年 余晓光. All rights reserved.
//

#import "HomeViewNewsCellFrame.h"
#import "HomeViewNews.h"
#import "Public.h"

@implementation HomeViewNewsCellFrame

- (void)setHomeViewNews:(HomeViewNews *)homeViewNews {
    
    _homeViewNews = homeViewNews;
    
    CGFloat cellWidth = ScreenWidth - 2 * kHomeViewNewsTableViewMargin;
        
    /* 父视图 */
    CGFloat homeViewNewsViewX = 7.0;
    CGFloat homeViewNewsViewY = 0.0;
    CGFloat homeViewNewsViewW = cellWidth - 2 * kHomeViewNewsCellMargin;
    CGFloat homeViewNewsViewH = 0.0;
    
    /* 新闻图片 */
    CGFloat newsImageX = kHomeViewNewsCellMargin;
    CGFloat newsImageY = kHomeViewNewsCellMargin;
    CGSize newsImageSize = CGSizeMake(90.0, 70.0);
    _newsImageFrame = (CGRect){{newsImageX, newsImageY}, newsImageSize};
    
    /* 新闻标题 */
    CGFloat newsTitleX = CGRectGetMaxX(_newsImageFrame) + kHomeViewNewsCellMargin;
    CGFloat newsTitleY = newsImageY;
    CGFloat newsTitleW = homeViewNewsViewW - newsImageSize.width - 4 * kHomeViewNewsCellMargin;
    NSDictionary *newsTitleAttrs = @{NSFontAttributeName : kHomeViewNewsTitleFont};
    CGSize newsTitleSize = [homeViewNews.newsTitle sizeWithAttributes:newsTitleAttrs];
    NSInteger rows = ceil(newsTitleSize.width / newsTitleW + 0.5);
    CGFloat newsTitleH = newsTitleSize.height * rows;
    _titleFrame = CGRectMake(newsTitleX, newsTitleY, newsTitleW, newsTitleH);
    

    /* 新闻评论(图片) */
    CGFloat commentViewX = newsTitleX + 5;
    CGFloat commentViewY = CGRectGetMaxY(_newsImageFrame) - 3 * kHomeViewNewsCellMargin+5;
    _commentViewFrame = CGRectMake(commentViewX , commentViewY, 11, 11);
    
    /* 新闻评论 */
    CGFloat commentX = commentViewX+18;
    CGFloat commentY = CGRectGetMaxY(_newsImageFrame) - 3 * kHomeViewNewsCellMargin;
    NSDictionary *commentAttrs = @{NSFontAttributeName : kHomeViewNewsCommentFont};
    NSString *comment = [NSString stringWithFormat:@"%ld", homeViewNews.commentCount];
    CGSize commentSize = [comment sizeWithAttributes:commentAttrs];
    if (homeViewNews.commentCount) {
        _commentFrame = CGRectMake(commentX, commentY, commentSize.width+20, 21);
    }
    
    /* 新闻类别 */
    CGFloat categotyX = (280.0/375)*[UIScreen mainScreen].bounds.size.width;
    CGFloat categotyY = commentY;
    NSDictionary *categotyAttrs = @{NSFontAttributeName : kHomeViewNewsCategoryFont};
    CGSize categotySize = [homeViewNews.newsCategory sizeWithAttributes:categotyAttrs];
    _categotyFrame = (CGRect){{categotyX, categotyY}, categotySize};
    
    
    /* 分割线 */
    CGFloat separatorViewFrameX = homeViewNewsViewX - kHomeViewNewsCellMargin;
    CGFloat separatorViewFrameY = CGRectGetMaxY(_categotyFrame) + kHomeViewNewsCellMargin;
    CGFloat separatorViewFrameW = homeViewNewsViewW - kHomeViewNewsCellMargin;
    CGFloat separatorViewFrameH = 1.0;
    _separatorViewFrame = CGRectMake(separatorViewFrameX, separatorViewFrameY, separatorViewFrameW, separatorViewFrameH);
    
    /* 父视图的高度 */
    homeViewNewsViewH = CGRectGetMaxY(_separatorViewFrame);
    _homeViewNewsViewFrame = CGRectMake(homeViewNewsViewX, homeViewNewsViewY, homeViewNewsViewW, homeViewNewsViewH);
    
    /* cell的高度 */
    _cellHeight = CGRectGetMaxY(_homeViewNewsViewFrame) + kHomeViewNewsCellMargin;
}

@end
