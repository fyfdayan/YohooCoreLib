//
//  StringUtils.m
//  
//
//  Created by Jackson Fu on 5/12/11.
//  
//

#import "StringUtils.h"

@implementation StringUtils

+ (BOOL)isEmpty:(NSString *)str {
    return (str == nil || str.length == 0);
}

+ (BOOL)isNotEmpty:(NSString *)str {
    return ![StringUtils isEmpty:str];
}

+ (NSString *)valueOfInt:(int)value {
    return [NSString stringWithFormat:@"%d", value];
}

+ (NSString *)valueOfLong:(long)value {
    return [NSString stringWithFormat:@"%ld", value];
}

+ (NSString *)valueOfFloat:(float)value {
    return [NSString stringWithFormat:@"%f", value];
}

+ (NSString *)buildHttpQueryString:(NSString *)url requestParam:(NSDictionary *)param {
    
    if (param == nil || param.count == 0) {
        return url;
    }
    
    NSString *queryStr = [StringUtils buildQueryString:param urlEncoding:YES];
    
    if ([url rangeOfString:@"?"].length > 0) {
        url = [url stringByAppendingString:@"&"];
    }else {
        url = [url stringByAppendingString:@"?"];
    }
    
    url = [url stringByAppendingString:queryStr];

    return url;
}

+ (NSString *)buildQueryString:(NSDictionary *)param urlEncoding:(BOOL)encode {
    NSString *queryStr = [[NSString alloc] init];
    for (NSString *key in param) {
        NSString *value = [param valueForKey:key];
        
        if ([StringUtils isEmpty:value]) {
            continue;
        }
        
        if (queryStr.length > 0) {
            queryStr = [queryStr stringByAppendingString:@"&"];
        }
        
        queryStr = [queryStr stringByAppendingString:key];
        queryStr = [queryStr stringByAppendingString:@"="];
        
        if (encode) {
            value = [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        
        queryStr = [queryStr stringByAppendingString:value];
    }
    
    return queryStr;
}

+ (NSString *)formatBytes:(long long)bytes {
    NSString *string;
    
    if (bytes < 1024) {
        string = [[NSString alloc] initWithFormat:@"%lldK", bytes];
    } else if (bytes/1024 < 1024){
        string = [[NSString alloc] initWithFormat:@"%lldK", bytes/1024];
    } else if (bytes/1024/1024 < 1024){
        string = [[NSString alloc] initWithFormat:@"%.2fM", (float)bytes/1024/1024];
    } else {
        string = [[NSString alloc] initWithFormat:@"%.2fG", (float)bytes/1024/1024/1024];
    }
    
    return string;
}

+ (NSString *)refineApnToken:(NSString *)token {
    token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return token;
}

+ (NSString *)encodeURIComponent:(NSString *)str {
    return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString *)decodeURIComponent:(NSString *)str {
    return [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (void)copyStringToPasteBoard:(NSString *)value {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = value;
}

+ (NSString *)transform:(NSString *)chinese {
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    NSLog(@"%@", pinyin);
    return [pinyin lowercaseString];
}

@end
