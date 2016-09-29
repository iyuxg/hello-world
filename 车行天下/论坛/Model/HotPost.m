//
//  HotPost.m
//  车行天下
//
//  Created by 剑试蔷薇 on 15/11/10.
//  Copyright (c) 2015年 余晓光. All rights reserved.
//

#import "HotPost.h"

@implementation HotPost



- (void)setViewCount:(NSString *)viewCount {
    
    double num = [viewCount doubleValue];
    
    double viewCountNum = roundf(num / 1000.0) * 0.1;
    
    _viewCount = [NSString stringWithFormat:@"%.1fk", viewCountNum];
}

@end
