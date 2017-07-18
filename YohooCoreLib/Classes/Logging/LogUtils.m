//
//  LogUtils.m
//  
//
//  Created by Jackson Fu on 5/12/11.
//  
//

#import "LogUtils.h"
#import "Logging.h"

@interface LogUtils () {
    
@private
    BOOL logEnabled;
}

@end

@implementation LogUtils

//- (id)init {
//    self = [super init];
//
//    if (self) {
//        logEnabled = YES;
//    }
//
//    return self;
//}

- (void)setLogEnabled:(BOOL)enabled {
    logEnabled = enabled;
}

- (BOOL)isLogEndabled {
    return logEnabled;
}

+(LogUtils *) instance {
    static id _instance = nil;
    
    @synchronized(self) {
        if(_instance == nil) {
            _instance = [[LogUtils alloc] init];
        }
    }
    
    return _instance;
}

+ (void)setLogEnabled:(BOOL)enabled {
    [[LogUtils instance] setLogEnabled:enabled];
}

+ (BOOL)isLogEnabled {
    return [[LogUtils instance] isLogEndabled];
}

+ (void)log:(NSString *)tag message:(NSString *)msg {
    if ([[LogUtils instance] isLogEndabled]) {
        NSLog(@"TAG: %@\t Message: %@", tag, msg);
    }
}

@end
