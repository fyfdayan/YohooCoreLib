//
//  DigestUtils.m
//  
//
//  Created by Jackson Fu on 5/12/11.
//  
//

#import <CommonCrypto/CommonDigest.h>
#import "DigestUtils.h"

@implementation DigestUtils

+ (NSString *)md5:(NSString *)text {
    
    const char *cStr = [text UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
            ];

}

@end
