//
//  YohooException.m
//  BaLaBaLa
//
//  Created by Jackson Fu on 15/8/6.
//  Copyright (c) 2015年 叭啦叭啦. All rights reserved.
//

#import "YohooException.h"

@implementation YohooException

- (instancetype)init {
    self = [super initWithName:NSStringFromClass([self class]) reason:nil userInfo:nil];
    return self;
}

- (instancetype)initWithReason:(NSString *)reason {
    self = [super initWithName:NSStringFromClass([self class]) reason:reason userInfo:nil];
    return self;
}

- (instancetype)initWithReason:(NSString *)reason userInfo:(NSDictionary *)aUserInfo {
    self = [super initWithName:NSStringFromClass([self class]) reason:reason userInfo:aUserInfo];
    return self;
}

@end
