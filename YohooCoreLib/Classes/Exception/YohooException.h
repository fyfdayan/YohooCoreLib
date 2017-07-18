//
//  YohooException.h
//  BaLaBaLa
//
//  Created by Jackson Fu on 15/8/6.
//  Copyright (c) 2015年 叭啦叭啦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YohooException : NSException

- (instancetype)initWithReason:(NSString *)reason;

- (instancetype)initWithReason:(NSString *)reason userInfo:(NSDictionary *)aUserInfo;

@end
