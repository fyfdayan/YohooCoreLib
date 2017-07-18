//
//  Entity.h
//    叭啦叭啦
//
//  Created by Jackson Fu on 15/8/3.
//  Copyright (c) 2015年 Sinedu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
//#import <Realm+JSON/RLMObject+JSON.h>
#import <MJExtension/MJExtension.h>
#import <Realm_JSON/RLMObject+JSON.h>

@interface Entity : RLMObject

@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *entityId;

- (void)setIgnoredProperties:(NSDictionary *)dictionary;

@end
