//
//  ChoicePostCellFrame.h
//  车行天下
//
//  Created by 剑试蔷薇 on 15/11/10.
//  Copyright (c) 2015年 余晓光. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Public.h"

/* ChoicePostCell的间距 */
#define kChoicePostCellMargin 6
#define kChoicePostTableViewMargin 1

/* 副标题的颜色 */
#define kSubtitleColor Color(136, 139, 146)

/* 帖子标题字体大小 */
#define kChoicePostTitleFont [UIFont systemFontOfSize:16]

/* 帖子论坛字体大小 */
#define kChoicePostForumFont [UIFont systemFontOfSize:14]

/* 浏览人数字体大小 */
#define kChoicePostViewCountFont kChoicePostForumFont

@class ChoicePost;
@interface ChoicePostCellFrame : NSObject

/* 精选帖子 */
@property (nonatomic, strong) ChoicePost *choicePost;

/* 父视图 */
@property (nonatomic, assign, readonly) CGRect choicePostViewFrame;

/* 帖子图片 */
@property (nonatomic, assign, readonly) CGRect postImageViewFrame;

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
@property (nonatomic, assign, readonly) CGFloat cellHeight;

@end
