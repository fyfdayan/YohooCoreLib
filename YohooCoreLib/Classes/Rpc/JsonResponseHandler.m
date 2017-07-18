//
//  JsonResponseHandler.m
//  BaLaBaLa
//
//  Created by Jackson Fu on 15/8/4.
//  Copyright (c) 2015年   叭啦叭啦. All rights reserved.
//

#import "JsonResponseHandler.h"
#import "JsonResponse.h"
#import "RemoteServerException.h"
#import "BusinessException.h"
#import "Entity.h"
#import "StringUtils.h"
#import "LogUtils.h"

#define LOG_TAG @"JsonResponseHandler"

@implementation JsonResponseHandler

@synthesize status, paging;

- (void)parse:(NSString *)jsonStr {
    
    if ([StringUtils isEmpty:jsonStr]) {
        return;
    }
    
    NSMutableDictionary *jsonObject = nil;
    
    @try {
        NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
    } @catch (NSException *exception) {
        [LogUtils log:LOG_TAG message:[NSString stringWithFormat:@"%@", exception.reason]];
        
        if ([LogUtils isLogEnabled]) {
            @throw exception;
        }
    }
    
    //解析远程访问状态
    [self parseStatus:jsonObject];
    
    //解析远程业务异常
    [self parseRemoteBusinessException:jsonObject];
    
    
    //解析单一数据
    id recordValue = [jsonObject objectForKey:JSON_NODE_RECORD];
    if ([self validateNode:recordValue]) {
        [self parseRecord:recordValue];
    }
    
    //解析数据集
    id recordsetValue = [jsonObject objectForKey:JSON_NODE_RECORDSET];
    if ([self validateNode:recordsetValue]) {
        [self parseRecordset:recordsetValue];
    }
    
    //解析分页对象
    NSDictionary *pagingNode = [jsonObject objectForKeyedSubscript:JSON_NODE_PAGING_NAME];
    if ([self validateNode:pagingNode]) {
        [self parsePaging:pagingNode];
    }
    
}

- (void)parseStatus:(NSDictionary *)jsonObject {
    
    NSNumber *statusValue = [jsonObject objectForKey:JSON_NODE_STATUS_NAME];
    if ([self validateNode:statusValue]) {
        status = statusValue.intValue;
    }
    
    if (status != RESPONSE_STATUS_200) {
        NSString *exceptionReason = [jsonObject objectForKey:JSON_NODE_EXCEPTION_NAME];
        if ([StringUtils isEmpty:exceptionReason]) {
            exceptionReason = @"";
        }
        
        RemoteServerException *exception = [[RemoteServerException alloc] initWithReason:exceptionReason];
        @throw exception;
    }
}

- (void)parseRemoteBusinessException:(NSDictionary *)jsonObject {
    
    NSString *exceptionValue = [jsonObject objectForKey:JSON_NODE_EXCEPTION_NAME];
    if (![self validateStringNode:exceptionValue]) {
        return;
    }
    
//    NSString *reason = nil;
    NSString *exceptionReasonValue = [jsonObject objectForKey:JSON_NODE_EXCEPTION_MESSAGE_NAME];
    if ([self validateStringNode:exceptionReasonValue]) {
//        reason = exceptionReasonValue;
    }
    
    BusinessException *exception = [[BusinessException alloc] initWithName:exceptionValue reason:exceptionReasonValue userInfo:nil];
    @throw exception;
}

- (void)parseRecordset:(NSArray *)recordset {
    
}

- (void)parseRecord:(NSDictionary *)record {
    
}

- (void)parsePaging:(NSDictionary *)node {
    paging = [Paging mj_objectWithKeyValues:node];
}

- (BOOL)validateNode:(id)jsonValue {
    return (jsonValue != nil && ![jsonValue isKindOfClass:[NSNull class]]);
}

- (BOOL)validateStringNode:(NSString *)jsonValue {
    return [self validateNode:jsonValue] && [StringUtils isNotEmpty:jsonValue] && ![jsonValue isEqualToString:@"null"];
}

@end
