//
//  DbService.m
//  
//
//  Created by Jackson Fu on 5/12/11.
//  
//

#import "DbService.h"
#import "StringUtils.h"
#import "ApplicationUtils.h"

#pragma mark - SQLBlock

@implementation SQLBlock

@synthesize sql=_sql, arguments=_arguments;

- (id)initWithSQL:(NSString *)sql {
    
    self = [super init];
    
    if (self) {
        _sql = sql;
    }
    
    return self;
}

- (id)initWithSQL:(NSString *)sql withArguments:(NSArray *)arguments {
    
    self = [super init];
    
    if (self) {
        _sql = sql;
        _arguments = arguments;
    }
    
    return self;
    
}

@end


#pragma mark - DbService

@interface DbService () {
    
    NSString *dbPath;
}

@end

@implementation DbService

- (id)initWithDbPath:(NSString *)path {
    
    self = [super init];
    if (self) {
        dbPath = path;
    }
    
    return self;
}

- (id)initWithDb:(NSString *)dbFilename {
    return [self initWithDb:dbFilename forceOverwite:NO];
}

- (id)initWithDb:(NSString *)dbFilename forceOverwite:(BOOL)overwrite {
    
    self = [super init];
    
    if (self) {
        NSString *dir = [[ApplicationUtils documentPath] stringByAppendingPathComponent:@"DB"];
        [self prepareDatabase:dbFilename dbDir:dir forceOverwite:overwrite];
    }
    
    return self;
    
}

- (id)initWithDb:(NSString *)dbFilename withDbFolder:(NSString *)dir {
    return [self initWithDb:dbFilename withDbFolder:dir forceOverwite:NO];
}

- (id)initWithDb:(NSString *)dbFilename withDbFolder:(NSString *)dir forceOverwite:(BOOL)overwrite {
    self = [super init];
    
    if (self) {
        [self prepareDatabase:dbFilename dbDir:dir forceOverwite:overwrite];
    }
    
    return self;
}

- (void)prepareDatabase:(NSString *)dbFilename dbDir:(NSString *)dir {
    [self prepareDatabase:dbFilename dbDir:dir forceOverwite:NO];
}


- (void)prepareDatabase:(NSString *)dbFilename dbDir:(NSString *)dir forceOverwite:(BOOL)overwrite {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError* error;
    
    if (![fileManager fileExistsAtPath:dir]) {
        [fileManager createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    // 如果文件已经存在, 则返回路径
    NSString *path = [StringUtils isNotEmpty:dir] ? [dir stringByAppendingPathComponent:dbFilename] : dbFilename;
    if([fileManager fileExistsAtPath:path]) {
        
        if (overwrite) {
            [fileManager removeItemAtPath:path error:nil];
        } else {
            dbPath = path;
            return;
        }
    }
    
    // 如果文件不存在, 拷贝一份, 返回路径
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbFilename];
    
    if( [fileManager copyItemAtPath:defaultDBPath toPath:path error:&error]) {
        dbPath = path;
    }
    
    if (error != nil) {
        [NSException raise:@"Copy DB failed" format:@"%@", error.description];
    }
    
}

- (NSArray *)query:(NSString *)sql resultSet:(id (^)(FMResultSet *))resultSetHandler {
    
    return [self query:sql withArgumentsInArray:nil resultSet:resultSetHandler];
}

- (NSArray *)query:(NSString *)sql withArgumentsInArray:(NSArray *)arguments resultSet:(id (^)(FMResultSet *))resultSetHandler {
    
    FMDatabase *db = [self open];
    FMResultSet *rs = (arguments == nil)
                        ? [db executeQuery:sql]
                        : [db executeQuery:sql withArgumentsInArray:arguments];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    if (resultSetHandler != nil) {
        while ([rs next]) {
            id data = resultSetHandler(rs);
            [array addObject:data];
        }
    }
    
    [rs close];
    [db close];
    
    return array;
}

- (id)get:(NSString *)sql resultSet:(id (^)(FMResultSet *))resultSetHandler {
    
    return [self get:sql withArgumentsInArray:nil resultSet:resultSetHandler];
}

- (id)get:(NSString *)sql withArgumentsInArray:(NSArray *)arguments resultSet:(id (^)(FMResultSet *))resultSetHandler {
    
    FMDatabase *db = [self open];
    FMResultSet *rs = (arguments == nil)
                    ? [db executeQuery:sql]
                    : [db executeQuery:sql withArgumentsInArray:arguments];
    
    id result = nil;
    if (resultSetHandler != nil) {
        if ([rs next]) {
            result = resultSetHandler(rs);
        }
    }
    
    [rs close];
    [db close];
    
    return result;
}

- (void)executeUpdate:(NSString *)sql withArgumentsInArray:(NSArray *)arguments {
    FMDatabase *db = [self open];
    
    [db beginTransaction];
    
    @try {
        [db executeUpdate:sql withArgumentsInArray:arguments];
        [db commit];
    } @catch (NSException *exception) {
//        LogError(@"%@", exception.reason);
        [db rollback];
    } @finally {
        [db close];
    }

}

- (void)batchUpdate:(NSArray *)blocks {
    
    if (blocks == nil || blocks.count == 0) {
        return;
    }
    
    FMDatabase *db = [self open];
    [db beginTransaction];
    
    @try {
        for (SQLBlock *block in blocks) {
            [db executeUpdate:block.sql withArgumentsInArray:block.arguments];
        }
        
        [db commit];
    } @catch (NSException *exception) {
//        LogError(@"%@", exception.reason);
        [db rollback];
    } @finally {
        [db close];
    }
    
}

- (FMDatabase *)open {
    
    if ([StringUtils isNotEmpty:dbPath]) {
        FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
        [db open];
        
        return db;
    }else {
        [NSException raise:@"No valid database" format:@"%@", @"Please set database path first"];
    }
    
    return nil;
}

- (int)getDataCount:(NSString *)sql withArgumentsInArray:(NSArray *)arguments {
    FMDatabase *db = [self open];
    FMResultSet *rs = (arguments == nil)
    ? [db executeQuery:sql]
    : [db executeQuery:sql withArgumentsInArray:arguments];
    
    int count = 0;
    if ([rs next]) {
//        count = [rs columnCount];
        count = [rs intForColumnIndex:0];
    }
    
    [rs close];
    [db close];
    
    return count;
}

@end
