//
//  LogUtils.h
//  
//
//  Created by Jackson Fu on 5/12/11.
//  
//

#import <Foundation/Foundation.h>

@interface LogUtils : NSObject

+ (BOOL)isLogEnabled;

+ (void)setLogEnabled:(BOOL)enabled;

+ (void)log:(NSString *)tag message:(NSString *)msg;

@end