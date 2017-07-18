
//  RemoteServiceCall.m
//  BaLaBaLa
//
//  Created by Jackson Fu on 15/8/7.
//  Copyright (c) 2015年 叭啦叭啦. All rights reserved.
//

#import "RemoteServiceCall.h"
#import "UNIRest.h"
#import "RemoteServerException.h"
#import "StringUtils.h"
#import "LogUtils.h"

@implementation RemoteServiceCall {
    
    NSMutableDictionary* headers;
}

- (void)addHeader:(NSString *)header headerValue:(NSString *)value {

    if (headers == nil) {
        headers = [[NSMutableDictionary alloc] init];
    }
    
    [headers setValue:value forKey:header];
}

- (NSString *)buildRequestParam:(NSDictionary *)requestParam {
    BOOL needAddConnectionWord = false;
    NSMutableString *requestParamValue = [[NSMutableString alloc] init];
    if (requestParam != nil) {
        [requestParamValue appendString:@"?"];
        for (NSString *key in requestParam.allKeys) {
            if (needAddConnectionWord) {
                [requestParamValue appendString:@"&"];
            }
            
            [requestParamValue appendString:key];
            [requestParamValue appendString:@"="];
            [requestParamValue appendString:[requestParam objectForKey:key]];
            //            [requestParamValue appendString:[self mk_urlEncodedString:[requestParam objectForKey:key]]];
            
            needAddConnectionWord = true;
        }
    }
    
    return requestParamValue;
}

- (NSString *)get:(NSString *)url requestParams:(NSDictionary *)params {
    [LogUtils log:@"" message:[StringUtils buildHttpQueryString:url requestParam:params]];
    UNIHTTPStringResponse *response = [[UNIRest get:^(UNISimpleRequest *request) {
        [self buildUniRequest:request reuqestUrl:url requestParams:params];
    }] asString];
    
    [self handlerResponse:response url:url];
    return response.body;
}

- (NSString *)getStringFromServer:(NSString *)url requestParams:(NSDictionary *)params {
    [LogUtils log:@"" message:[StringUtils buildHttpQueryString:url requestParam:params]];
    UNIHTTPStringResponse *response = [[UNIRest get:^(UNISimpleRequest *request) {
        [request setUrl:url];
        [request setHeaders:headers];
//        NSMutableDictionary *convertParams = [[NSMutableDictionary alloc] initWithDictionary:params];
        [request setParameters:params];
    }] asString];
    
    [self handlerResponse:response url:url];
    return response.body;
}

- (NSString *)post:(NSString *)url requestParams:(NSDictionary *)params {
    [LogUtils log:@"" message:[StringUtils buildHttpQueryString:url requestParam:params]];
    UNIHTTPStringResponse *response = [[UNIRest post:^(UNISimpleRequest *request) {
        [self buildUniRequest:request reuqestUrl:url requestParams:params];
    }] asString];
    
    [self handlerResponse:response url:url];
    
    return response.body;
}

- (NSString *)post:(NSString *)url jsonObject:(NSString *)jsonObject {
    [LogUtils log:@"" message:[StringUtils buildHttpQueryString:url requestParam:nil]];
    [LogUtils log:@"" message:[NSString stringWithFormat:@"jsonObject = %@", jsonObject]];
    
    UNIHTTPStringResponse *response = [[UNIRest postEntity:^(UNIBodyRequest *request) {
        [self buildUniRequest:request requestUrl:url jsonObject:jsonObject];
    }] asString];
    [self handlerResponse:response url:url];
    
    return response.body;
}

- (void)buildUniRequest:(UNIBodyRequest *)request requestUrl:(NSString *)url jsonObject:(NSString *)jsonObject {
    [request setUrl:url];
    
    NSMutableDictionary *_headers = [[NSMutableDictionary alloc] initWithDictionary:headers];
    [_headers setValue:@"1" forKey:@"deviceType"];
    
    CGRect deviceFrame = [UIScreen mainScreen ].applicationFrame;
    int width = 2*deviceFrame.size.width;
    
    [_headers setValue:[StringUtils valueOfInt:width] forKey:@"sw"];
    [_headers setValue:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] forKey:@"v"];
    [request setHeaders:_headers];
    
    request.body = [jsonObject dataUsingEncoding:NSUTF8StringEncoding];
}

- (void)buildUniRequest:(UNISimpleRequest *)request reuqestUrl:(NSString *)url requestParams:(NSDictionary *)params {
    
    [request setUrl:url];    
    [request setHeaders:headers];
    
    NSMutableDictionary *convertParams = [[NSMutableDictionary alloc] initWithDictionary:params];
    //1:iOS
    [convertParams setValue:@"1" forKey:@"deviceType"];
    
    CGRect deviceFrame = [UIScreen mainScreen ].applicationFrame;
    int width = 2*deviceFrame.size.width;
    
    [convertParams setValue:[StringUtils valueOfInt:width] forKey:@"sw"];
    [convertParams setValue:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] forKey:@"v"];
    
    [request setParameters:convertParams];
}

- (void)handlerResponse:(UNIHTTPResponse *)response url:(NSString *)url {
    [LogUtils log:@"RemoteService" message:[NSString stringWithFormat:@"url = %@ and response.body = %@", url, ((UNIHTTPStringResponse *)response).body]];
    if (response.code != 200 && response.code != 300) {
        NSString *reason = [NSString stringWithFormat:@"Server response status: %ld", (long)response.code];
        @throw [[RemoteServerException alloc] initWithReason:reason];
    }
}

@end
