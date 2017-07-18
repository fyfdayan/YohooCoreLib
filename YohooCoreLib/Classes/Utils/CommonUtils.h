//
//  CommonUtils.h
//  CommonUtils
//
//  Created by Wangqy on 15/9/28.
//  Copyright (c) 2015年 Wangqy. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KEY @"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
#define KEYN @"0123456789"
#define KEYN2 @"0123456789."
#define KEY_ID @"0123456789xX"

@interface CommonUtils : NSObject


+ (BOOL)isEmpty:(NSString *)value;

+ (BOOL)isNotEmpty:(NSString *)value;

+ (NSString *)valueOfInt:(int)value;

// 去除字符串左右两边空格
+ (NSString *)deleteBlankFromSring:(NSString *)string;

// 去除首位空格和换行
+ (NSString *)deleteBlankFromStringWithReplaceLineBreak:(NSString *)string;

// 判断输入是否是数字
+ (BOOL)isPureInt:(NSString*)string;

// 粘贴数字并根据长度截取
+ (NSString *)checkInputNumber:(NSString *)inputString byLength:(int)length;

// 替换url里的空格
+ (NSString *)replaceBlankWithUrl:(NSString *)string;

// NSString 字符串去掉空格换行和括号
+ (NSString *)handleSpaceAndEnterElementWithString:(NSString *)sourceStr;

// 移除所有非数字字符 NSString 保留空格
+ (NSString *)deleteAllNonNumericCharactersAndSaveBlank:(NSString *)string;

// 限制字符串长度
+ (BOOL)shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
                      limitWithLength:(NSUInteger)length
                      limitWithString:(NSString *)limitStr;

// 手机号码验证
+ (BOOL)checkPhoneIsCorrect:(NSString *)phone;

// 特殊字符验证
+ (BOOL)isIncludeSpecialCharact:(NSString *)str;

// 邮箱验证
+ (BOOL)checkUserNameIsEmail:(NSString *)email;

// 检测是否为空
+ (BOOL)checkNULLOrEmpty:(NSString*)str;

// 过滤所有表情
+ (BOOL)stringContainsEmoji:(NSString *)string;

// 正则匹配用户身份证号15或18位
+ (BOOL)checkUserIdCard:(NSString *)idCard;

+ (void)dialPhone:(NSString *)phone view:(UIView *)view;

@end
