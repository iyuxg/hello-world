//
//  BarButtonItem.h
//  车行天下
//
//  Created by 剑试蔷薇 on 15/11/9.
//  Copyright (c) 2015年 余晓光. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BarButtonItem : UIBarButtonItem

+ (UIBarButtonItem *)barButtonWithImage:(NSString *)imageName title:(NSString *)title target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)barButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;

@end
