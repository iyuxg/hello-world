//
//  ChoicePostsCell.h
//  车行天下
//
//  Created by 剑试蔷薇 on 15/11/10.
//  Copyright (c) 2015年 余晓光. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChoicePostCellFrame;
@interface ChoicePostsCell : UITableViewCell

/* choicePostCellFrame的frame */
@property (nonatomic, strong) ChoicePostCellFrame *choicePostCellFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
