//
//  Entity.m
//    叭啦叭啦
//
//  Created by Jackson Fu on 15/8/3.
//  Copyright (c) 2015年 Sinedu. All rights reserved.
//

#import "Entity.h"

@implementation Entity

+ (NSArray *)ignoredProperties {
    return @[@"entityId", @"opCredits"];
}

//+ (NSString *)replacedKeyFromPropertyName121:(NSString *)propertyName {
//    // nickName -> nick_name
//    return [propertyName underlineFromCamel];
//}

- (NSString *)entityId {
    return self.id;
}

- (void)setEntityId:(NSString *)entityId {
    self.id = entityId;
}

- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:[Entity class]]) {
        return false;
    }
    
    Entity *entity = object;
    return [entity.entityId isEqualToString:self.entityId];
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dictionary {
    id entity = [super initWithJSONDictionary:dictionary];
    [entity setIgnoredProperties:dictionary];
    return entity;
}

- (void)setIgnoredProperties:(NSDictionary *)dictionary {
    
}

@end
