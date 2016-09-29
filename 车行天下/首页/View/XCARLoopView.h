//
//  LatestNewsLoopView.h
//  车行天下
//
//  Created by 剑试蔷薇 on 15/11/9.
//  Copyright (c) 2015年 余晓光. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XCARLoopView;

@protocol XCARLoopViewDelegate <NSObject>
@optional
- (void)loopViewDidSelectedImage:(XCARLoopView *)loopView index:(int)index;
@end

@interface XCARLoopView : UIView

@property (nonatomic, weak) id<XCARLoopViewDelegate> delegate;
@property (nonatomic, assign) BOOL autoPlay;
@property (nonatomic, assign) NSTimeInterval timeInterval;
@property (nonatomic, strong) NSArray *images;

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images autoPlay:(BOOL)isAuto delay:(NSTimeInterval)timeInterval;

- (void)setLoopViewImages:(NSArray *)images autoPlay:(BOOL)isAuto delay:(NSTimeInterval)timeInterval;

@end