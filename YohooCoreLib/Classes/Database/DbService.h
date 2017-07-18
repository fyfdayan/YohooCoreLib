//
//  DbService.h
//  
//
//  Created by Jackson Fu on 5/12/11.
//  
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>


#pragma mark - SQLBlock

@interface SQLBlock : NSObject

@property (copy, nonatomic) NSString *sql;
@property (strong, nonatomic) NSArray *arguments;


/**
    @method initWithSQL:
    @abstract 使用执行的SQL语句构造对象
    @param sql sql
 */
- (id)initWithSQL:(NSString *)sql;

/**
    @method initWithSQL:withArguments
    @abstract 使用执行的SQL语句及对应的参数，构造对象
    @param sql sql
    @param arguments 参数
 */
- (id)initWithSQL:(NSString *)sql withArguments:(NSArray *)arguments;

@end


#pragma mark - DbService

@interface DbService : NSObject

/**
    @method initWithDbPath:
    @abstract 使用数据库文件路径构建对象
    @param dbPath 数据库文件路径
 */
- (id)initWithDbPath:(NSString *)dbPath;

/**
     @method initWithDb:
     @abstract 使用数据库构造对象，该方法会检测${DOCUMENT_HOME}/DB/${dbFilename}数据库，
        如果未检测到数据库，则会将App中${dbFilename}资源拷贝到目标目录中
     @param dbFilename 数据库文件名
 */
- (id)initWithDb:(NSString *)dbFilename;


/**
    @method initWithDb:
    @abstract 使用数据库构造对象，该方法会检测${DOCUMENT_HOME}/DB/${dbFilename}数据库，
        如果未检测到数据库，则会将App中${dbFilename}资源拷贝到目标目录中
    @param dbFilename 数据库文件名
 */
- (id)initWithDb:(NSString *)dbFilename forceOverwite:(BOOL)overwrite;

/**
     @method initWithDb:withDbFolder:
     @abstract 使用数据库构造对象，该方法会检测${DOCUMENT_HOME}/${dir}/${dbFilename}数据库，
        如果未检测到数据库，则会将App中${dbFilename}资源拷贝到目标目录中
     @param dbFilename 数据库文件名
     @param dir 数据库存放的目录
 */
- (id)initWithDb:(NSString *)dbFilename withDbFolder:(NSString *)dir;


/**
    @method initWithDb:withDbFolder:
    @abstract 使用数据库构造对象，该方法会检测${DOCUMENT_HOME}/${dir}/${dbFilename}数据库，
        如果未检测到数据库，则会将App中${dbFilename}资源拷贝到目标目录中
    @param dbFilename 数据库文件名
    @param dir 数据库存放的目录
    @param overwrite 是否覆盖
 */
- (id)initWithDb:(NSString *)dbFilename withDbFolder:(NSString *)dir forceOverwite:(BOOL)overwrite;

/**
    @method prepareDatabaset:dbDir:
    @abstract 准备数据库
    @param dbFilename 数据库文件名
    @param dir 数据库存放的目录
 */
- (void)prepareDatabase:(NSString *)dbFilename dbDir:(NSString *)dir __deprecated;

/**
 @method prepareDatabaset:dbDir:
 @abstract 准备数据库
 @param dbFilename 数据库文件名
 @param dir 数据库存放的目录
 @param overwrite 是否覆盖
 */
- (void)prepareDatabase:(NSString *)dbFilename dbDir:(NSString *)dir forceOverwite:(BOOL)overwrite;

/**
    @method query:resultSet:
    @abstract 根据SQL查询数据库，并将记录集回调callback block块
 */
- (NSArray *)query:(NSString *)sql resultSet:(id (^)(FMResultSet *))resultSetHandler;

/**
    @method query:resultSet:
    @abstract 根据SQL查询数据库，并将记录集回调callback block块
 */
- (NSArray *)query:(NSString *)sql withArgumentsInArray:(NSArray *)arguments resultSet:(id (^)(FMResultSet *))resultSetHandler;

/**
    @method get:resultSet:
    @abstract 根据SQL查询数据库，获取单挑记录，如果没有符合条件的记录，则返回nil
 */
- (id)get:(NSString *)sql resultSet:(id (^)(FMResultSet *))resultSetHandler;


/**
    @method get:resultSet:
    @abstract 根据SQL查询数据库，获取单挑记录，如果没有符合条件的记录，则返回nil
 */
- (id)get:(NSString *)sql withArgumentsInArray:(NSArray *)arguments resultSet:(id (^)(FMResultSet *))resultSetHandler;

/**
    @method executeUpdate:withArgumentsInArray:
    @abstract 执行数据更新，该方法可以执行insert/update/delete语句
    @param sql 执行SQL语句
    @param arguments SQL中的参数
 */
- (void)executeUpdate:(NSString *)sql withArgumentsInArray:(NSArray *)arguments;

/**
    @method batchUpdate:
    @abstract 在一个事务中，批量执行SQL更新
    @param blocks SQLBlock类型的数组
 */
- (void)batchUpdate:(NSArray *)blocks;

/**
    获取sql的总数
 */
- (int)getDataCount:(NSString *)sql withArgumentsInArray:(NSArray *)arguments;

@end
