//
//  EntityJsonResponseHandler.m
//  BaLaBaLa
//
//  Created by Jackson Fu on 15/8/6.
//  Copyright (c) 2015年 叭啦叭啦. All rights reserved.
//

#import "EntityJsonResponseHandler.h"

@implementation EntityJsonResponseHandler {
    
    Class _entityClass;
    NSMutableArray *_records;
}

@synthesize parsedEntity, records;

- (instancetype)initWithEntityClass:(Class)entityClass {
    
    self = [super init];
    if (self) {
        _entityClass = entityClass;
    }
    
    return self;
}

//对象解析
- (void)parseRecord:(NSDictionary *)record {
    parsedEntity = [self innerParseRecord:record];
}

//数组解析
- (void)parseRecordset:(NSArray *)recordset {
    
    _records = [[NSMutableArray alloc] init];
    for (NSDictionary *node in recordset) {
        id entity = [self innerParseRecord:node];
        [_records addObject:entity];
    }
    
    records = _records;
}

- (id)innerParseRecord:(NSDictionary *)record {
//    id entity = [RLMObject initWithJSONDictionary:record andClass:_entityClass];
    
    id entity = [[_entityClass alloc] initWithJSONDictionary:record];
    
    return entity;
}

@end
