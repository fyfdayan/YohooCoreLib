//
//  YohooTask.h
//    叭啦叭啦
//
//  Created by Jackson Fu on 15/7/31.
//  Copyright (c) 2015年 Sinedu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YohooTaskDelegate;


#pragma mark - YohooTaskResult


@interface YohooTaskResult: NSObject

@property (nonatomic) int taskFlag;
@property (strong, nonatomic) id data;
@property (nonatomic, retain) NSException *exception;

- (id)init:(int)taskFlag withData:(id)result;
- (id)init:(int)taskFlag withException:(id)exception;

@end



#pragma mark - YohooTask


@interface YohooTask : NSOperation

@property (nonatomic, weak) id<YohooTaskDelegate> delegate;
@property (nonatomic) int taskFlag;
@property (nonatomic, strong) id taskParam;

- (id)init:(int)taskFlag withParam:(id)param;

@end


#pragma mark - YohooTaskDelegate


@protocol YohooTaskDelegate <NSObject>

@optional

/**
 * 在异步线程中执行具体的业务逻辑。
 *
 * @param taskFlag 该参数是一个标记值，用于表明当前执行具体的业务逻辑，该参数将被直接传递给方法 onAsyncTaskSuccess。
 * @param param 执行业务所需要的参数
 */
- (id)onAsyncTaskCallReal:(int)taskFlag withParam:(id)param;

/**
 * 异步任务执行成功后，将通过该方法将返回值传递给调用者
 *
 * @param taskResult 返回数据
 */
- (void)onAsyncTaskSuccessReal:(YohooTaskResult *)taskResult;

/**
 * 异步调用中出现异常。
 *
 * @param taskResult 异常数据
 */
- (void)onAsyncTaskExceptionReal:(YohooTaskResult *)taskResult;

/**
 *  异步任务执行完成
 *
 *  @param task 完成后的数据
 */
- (void)onAsyncTaskFinallyReal:(YohooTask *)task;

@end

