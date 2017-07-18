//
//  YohooPreference.h
//  together
//
//  Created by 傅雁锋 on 15/12/2.
//  Copyright © 2015年 叭啦叭啦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YohooPreference : NSObject

/**
 *	从Preference中移除对象
 *
 *	@param	key key
 */
- (void)removeObjectForKey:(NSString *)key;


#pragma mark - Set values

/**
 *	保存至Preference中
 *
 *	@param	value value
 *	@param	key key
 */
- (void)setValue:(id)value forKey:(NSString *)key;

/**
 *	保存Boolean值至Preference中
 *
 *	@param	value value
 *	@param	key key
 */
- (void)setBool:(BOOL)value forKey:(NSString *)key;

/**
 *	保存Double值至Preference中
 *
 *	@param	value value
 *	@param	key key
 */
- (void)setDouble:(double)value forKey:(NSString *)key;

/**
 *	保存Float值至Preference中
 *
 *	@param	value value
 *	@param	key key
 */
- (void)setFloat:(float)value forKey:(NSString *)key;

/**
 *	保存Integer值至Preference中
 *
 *	@param	value value
 *	@param	key key
 */
- (void)setInteger:(NSInteger)value forKey:(NSString *)key;

/**
 *	保存Object值至Preference中
 *
 *	@param	value value
 *	@param	key key
 */
- (void)setObject:(id)value forKey:(NSString *)key;

/**
 *	保存NSURL对象至Preference中
 *
 *	@param	url url
 *	@param	key key
 */
- (void)setURL:(NSURL *)url forKey:(NSString *)key;


#pragma mark - Get values


/**
 *	从Preference中获取数组对象
 *
 *	@param	key key
 *
 *	@return array
 */
- (NSArray *)arrayForKey:(NSString *)key;

/**
 *	从Preference中获取Boolean值
 *
 *	@param	key key
 *
 *	@return bool
 */
- (BOOL)boolForKey:(NSString *)key;

/**
 *	从Preference中获取NSData对象
 *
 *	@param	key key
 *
 *	@return nsdata
 */
- (NSData *)dataForKey:(NSString *)key;

/**
 *	从Preference中获取NSDictionary对象
 *
 *	@param	key key
 *
 *	@return nsdictionary
 */
- (NSDictionary *)dictionaryForKey:(NSString *)key;

/**
 *	从Preference中获取double值
 *
 *	@param	key key
 *
 *	@return double
 */
- (double)doubleForKey:(NSString *)key;

/**
 *	从Preference中获取float值
 *
 *	@param	key key
 *
 *	@return float
 */
- (float)floatForKey:(NSString *)key;

/**
 *	从Preference中获取int值
 *
 *	@param	key key
 *
 *	@return nsinteger
 */
- (NSInteger)integerForKey:(NSString *)key;

/**
 *	从Preference中获取Object
 *
 *	@param	key key
 *
 *	@return id
 */
- (id)objectForKey:(NSString *)key;

/**
 *	从Preference中获取字符串数组对象
 *
 *	@param	key key
 *
 *	@return array
 */
- (NSArray *)stringArrayForKey:(NSString *)key;

/**
 *	从Preference中获取String
 *
 *	@param	key key
 *
 *	@return nsstring
 */
- (NSString *)stringForKey:(NSString *)key;

/**
 *	从Preference中获取NSURL对象
 *
 *	@param	key key
 *
 *	@return url
 */
- (NSURL *)URLForKey:(NSString *)key;

@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *password;

+ (id)preference;

@end
