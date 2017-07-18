//
//  JsonResponseHandler.h
//  BaLaBaLa
//
//  Created by Jackson Fu on 15/8/4.
//  Copyright (c) 2015年   叭啦叭啦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Paging.h"

@interface JsonResponseHandler : NSObject

@property (nonatomic, readonly) int status;
@property (nonatomic, readonly) Paging *paging;

/**
 *  解析JSON字符串
 *
 *  @param jsonStr json返回字符串
 */
- (void)parse:(NSString *)jsonStr;

- (void)parseRecord:(NSDictionary *)record;
- (void)parseRecordset:(NSArray *)recordset;

- (BOOL)validateNode:(id)jsonValue;
- (BOOL)validateStringNode:(NSString *)jsonValue;

@end
