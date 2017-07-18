//
//  Paging.m
//  BaLaBaLa
//
//  Created by Jackson Fu on 15/8/3.
//  Copyright (c) 2015年   叭啦叭啦. All rights reserved.
//

#import "Paging.h"

@implementation Paging

- (id)init {
    self = [super init];
    
    self.page = FIRST_PAGE;
    self.pageSize = DEFAULT_PAGE_SIZE;
    
    return self;
}

- (void)calculatePages {
    
    if (self.records == 0)
        return ;
    
    if (self.pageSize > 0){
        self.pages = (int)ceil((self.records - 1)/self.pageSize) + 1;
    }
}

@end
