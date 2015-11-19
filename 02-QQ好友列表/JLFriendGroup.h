//
//  JLFriendGroup.h
//  02-QQ好友列表
//
//  Created by XinYou on 15-3-6.
//  Copyright (c) 2015年 vxinyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLFriendGroup : NSObject
/**
 *  组名
 */
@property (nonatomic,copy) NSString *name;
/**
 *  数组中的元素都是JLFriend模型
 */
@property (nonatomic,strong)NSArray *friends;
/**
 *  某一组的当前在线人数
 */
@property (nonatomic,assign) int online;
/**
 *  标记这组是否需要打开。YES表示打开，NO表示不打开
 */
@property (nonatomic,assign,getter = isOpened) BOOL opened;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)groupWithDict:(NSDictionary *)dict;

@end
