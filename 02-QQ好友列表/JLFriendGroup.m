//
//  JLFriendGroup.m
//  02-QQ好友列表
//
//  Created by XinYou on 15-3-6.
//  Copyright (c) 2015年 vxinyou. All rights reserved.
//

#import "JLFriendGroup.h"
#import "JLFriend.h"

@implementation JLFriendGroup

- (instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        // KVC 
        [self setValuesForKeysWithDictionary:dict];
        // 经过KVC处理后，friends数组中装得都是NSDictionary对象
        // 而我们需要friends中装的都是JLFriend对象
        
        NSArray *dictArray = self.friends;
        NSMutableArray *tempArray = [NSMutableArray array];
        
        // 1,取出NSDictionary对象
        for (NSDictionary *dict in dictArray) {
            // 2,NSDictionary转模型对象
            JLFriend *friend = [JLFriend friendWithDict:dict];
            [tempArray addObject:friend];
        }
        
        // 3,对friends重新赋值，这样friends里面装的都是JLFriend对象
        self.friends = tempArray;
    }
    
    return self;
}

+ (instancetype)groupWithDict:(NSDictionary *)dict{

    return [[self alloc] initWithDict:dict];
}

@end
