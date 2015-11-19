//
//  JLFriend.h
//  02-QQ好友列表
//
//  Created by XinYou on 15-3-6.
//  Copyright (c) 2015年 vxinyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLFriend : NSObject
/**
 *  好友的名称
 */
@property (nonatomic,copy) NSString *name;
/**
 *  好友的头像
 */
@property (nonatomic,copy) NSString *icon;
/**
 *  好友的详细信息
 */
@property (nonatomic,copy) NSString *intro;
/**
 *  是否是vip
 */
@property (nonatomic,assign,getter = isVip) BOOL vip;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)friendWithDict:(NSDictionary *)dict;

@end
