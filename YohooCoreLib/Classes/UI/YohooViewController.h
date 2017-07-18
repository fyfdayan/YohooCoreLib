//
//  YohooViewController.h
//    叭啦叭啦
//
//  Created by Jackson Fu on 15/7/31.
//  Copyright (c) 2015年 Sinedu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YohooTask.h"

@interface YohooViewController : UIViewController <YohooTaskDelegate>
/**
 * A convenient method of initWithNibName:bundle:
 */
- (id)initWithNibName:(NSString *)nibNameOrNil;

/**
 * Intialize with default xib which name is same to the controller's name
 */
- (id)initWithDefaultNibName:(Class)controllerClass;

/**
 framework名称，允许为空
    如果不为空调用initWithDefaultNibName这个方法时则会自动补齐为：@"frameworkname.framework/class"

 @return <#return value description#>
 */
- (NSString *)frameworkName;


/**
 获取framework的nibname

 @return <#return value description#>
 */
- (NSString *)nibNameFromFramework:(NSString *)nibName;

/**
 *  第一次布局时执行的方法
 */
- (void)viewDidFirstLayout NS_REQUIRES_SUPER; 

#pragma mark - AsyncTask

/**
 *  开启一个异步任务，默认显示Loading界面
 *
 *  @param taskFlag 任务标识
 */
- (void)startAsyncTask:(int)taskFlag;

/**
 *  开启一个异步任务，指定参数，默认显示Loading界面
 *
 *  @param taskFlag 任务标识
 *  @param param 任务参数
 */
- (void)startAsyncTask:(int)taskFlag withParm:(id)param;

/**
 *  取消所有异步任务
 */
- (void)cancelAllAsyncTasks;

/**
 *  获取当前异步线程数量
 *
 *  @return 异步线程数量
 */
- (NSInteger)getCurrentOperationCount;

/**
 * 执行异步操作时，显示“处理中”，参数what当前具体的操作。
 *
 */
- (void)showProcessingIndicator:(int)what;

/**
 * 执行异步操作结束时，关闭“处理中”，参数what当前具体的操作。
 *
 */
- (void)hideProcessingIndicator:(int)what;

/**
 *  toast文本
 */
- (void)makeToast:(NSString *)toast view:(UIView *)view;

/**
 *  显示toast
 *
 *  @param toast toast文本
 */
- (void)makeToast:(NSString *)toast;

/**
 *  处理网络连接异常
 */
- (void)handleNetworkException;

/**
 *  获取登录超时异常名称
 *
 *  @return 登录超时异常名称
 */
- (NSString *)getLogonTimeoutExceptionName;

/**
 *  处理登录超时异常
 */
- (void)handleLogonTimeoutException;

/**
 * 在异步线程中执行具体的业务逻辑。
 *
 * @param taskFlag 该参数是一个标记值，用于表明当前执行具体的业务逻辑，该参数将被直接传递给方法 onAsyncTaskSuccess。
 * @param param 执行业务所需要的参数
 */
- (id)onAsyncTaskCall:(int)taskFlag withParam:(id)param;

/**
 * 异步任务执行成功后，将通过该方法将返回值传递给调用者
 *
 * @param taskResult 成功后的返回数据
 */
- (void)onAsyncTaskSuccess:(YohooTaskResult *)taskResult;

/**
 * 异步调用中出现异常。
 *
 * @param taskResult 异常
 */
- (void)onAsyncTaskException:(YohooTaskResult *)taskResult;

/**
 *  异步任务执行完成
 *
 *  @param task 任务
 */
- (void)onAsyncTaskFinally:(YohooTask *)task;

/**
 *  处理远程服务异常
 */
- (void)handleRemoteServerException:(YohooTaskResult *)taskResult;

/**
 *  处理合并账号
 *
 *  @param reason 原因
 */
- (void)duplicateKeyException:(NSString *)reason;

@end
