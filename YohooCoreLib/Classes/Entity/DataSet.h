//
//  DataSet.h
//  BaLaBaLa
//
//  Created by Jackson Fu on 15/8/3.
//  Copyright (c) 2015年   叭啦叭啦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Paging.h"

@interface DataSet : NSObject

@property (strong, nonatomic) NSArray *records;
@property (strong, nonatomic) Paging *paging;

@end
