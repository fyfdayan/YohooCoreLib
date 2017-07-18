//
//  CommonUtils.m
//  CommonUtils
//
//  Created by Wangqy on 15/9/28.
//  Copyright (c) 2015年 Wangqy. All rights reserved.
//

#import "CommonUtils.h"

@implementation CommonUtils

+ (BOOL)isEmpty:(NSString *)value {
    return value == nil || [value isEqualToString:@""];
}

+ (BOOL)isNotEmpty:(NSString *)value {
    return ![self isEmpty:value];
}

+ (NSString *)valueOfInt:(int)value {
    return [NSString stringWithFormat:@"%d", value];
}

// 去除字符串左右两边空格
+ (NSString *)deleteBlankFromSring:(NSString *)string {
    
    NSString *str = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    return str;
}

// 去除首位空格和换行
+ (NSString *)deleteBlankFromStringWithReplaceLineBreak:(NSString *)string {
    
    NSString *content = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return content;
}

// 判断输入是否是数字
+ (BOOL)isPureInt:(NSString*)string {
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

// 粘贴数字并根据长度截取
+ (NSString *)checkInputNumber:(NSString *)inputString byLength:(int)length {
    if ([self isEmpty:inputString]) {
        return @"";
    }
    
    NSMutableString *retValue = [[NSMutableString alloc] init];
    for (NSInteger i=0; i<inputString.length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *currentValue = [inputString substringWithRange:range];
        if ([self isPureInt:currentValue]) {
            [retValue appendString:currentValue];
        }
    }
    
    if (retValue.length > length) {
        return [retValue substringToIndex:length];
    }
    return retValue;
}

// 替换url里的空格
+ (NSString *)replaceBlankWithUrl:(NSString *)string {
    
    NSString *strUrl = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return strUrl;
}

// NSString 字符串去掉空格换行和括号
+ (NSString *)handleSpaceAndEnterElementWithString:(NSString *)sourceStr {
    
    NSString *realSre = [sourceStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *realSre1 = [realSre stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    NSString *realSre2 = [realSre1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    NSString *realSre3 = [realSre2 stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *realSre4 = [realSre3 stringByReplacingOccurrencesOfString:@"(" withString:@""];
    
    NSString *realSre5 = [realSre4 stringByReplacingOccurrencesOfString:@")" withString:@""];
    
    NSArray *array = [realSre5 componentsSeparatedByString:@","];

    return [array objectAtIndex:0];

}

// 移除所有非数字字符 NSString 保留空格
+ (NSString *)deleteAllNonNumericCharactersAndSaveBlank:(NSString *)string {
    NSCharacterSet *setToRemove = [[ NSCharacterSet characterSetWithCharactersInString:@"0123456789 "]
     invertedSet ];
    
    NSString *newString = [[string componentsSeparatedByCharactersInSet:setToRemove]
     componentsJoinedByString:@""];
    
    return newString;
}

// 限制字符串长度
+ (BOOL)shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
                      limitWithLength:(NSUInteger)length
                      limitWithString:(NSString *)limitStr {
    if (range.location >=length) {
        return NO;
    }
    //限制输入内容
    NSCharacterSet* cs;
    cs = [[NSCharacterSet  characterSetWithCharactersInString:limitStr]  invertedSet];
    NSString* filtered = [[string  componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL canChange = [string isEqualToString:filtered];
    return canChange;
}

// 手机号码验证
+ (BOOL)checkPhoneIsCorrect:(NSString *)phone {
    NSString * regex = @"^0{0,1}(11[0-9]|12[0-9]|13[0-9]|14[0-9]|15[0-9]|16[0-9]|17[0-9]|18[0-9]|19[0-9])[0-9]{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:phone];
    
    if (phone.length == 11 && isMatch) {
        return YES;
    } else {
        return NO;
    }
}

// 特殊字符
+ (BOOL)isIncludeSpecialCharact: (NSString *)str {
    if (![self checkNULLOrEmpty:str]) {
        // 需要过滤的特殊字符：~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€。
        NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"：、￥{ } % .！？?～，,。""“”…　：`!,;；'~#&*<>《》()[]{}【】^@/￡-=_+¤¥|§¨「」『』￠￢￣~@#&*（）——+|《》$_€。..."]];
        if (urgentRange.location == NSNotFound) {
            return NO;
        }
        return YES;
    }
    return NO;
}

// 检测是否为空
+ (BOOL)checkNULLOrEmpty:(NSString*)str {
    if (!str || [str isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

// 过滤所有表情  https://gist.github.com/cihancimen/4146056
+ (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}

// 正则匹配用户身份证号15或18位
+ (BOOL)checkUserIdCard:(NSString *)idCard {
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:idCard];
    return isMatch;
}

// 邮箱验证
+ (BOOL)checkUserNameIsEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    
    return [emailTest evaluateWithObject:email];

}

+ (void)dialPhone:(NSString *)phone view:(UIView *)view {
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phone];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [view addSubview:callWebview];
}

@end
