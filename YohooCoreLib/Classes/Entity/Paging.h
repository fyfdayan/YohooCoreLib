//
//  Paging.h
//  BaLaBaLa
//
//  Created by Jackson Fu on 15/8/3.
//  Copyright (c) 2015年   叭啦叭啦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"

#define FIRST_PAGE 1
#define DEFAULT_PAGE_SIZE 10

@interface Paging : Entity

@property (nonatomic) int page;
@property (nonatomic) int pages;
@property (nonatomic) int records;
@property (nonatomic) int pageSize;

/**
 *  根据分页大小及记录数，计算页面，调用该方法之前需要先设置pageSize及records参数
 *
 */
- (void)calculatePages;

@end
