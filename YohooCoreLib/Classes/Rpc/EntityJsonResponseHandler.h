//
//  EntityJsonResponseHandler.h
//  BaLaBaLa
//
//  Created by Jackson Fu on 15/8/6.
//  Copyright (c) 2015年 叭啦叭啦. All rights reserved.
//

#import "JsonResponseHandler.h"

@interface EntityJsonResponseHandler : JsonResponseHandler

@property (nonatomic, readonly) id parsedEntity;
@property (nonatomic, readonly) NSArray *records;

/**
 *  使用需要解析出的对象实例进行初始化
 *
 *  @param entityClass 类
 *
 *  @return 类的实体
 */
- (instancetype)initWithEntityClass:(Class)entityClass;

@end
