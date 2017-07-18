//
//  StringUtils.h
//  
//
//  Created by Jackson Fu on 5/12/11.
//  
//

#import <Foundation/Foundation.h>

@interface StringUtils : NSObject

+ (BOOL)isEmpty:(NSString *)str;

+ (BOOL)isNotEmpty:(NSString *)str;

+ (NSString *)valueOfInt:(int)value;

+ (NSString *)valueOfLong:(long)value;

+ (NSString *)valueOfFloat:(float)value;

+ (NSString *)buildHttpQueryString:(NSString *)url requestParam:(NSDictionary *)param;

+ (NSString *)buildQueryString:(NSDictionary *)param urlEncoding:(BOOL)encode;

+ (NSString *)formatBytes:(long long)bytes;

+ (NSString *)refineApnToken:(NSString *)token;

+ (NSString *)encodeURIComponent:(NSString *)str;

+ (NSString *)decodeURIComponent:(NSString *)str;

+ (void)copyStringToPasteBoard:(NSString *)value;

+ (NSString *)transform:(NSString *)chinese;

@end
