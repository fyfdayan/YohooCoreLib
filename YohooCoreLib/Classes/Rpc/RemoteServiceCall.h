//
//  RemoteServiceCall.h
//  BaLaBaLa
//
//  Created by Jackson Fu on 15/8/7.
//  Copyright (c) 2015年 叭啦叭啦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RemoteServiceCall : NSObject

- (void)addHeader:(NSString *)header headerValue:(NSString *)value;

/**
 *  发起Http get请求，并返回响应结果字符串
 *
 *  @param url url
 *  @param params 参数
 *
 *  @return 完整的请求url
 */
- (NSString *)get:(NSString *)url requestParams:(NSDictionary *)params;

- (NSString *)getStringFromServer:(NSString *)url requestParams:(NSDictionary *)params;

/**
 *  发起Http post请求，并返回响应结果字符串
 *
 *  @param url url
 *  @param params 请求参数，如果需要上传文件，则直接将文件的URL对象加入到该参数中，例如
 *  
 *      NSURL* file = nil;
 *      NSDictionary* parameters = @{@"parameter": @"value", @"file": file};
 *
 *  @return 服务器返回数据
 */
- (NSString *)post:(NSString *)url requestParams:(NSDictionary *)params;

- (NSString *)post:(NSString *)url jsonObject:(NSString *)jsonObject;

@end
