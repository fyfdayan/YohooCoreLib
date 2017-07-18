//
//  DigestUtils.h
//  
//
//  Created by Jackson Fu on 5/12/11.
//  
//

#import <Foundation/Foundation.h>

@interface DigestUtils : NSObject

/**
 * 对字符串进行MD5运算
 */
+ (NSString *)md5:(NSString *)text;

@end
