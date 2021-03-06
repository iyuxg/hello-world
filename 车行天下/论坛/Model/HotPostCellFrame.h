//
//  HotPostCellFrame.h
//  车行天下
//
//  Created by 剑试蔷薇 on 15/11/10.
//  Copyright (c) 2015年 余晓光. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/* HotPostCell的间距 */
#define kHotPostCellMargin 6
#define kHotPostTableViewMargin 1

/* 副标题的颜色 */
#define kSubtitleColor Color(136, 139, 146)

/* 帖子标题字体大小 */
#define kHotPostTitleFont [UIFont systemFontOfSize:16]

/* 帖子论坛字体大小 */
#define kHotPostForumFont [UIFont systemFontOfSize:14]

/* 浏览人数字体大小 */
#define kHotPostViewCountFont kHotPostForumFont

/* 发布时间字体大小 */
#define kHotPostCreateDateFont kHotPostViewCountFont

@class HotPost;
@interface HotPostCellFrame : NSObject

@property (nonatomic, strong) HotPost *hotPost;

/* 父视图 */
@property (nonatomic, assign, readonly) CGRect hotPostViewFrame;

/* 是否显示图片 */
@property (nonatomic, assign, readonly) CGRect hasImageViewFrame;

/* 帖子标题 */
@property (nonatomic, assign, readonly) CGRect postTitleLabelFrame;

/* 论坛名 */
@property (nonatomic, assign, readonly) CGRect forumNameLabelFrame;

/* 浏览人数view */
@property (nonatomic, assign, readonly) CGRect viewCountViewFrame;

/* 浏览人数label */
@property (nonatomic, assign, readonly) CGRect viewCountLabelFrame;

/* 分割线 */
@property (nonatomic, assign, readonly) CGRect separatorViewFrame;

/* cell的总高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
