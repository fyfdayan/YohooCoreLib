//
//  YohooPreference.m
//  together
//
//  Created by 傅雁锋 on 15/12/2.
//  Copyright © 2015年 叭啦叭啦. All rights reserved.
//

#import "YohooPreference.h"

#define USERNAME_PREFERENCE_KEY @"username"
#define PASSWORD_PREFERENCE_KEY @"password"

@interface YohooPreference() {
    
    NSUserDefaults *defaults;
}

@end

@implementation YohooPreference

- (instancetype)init {
    self = [super init];
    if (self) {
        defaults = [NSUserDefaults standardUserDefaults];
    }
    
    return self;
}

/**
 *	从Preference中移除对象
 *
 *	@param	key
 */
- (void)removeObjectForKey:(NSString *)key {
    [defaults removeObjectForKey:key];
}

#pragma mark - Set values

/**
 *	保存至Preference中
 *
 *	@param	value
 *	@param	key
 */
- (void)setValue:(id)value forKey:(NSString *)key {
    [defaults setValue:value forKey:key];
}

/**
 *	保存Boolean值至Preference中
 *
 *	@param	value
 *	@param	key
 */
- (void)setBool:(BOOL)value forKey:(NSString *)key {
    [defaults setBool:value forKey:key];
}

/**
 *	保存Double值至Preference中
 *
 *	@param	value
 *	@param	key
 */
- (void)setDouble:(double)value forKey:(NSString *)key {
    [defaults setDouble:value forKey:key];
}

/**
 *	保存Float值至Preference中
 *
 *	@param	value
 *	@param	key
 */
- (void)setFloat:(float)value forKey:(NSString *)key {
    [defaults setFloat:value forKey:key];
}

/**
 *	保存Integer值至Preference中
 *
 *	@param	value
 *	@param	key
 */
- (void)setInteger:(NSInteger)value forKey:(NSString *)key {
    [defaults setInteger:value forKey:key];
}

/**
 *	保存Object值至Preference中
 *
 *	@param	value
 *	@param	key
 */
- (void)setObject:(id)value forKey:(NSString *)key {
    [defaults setObject:value forKey:key];
}

/**
 *	保存NSURL对象至Preference中
 *
 *	@param	url
 *	@param	key
 */
- (void)setURL:(NSURL *)url forKey:(NSString *)key {
    [defaults setURL:url forKey:key];
}


#pragma mark - Get values


/**
 *	从Preference中获取数组对象
 *
 *	@param	key
 *
 *	@return
 */
- (NSArray *)arrayForKey:(NSString *)key {
    return [defaults arrayForKey:key];
}

/**
 *	从Preference中获取Boolean值
 *
 *	@param	key
 *
 *	@return
 */
- (BOOL)boolForKey:(NSString *)key {
    return [defaults boolForKey:key];
}

/**
 *	从Preference中获取NSData对象
 *
 *	@param	key
 *
 *	@return
 */
- (NSData *)dataForKey:(NSString *)key {
    return [defaults dataForKey:key];
}

/**
 *	从Preference中获取NSDictionary对象
 *
 *	@param	key
 *
 *	@return
 */
- (NSDictionary *)dictionaryForKey:(NSString *)key {
    return [defaults dictionaryForKey:key];
}

/**
 *	从Preference中获取double值
 *
 *	@param	key
 *
 *	@return
 */
- (double)doubleForKey:(NSString *)key {
    return [defaults doubleForKey:key];
}

/**
 *	从Preference中获取float值
 *
 *	@param	key
 *
 *	@return
 */
- (float)floatForKey:(NSString *)key {
    return [defaults floatForKey:key];
}

/**
 *	从Preference中获取int值
 *
 *	@param	key
 *
 *	@return
 */
- (NSInteger)integerForKey:(NSString *)key {
    return [defaults integerForKey:key];
}

/**
 *	从Preference中获取Object
 *
 *	@param	key
 *
 *	@return
 */
- (id)objectForKey:(NSString *)key {
    return [defaults objectForKey:key];
}

/**
 *	从Preference中获取字符串数组对象
 *
 *	@param	key
 *
 *	@return
 */
- (NSArray *)stringArrayForKey:(NSString *)key {
    return [defaults stringArrayForKey:key];
}

/**
 *	从Preference中获取String
 *
 *	@param	key
 *
 *	@return
 */
- (NSString *)stringForKey:(NSString *)key {
    return [defaults stringForKey:key];
}

/**
 *	从Preference中获取NSURL对象
 *
 *	@param	key
 *
 *	@return
 */
- (NSURL *)URLForKey:(NSString *)key {
    return [defaults URLForKey:key];
}

- (void)setUsername:(NSString *)username {
    [self setValue:username forKey:USERNAME_PREFERENCE_KEY];
}

- (void)setPassword:(NSString *)password {
    [self setValue:password forKey:PASSWORD_PREFERENCE_KEY];
}

- (NSString *)username {
    return [self stringForKey:USERNAME_PREFERENCE_KEY];
}

- (NSString *)password {
    return [self stringForKey:PASSWORD_PREFERENCE_KEY];
}

+ (id)preference {
    YohooPreference *temp = [[YohooPreference alloc] init];
    return temp;
}

@end
