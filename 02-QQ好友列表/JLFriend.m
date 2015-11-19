//
//  JLFriend.m
//  02-QQ好友列表
//
//  Created by XinYou on 15-3-6.
//  Copyright (c) 2015年 vxinyou. All rights reserved.
//

#import "JLFriend.h"

@implementation JLFriend

- (instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+ (instancetype)friendWithDict:(NSDictionary *)dict{

    return [[self alloc] initWithDict:dict];
}

@end
