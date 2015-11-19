//
//  JLFriendCell.h
//  02-QQ好友列表
//
//  Created by XinYou on 15-3-6.
//  Copyright (c) 2015年 vxinyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JLFriend;

@interface JLFriendCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**
 *  friend是C++的关键字，不能作为属性名存在
 */
@property (nonatomic,strong)JLFriend *friendData;

@end
