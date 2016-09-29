//
//  BarButtonItem.m
//  车行天下
//
//  Created by 剑试蔷薇 on 15/11/9.
//  Copyright (c) 2015年 余晓光. All rights reserved.
//

#import "BarButtonItem.h"

#import "Public.h"

#define BarButtonButtonImageRatio 0.9

@interface BarButton : UIButton

@end

@implementation BarButton


// 设置文本在button中的layout
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleX = contentRect.size.height * BarButtonButtonImageRatio;
    CGFloat titleW = contentRect.size.width + 30;
    CGFloat titleH = contentRect.size.height * BarButtonButtonImageRatio;
    CGFloat titleY = 0.0;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}

@end

@interface BarButtonItem ()

@end

@implementation BarButtonItem

+ (UIBarButtonItem *)barButtonWithImage:(NSString *)imageName title:(NSString *)title target:(id)target action:(SEL)action {
    BarButton *barButton = [[BarButton alloc] init];
    [barButton setTitle:title forState:UIControlStateNormal];
    [barButton setTitleColor:Color(81, 165, 192) forState:UIControlStateNormal];
    [barButton setImage:[UIImage imageNamed:imageName]
               forState:UIControlStateNormal];
    barButton.bounds = (CGRect){CGPointZero, barButton.currentImage.size};
    [barButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:barButton];
}

+ (UIBarButtonItem *)barButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *barButton = [[UIButton alloc] init];
    [barButton setTitle:title forState:UIControlStateNormal];
    [barButton setTitleColor:Color(81, 165, 192) forState:UIControlStateNormal];
    [barButton addTarget:target action:action forControlEvents:UIControlEventTouchDown];
    barButton.bounds = CGRectMake(0.0, 0.0, 40.0, 40.0);
    return [[UIBarButtonItem alloc] initWithCustomView:barButton];
}

@end
