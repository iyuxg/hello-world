//
//  HomeViewNews.h
//  车行天下
//
//  Created by 剑试蔷薇 on 15/11/9.
//  Copyright (c) 2015年 余晓光. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeViewNews : NSObject

/* 新闻图片链接 */
@property (nonatomic, copy) NSString *newsImage;

/* 新闻链接*/
@property (nonatomic, copy) NSString *newsLink;

/* 新闻类别 */
@property (nonatomic, copy) NSString *newsCategory;

/* 新闻标题 */
@property (nonatomic, copy) NSString *newsTitle;

/* 评论数 */
@property (nonatomic, assign) NSInteger commentCount;

/* 新闻标示 */
@property (nonatomic, copy) NSString *newsId;

/* 广告位 */
@property (nonatomic, assign) NSInteger adIndex;



@end
