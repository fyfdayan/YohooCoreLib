//
//  NSURLRequest+IgnoreSSL.m
//  CompanyPlus
//
//  Created by 陈国梁 on 16/6/6.
//  Copyright © 2016年 CompanyPlus. All rights reserved.
//

#import "NSURLRequest+IgnoreSSL.h"

@implementation NSURLRequest (IgnoreSSL)

+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host
{
    // ignore certificate errors only for this domain
    return YES;
}
    
@end