//
//  RpcService.h
//  BaLaBaLa
//
//  Created by Jackson Fu on 15/8/6.
//  Copyright (c) 2015年 叭啦叭啦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RemoteServiceCall.h"
#import "DataSet.h"
#import "JsonResponseHandler.h"

#define NETWORK_EXCEPTION_NAME  @"NetworkException"
#define LOGON_TIMEOUT_EXCEPTION_NAME    @"LogonTimeoutException"

@interface RpcService : NSObject

@property (nonatomic, strong) RemoteServiceCall *remoteServiceCall;
@property (nonatomic) BOOL isOnlineMode;

- (NSString *)getRpcSchema;

- (NSString *)buildRpcUrl:(NSString *)uri;

/**
 *  发起Http get请求，并将返回的Record数据转换成指定的类型实体
 *
 *  @param url  url
 *  @param params   params
 *  @param clazz    clazz
 *
 *  @return 详细数据
 */
- (id)getDetail:(NSString *)url requestParams:(NSDictionary *)params convertToClass:(Class)clazz;

/**
 *  发起Http get请求，并将返回的Recordset数据转换成指定的类型实体数组
 *
 *  @param url  url
 *  @param params   params
 *  @param clazz    clazz
 *
 *  @return array
 */
- (NSArray *)query:(NSString *)url requestParams:(NSDictionary *)params convertToClass:(Class)clazz;

/**
 *  发起Http get请求，并将返回的Recordset数据转换成指定的类型实体数组的DataSet对象
 *
 *  @param url  url
 *  @param params   params
 *  @param paging   paging
 *  @param clazz    clazz
 *
 *  @return dataset
 */
- (DataSet *)query:(NSString *)url requestParams:(NSDictionary *)params paging:(Paging *)paging convertToClass:(Class)clazz;

/**
 *  发起Http get请求，并将结果委托给JsonResponseHandler处理
 *
 *  @param url  url
 *  @param params   params
 *  @param handler  handler
 */
- (void)sendGetRequest:(NSString *)url requestParams:(NSDictionary *)params jsonResponseHandler:(JsonResponseHandler *)handler;

/**
 *  发起Http post请求，并将返回的Record数据转换成指定的类型实体
 *
 *  @param url  url
 *  @param params 请求参数，如果需要上传文件，则直接将文件的URL对象加入到该参数中，例如
 *
 *      NSURL* file = nil;
 *      NSDictionary* parameters = @{@"parameter": @"value", @"file": file};
 *  @param clazz    clazz
 *
 *  @return id
 */
- (id)sendPostRequest:(NSString *)url requestParams:(NSDictionary *)params convertToClass:(Class)clazz;

/**
 *  发起Http post请求，并将结果委托给JsonResponseHandler处理
 *
 *  @param url  url
 *  @param params 请求参数，如果需要上传文件，则直接将文件的URL对象加入到该参数中，例如
 *
 *      NSURL* file = nil;
 *      NSDictionary* parameters = @{@"parameter": @"value", @"file": file};
 *  @param handler handler
 */
- (void)sendPostRequest:(NSString *)url requestParams:(NSDictionary *)params jsonResponseHandler:(JsonResponseHandler *)handler;

- (id)sendPostRequest:(NSString *)url jsonObject:(NSString *)jsonObject convertToClass:(Class)clazz;

- (NSString *)getStringFromServer:(NSString *)url requestParams:(NSDictionary *)params;

- (NSDictionary *)interceptRequestParam:(NSDictionary *)param;
@end
