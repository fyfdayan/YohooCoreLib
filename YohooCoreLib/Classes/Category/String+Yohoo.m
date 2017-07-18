//
//  String+Yohoo.m
//  BaLaBaLa
//
//  Created by Jackson Fu on 15/8/6.
//  Copyright (c) 2015年 叭啦叭啦. All rights reserved.
//

#import "String+Yohoo.h"

@implementation NSString (Yohoo)

+ (NSString *)valueOfInt:(int)value {
    return [NSString stringWithFormat:@"%d", value];
}

+ (NSString *)valueOfLong:(long)value {
    return [NSString stringWithFormat:@"%ld", value];
}

+ (NSString *)valueOfFloat:(float)value {
    return [NSString stringWithFormat:@"%f", value];
}

@end
