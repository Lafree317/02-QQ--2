//
//  JLViewController.m
//  02-QQ好友列表
//
//  Created by XinYou on 15-3-6.
//  Copyright (c) 2015年 vxinyou. All rights reserved.
//

#import "JLViewController.h"
#import "JLFriend.h"
#import "JLFriendGroup.h"
#import "JLHeaderView.h"
#import "JLFriendCell.h"

@interface JLViewController () <JLHeaderViewDelegate>

@property (nonatomic,strong)NSArray *groups;

@end

@implementation JLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置tableView的行高
    self.tableView.rowHeight = 50;
    
    // 设置tableView每一组headerView的高度
    self.tableView.sectionHeaderHeight = 44;
    
}

/**
 *  隐藏状态栏
 */
- (BOOL)prefersStatusBarHidden{

    return YES;
}

- (NSArray *)groups{

    if (_groups == nil) {
        // 获取plist文件的路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"friends.plist" ofType:nil];
        
        // 加载plist文件中的内容到数组
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArray) {
            JLFriendGroup *group = [JLFriendGroup groupWithDict:dict];
            
            [tempArray addObject:group];
        }
        
        _groups = tempArray;
    }

    return _groups;
}

#pragma mark -JLHeaderViewDelegate的方法
- (void)headerViewDidClickNameView:(JLHeaderView *)headerView{
    
    // 重新加载数据，刷新表格
    [self.tableView reloadData];
}

#pragma mark -数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    JLFriendGroup *group = self.groups[section];
    
//    return group.friends.count;
    // 控制每组的展开和闭合
    return (group.isOpened == NO ? 0 :group.friends.count);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

//    static NSString *ID = @"qq";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    
//    if (cell == nil) {
//        
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//        
//    }
//    
//    JLFriendGroup *group = self.groups[indexPath.section];
//    JLFriend *friend = group.friends[indexPath.row];
//    
//    cell.imageView.image = [UIImage imageNamed:friend.icon];
//    cell.textLabel.text = friend.name;
//    // vip红色昵称
//    cell.textLabel.textColor = (friend.isVip ? [UIColor redColor] : [UIColor blackColor]);
//    cell.detailTextLabel.text = friend.intro;
    
    // 将以上创建cell的代码封装起来，变成如下代码：
    
    JLFriendGroup *group = self.groups[indexPath.section];
    JLFriend *friend = group.friends[indexPath.row];
    
    // 创建cell
    JLFriendCell *cell = [JLFriendCell cellWithTableView:tableView];
    
    // 给cell设置数据
    cell.friendData = friend;
    
    return cell;
}

// 使用系统自带的headerView，不能满足条件
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//
//    JLFriendGroup *group = self.groups[section];
//    return group.name;
//}

#pragma mark -代理方法
/**
 *  使用自定义的headerView
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    // 创建headerView
    JLHeaderView *headerView= [JLHeaderView headViewWithTableView:tableView];
    
    // 给headerView设置数据
    headerView.group = self.groups[section];
    
    headerView.delegate = self;
    
    return headerView;
}

@end
