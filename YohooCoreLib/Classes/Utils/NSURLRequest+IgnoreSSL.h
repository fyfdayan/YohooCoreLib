//
//  NSURLRequest+IgnoreSSL.h
//  CompanyPlus
//
//  Created by 陈国梁 on 16/6/6.
//  Copyright © 2016年 CompanyPlus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (IgnoreSSL)

+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;

@end
