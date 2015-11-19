//
//  JLHeaderView.h
//  02-QQ好友列表
//
//  Created by XinYou on 15-3-6.
//  Copyright (c) 2015年 vxinyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JLFriendGroup,JLHeaderView;

@protocol JLHeaderViewDelegate <NSObject>

@optional
- (void)headerViewDidClickNameView:(JLHeaderView *)headerView;

@end


// 既然是自定义headerView，为什么还需要继承UItableViewHeaderFooterView，而不是继承UIView呢？
@interface JLHeaderView : UITableViewHeaderFooterView

@property (nonatomic,strong)JLFriendGroup *group;

@property (nonatomic,strong)id<JLHeaderViewDelegate> delegate;

+ (instancetype)headViewWithTableView:(UITableView *)tableView;

@end
