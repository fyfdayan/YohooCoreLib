//
//  YohooTask.m
//    叭啦叭啦
//
//  Created by Jackson Fu on 15/7/31.
//  Copyright (c) 2015年 Sinedu. All rights reserved.
//

#import "YohooTask.h"


@implementation YohooTaskResult

- (id)init:(int)taskFlag withData:(id)data {
    
    self = [super init];
    if (self) {
        self.taskFlag = taskFlag;
        self.data = data;
    }
    
    return self;
}

- (id)init:(int)taskFlag withException:(id)exception {
    
    self = [super init];
    if (self) {
        self.taskFlag = taskFlag;
        self.exception = exception;
    }
    
    return self;
}


@end

@implementation YohooTask

- (id)init:(int)taskFlag withParam:(id)param {
    
    self = [super init];
    if (self) {
        self.taskFlag = taskFlag;
        self.taskParam = param;
    }
    
    return self;
}

- (void)main {
    
    @autoreleasepool {
        
        if (self.isCancelled || self.delegate == nil || ![self.delegate respondsToSelector:@selector(onAsyncTaskCallReal:withParam:)]) {
            return;
        }
        
        id ret = nil;
        
        @try {
            ret = [self.delegate onAsyncTaskCallReal:self.taskFlag withParam:self.taskParam];
            
            if (self.isCancelled) {
                return;
            }
            
            if ([self.delegate respondsToSelector:@selector(onAsyncTaskSuccessReal:)]) {
                YohooTaskResult *result = [[YohooTaskResult alloc] init:self.taskFlag withData:ret];
                [(NSObject *)self.delegate performSelectorOnMainThread:@selector(onAsyncTaskSuccessReal:) withObject:result waitUntilDone:NO];
            }
            
            
        } @catch (NSException *exception) {
            
            if (self.isCancelled) {
                return;
            }
            
            if ([self.delegate respondsToSelector:@selector(onAsyncTaskExceptionReal:)]) {
                YohooTaskResult *result = [[YohooTaskResult alloc] init:self.taskFlag withException:exception];
                [(NSObject *)self.delegate performSelectorOnMainThread:@selector(onAsyncTaskExceptionReal:) withObject:result waitUntilDone:NO];
            }
            
        } @finally {
            
            if ([self.delegate respondsToSelector:@selector(onAsyncTaskFinallyReal:)]) {
                [(NSObject *)self.delegate performSelectorOnMainThread:@selector(onAsyncTaskFinallyReal:) withObject:self waitUntilDone:NO];
            }
        }

    }
}

@end
