//
//  LatestFocusNews.h
//  车行天下
//
//  Created by 剑试蔷薇 on 15/11/9.
//  Copyright (c) 2015年 余晓光. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LatestFocusNews : NSObject

/** 图片链接 */
@property (nonatomic, copy) NSString *imgURL;

/** 新闻标题 */
@property (nonatomic, copy) NSString *title;

/** 详细新闻链接 */
@property (nonatomic, copy) NSString *newsLink;

@end
