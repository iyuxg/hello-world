//
//  HotPostCellFrame.m
//  车行天下
//
//  Created by 剑试蔷薇 on 15/11/10.
//  Copyright (c) 2015年 余晓光. All rights reserved.
//

#import "HotPostCellFrame.h"
#import "HotPost.h"
#import "Public.h"

@implementation HotPostCellFrame

- (void)setHotPost:(HotPost *)hotPost {
    
    _hotPost = hotPost;
    
    CGFloat cellWidth = ScreenWidth - 2 * kHotPostTableViewMargin;
    
    /* 父视图 */
    CGFloat hotPostViewX = 2 * kHotPostCellMargin;
    CGFloat hotPostViewY = kHotPostCellMargin;
    CGFloat hotPostViewW = cellWidth - 2 * kHotPostCellMargin;
    CGFloat hotPostViewH = 0.0;
    
    /* 帖子标题 */
    CGFloat postTitleLabelX = 0.0;
    CGFloat postTitleLabelY = 0.0;
    CGFloat postTitleLabelW = hotPostViewW - 2 * kHotPostCellMargin;
    NSDictionary *postTitleAttrs = @{NSFontAttributeName : kHotPostTitleFont};
    CGSize postTitleSize = [hotPost.postTitle sizeWithAttributes:postTitleAttrs];
    NSInteger rows = ceil(postTitleSize.width / postTitleLabelW + 0.5);
    CGFloat postTitleLabelH = postTitleSize.height * rows;
    _postTitleLabelFrame = CGRectMake(postTitleLabelX, postTitleLabelY, postTitleLabelW, postTitleLabelH);
    
   
    
    
    /* 是否显示图片 */
    CGFloat hasImageViewX = 6;
    CGFloat hasImageViewY = 42;
    CGFloat hasImageViewW = 22.0;
    CGFloat hasImageViewH = 13.0;
    if (hotPost.hasImage) {
        _hasImageViewFrame = CGRectMake(hasImageViewX, hasImageViewY, hasImageViewW, hasImageViewH);
    }
    
    /* 论坛名 */
    CGFloat forumNameLabelX = 0.0;
    if (hotPost.hasImage) {
        forumNameLabelX = CGRectGetMaxX(_hasImageViewFrame) + 6.0;
    } else {
        forumNameLabelX = 8;
    }
    CGFloat forumNameLabelY = 40;
    CGFloat forumNameLabelW = 73.0;
    NSDictionary *forumNameAttrs = @{NSFontAttributeName : kHotPostCreateDateFont};
    CGSize forumNameSize = [hotPost.forumName sizeWithAttributes:forumNameAttrs];
    _forumNameLabelFrame = CGRectMake(forumNameLabelX, forumNameLabelY, forumNameLabelW, forumNameSize.height);
    
    /* 浏览人数view */
    CGFloat viewCountViewX = (280.0/375)*[UIScreen mainScreen].bounds.size.width;;
    CGFloat viewCountViewH = 18.0;
    CGFloat viewCountViewY = forumNameLabelY;
    CGFloat viewCountViewW = 18.0;
    _viewCountViewFrame = CGRectMake(viewCountViewX, viewCountViewY, viewCountViewW, viewCountViewH);
    
    /* 浏览人数label */
    CGFloat viewCountLabelX = CGRectGetMaxX(_viewCountViewFrame) + hotPostViewX;
    CGFloat viewCountLabelY = 40;
    CGFloat viewCountLabelW = 50.0;
    CGFloat viewCountLabelH = 17.0;
    _viewCountLabelFrame = CGRectMake(viewCountLabelX, viewCountLabelY, viewCountLabelW, viewCountLabelH);
    
    /* 分割线 */
    CGFloat separatorViewFrameX = hotPostViewX - hotPostViewX;
    CGFloat separatorViewFrameY = CGRectGetMaxY(_viewCountLabelFrame) + hotPostViewX;
    CGFloat separatorViewFrameW = hotPostViewW - hotPostViewX;
    CGFloat separatorViewFrameH = 1.0;
    _separatorViewFrame = CGRectMake(separatorViewFrameX, separatorViewFrameY, separatorViewFrameW, separatorViewFrameH);
    
    /* 父视图 */
    hotPostViewH = CGRectGetMaxY(_separatorViewFrame);
    _hotPostViewFrame = CGRectMake(hotPostViewX, hotPostViewY, hotPostViewW, hotPostViewH);
    
    /* cell的总高度 */
    _cellHeight = CGRectGetMaxY(_hotPostViewFrame) + kHotPostCellMargin;
}

@end
