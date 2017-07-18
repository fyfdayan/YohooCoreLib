//
//  RpcService.m
//  BaLaBaLa
//
//  Created by Jackson Fu on 15/8/6.
//  Copyright (c) 2015年 叭啦叭啦. All rights reserved.
//

#import "RpcService.h"
#import "EntityJsonResponseHandler.h"
#import "RemoteServerException.h"
#import "StringUtils.h"

@implementation RpcService

@synthesize remoteServiceCall;

- (instancetype)init {
    
    self = [super init];
    if (self) {
        remoteServiceCall = [[RemoteServiceCall alloc] init];
        [remoteServiceCall addHeader:@"accept" headerValue:@"application/json"];
        [remoteServiceCall addHeader:@"content-type" headerValue:@"application/json"];
    }
    
    return self;
}

- (NSString *)buildRpcUrl:(NSString *)uri {
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",
                     [self getRpcSchema],
                     uri];
    
    return url;
}

- (NSString *)getRpcSchema {
    return @"";
}

- (id)getDetail:(NSString *)url requestParams:(NSDictionary *)params convertToClass:(Class)clazz {
    
    EntityJsonResponseHandler *handler = [self get:url requestParams:params convertToClass:clazz];
    return handler.parsedEntity;
}

- (NSArray *)query:(NSString *)url requestParams:(NSDictionary *)params convertToClass:(Class)clazz {
    
    EntityJsonResponseHandler *handler = [self get:url requestParams:params convertToClass:clazz];
    return handler.records;
}

- (DataSet *)query:(NSString *)url requestParams:(NSDictionary *)params paging:(Paging *)paging convertToClass:(Class)clazz {
    
    NSMutableDictionary *requestParam = nil;
    if (params != nil) {
        requestParam = [[NSMutableDictionary alloc] initWithDictionary:params];
    } else {
        requestParam = [[NSMutableDictionary alloc] init];
    }
    
    if (paging != nil) {
        [requestParam setValue:[StringUtils valueOfInt:paging.page] forKey:@"page"];
    }
    
    EntityJsonResponseHandler *handler = [self get:url requestParams:requestParam convertToClass:clazz];
    DataSet *ds = [[DataSet alloc] init];
    ds.records = handler.records;
    ds.paging = handler.paging;
    
    return ds;
}

- (void)sendGetRequest:(NSString *)url requestParams:(NSDictionary *)params jsonResponseHandler:(JsonResponseHandler *)handler {
    
    if (!self.isOnlineMode) {
        @throw [[RemoteServerException alloc] initWithName:NETWORK_EXCEPTION_NAME reason:@"network exception" userInfo:nil];
        return;
    }
    
    NSString *response = [remoteServiceCall get:[self buildRpcUrl:url] requestParams:[self interceptRequestParam:params]];
    [self handleResponse:response jsonResponseHandler:handler];
}

- (id)sendPostRequest:(NSString *)url requestParams:(NSDictionary *)params convertToClass:(Class)clazz {
    if (!self.isOnlineMode) {
        @throw [[RemoteServerException alloc] initWithName:NETWORK_EXCEPTION_NAME reason:@"network exception" userInfo:nil];
        return nil;
    }
    
    NSString *response = [remoteServiceCall post:[self buildRpcUrl:url] requestParams:[self interceptRequestParam:params]];
    
    EntityJsonResponseHandler *handler = [[EntityJsonResponseHandler alloc] initWithEntityClass:clazz];
    
    [self handleResponse:response jsonResponseHandler:handler];
    
    return handler.parsedEntity;
}

- (id)sendPostRequest:(NSString *)url jsonObject:(NSString *)jsonObject convertToClass:(Class)clazz {
    if (!self.isOnlineMode) {
        @throw [[RemoteServerException alloc] initWithName:NETWORK_EXCEPTION_NAME reason:@"network exception" userInfo:nil];
        return nil;
    }
    
//    NSString *response = [remoteServiceCall post:[self buildRpcUrl:url] requestParams:[self interceptRequestParam:params]];
    NSString *realUrl = [StringUtils buildHttpQueryString:[self buildRpcUrl:url] requestParam:[self interceptRequestParam:nil]];
    NSString *response = [remoteServiceCall post:realUrl jsonObject:jsonObject];
    EntityJsonResponseHandler *handler = [[EntityJsonResponseHandler alloc] initWithEntityClass:clazz];
    
    [self handleResponse:response jsonResponseHandler:handler];
    
    return handler.parsedEntity;
}

- (void)sendPostRequest:(NSString *)url requestParams:(NSDictionary *)params jsonResponseHandler:(JsonResponseHandler *)handler {
    
    if (!self.isOnlineMode) {
        @throw [[RemoteServerException alloc] initWithName:NETWORK_EXCEPTION_NAME reason:@"network exception" userInfo:nil];
        return;
    }
    
    NSString *response = [remoteServiceCall post:[self buildRpcUrl:url] requestParams:[self interceptRequestParam:params]];
    [self handleResponse:response jsonResponseHandler:handler];
}

- (EntityJsonResponseHandler *)get:(NSString *)url requestParams:(NSDictionary *)params convertToClass:(Class)clazz {
    
    EntityJsonResponseHandler *handler = [[EntityJsonResponseHandler alloc] initWithEntityClass:clazz];
    [self sendGetRequest:url requestParams:params jsonResponseHandler:handler];
    
    return handler;
}

- (NSString *)getStringFromServer:(NSString *)url requestParams:(NSDictionary *)params {
    NSString *response = [remoteServiceCall getStringFromServer:url requestParams:params];
    return response;
}

- (void)handleResponse:(NSString *)response jsonResponseHandler:(JsonResponseHandler *)handler {
    
    if ([StringUtils isEmpty:response]) {
        @throw [[RemoteServerException alloc] initWithReason:@"Remote server returns nothing!!!"];
    }
    
    if (handler != nil) {
        [handler parse:response];
    }
}

- (NSDictionary *)interceptRequestParam:(NSDictionary *)param {
    return param;
}

@end
