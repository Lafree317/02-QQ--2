//
//  JLFriendCell.m
//  02-QQ好友列表
//
//  Created by XinYou on 15-3-6.
//  Copyright (c) 2015年 vxinyou. All rights reserved.
//

#import "JLFriendCell.h"
#import "JLFriend.h"

@implementation JLFriendCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{

    static NSString *ID = @"qq";
    
    JLFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[JLFriendCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    return cell;
}

- (void)setFriendData:(JLFriend *)friendData{

    _friendData = friendData;
    
    self.imageView.image = [UIImage imageNamed:_friendData.icon];
    self.textLabel.text = _friendData.name;
    // vip红色昵称
    self.textLabel.textColor = (_friendData.isVip ? [UIColor redColor] : [UIColor blackColor]);
    self.detailTextLabel.text = _friendData.intro;
}

@end
