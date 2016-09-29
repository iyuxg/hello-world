//
//  HotPost.h
//  车行天下
//
//  Created by 剑试蔷薇 on 15/11/10.
//  Copyright (c) 2015年 余晓光. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotPost : NSObject


/* 有无图片 */
@property (nonatomic, assign) BOOL hasImage;

/* 论坛名 */
@property (nonatomic, copy) NSString *forumName;

/* 浏览人数 */
@property (nonatomic, copy) NSString *viewCount;

/* 帖子标题 */
@property (nonatomic, copy) NSString *postTitle;

/* 帖子链接 */
@property (nonatomic, copy) NSString *postLink;

@end
