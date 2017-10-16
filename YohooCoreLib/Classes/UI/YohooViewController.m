//
//  YohooViewController.m
//    叭啦叭啦
//
//  Created by Jackson Fu on 15/7/31.
//  Copyright (c) 2015年 Sinedu. All rights reserved.
//

#import "YohooViewController.h"
#import "RpcService.h"
#import "MBProgressHUD.h"
#import "StringUtils.h"
#import "UIView+Yohoo.h"
#import "UIView+Toast.h"

@interface YohooViewController () {
    
    NSOperationQueue *asyncTaskOperationQueue;
    BOOL isFirstLayout;
    
    MBProgressHUD *progressHUD;
}

@end

@implementation YohooViewController

- (id)initWithNibName:(NSString *)nibNameOrNil {
    return [self initWithNibName:nibNameOrNil bundle:nil];
}

- (id)initWithDefaultNibName:(Class)controllerClass {
    NSString *nibName = NSStringFromClass(controllerClass);
//    nibName = [self nibNameFromFramework:nibName];
    NSBundle *bundle = [NSBundle bundleForClass:controllerClass];
    
    return [self initWithNibName:nibName bundle:bundle];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundleName:(NSString *)bundleName {
    NSBundle *bundle = [NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:bundleName]];
    return [self initWithNibName:nibNameOrNil bundle:bundle];
}

- (NSString *)nibNameFromFramework:(NSString *)nibName {
    NSString *frameworkName = [self frameworkName];
    if ([StringUtils isNotEmpty:frameworkName]) {
        nibName = [NSString stringWithFormat:@"%@.framework/%@", frameworkName, nibName];
    }
    
    return nibName;
}

- (NSString *)frameworkName {
    return @"";
}

- (void)dealloc {
    [self cancelAllAsyncTasks];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:progressHUD];
    
    isFirstLayout = true;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (isFirstLayout) {
        isFirstLayout = false;
        [self viewDidFirstLayout];
    }
}

- (void)viewDidFirstLayout {
    
}
#pragma mark - AsyncTask

- (void)startAsyncTask:(int)taskFlag {
    [self startAsyncTask:taskFlag withParm:nil];
}

- (void)startAsyncTask:(int)taskFlag withParm:(id)param {
    [self showProcessingIndicator:taskFlag];
    
    if (asyncTaskOperationQueue == nil) {
        asyncTaskOperationQueue = [[NSOperationQueue alloc] init];
        asyncTaskOperationQueue.name = NSStringFromClass([self class]);
    }
    
    YohooTask *task = [[YohooTask alloc] init:taskFlag withParam:param];
    task.delegate = self;
    [asyncTaskOperationQueue addOperation:task];
}

- (NSInteger)getCurrentOperationCount {
    if (asyncTaskOperationQueue != nil) {
        return asyncTaskOperationQueue.operationCount;
    }
    
    return 0;
}

- (void)cancelAllAsyncTasks {
    
    if (asyncTaskOperationQueue != nil) {
        [asyncTaskOperationQueue cancelAllOperations];
    }
}

- (void)showProcessingIndicator:(int)what {
    [self.view bringSubviewToFront:progressHUD];
    [progressHUD showAnimated:YES];
}

- (void)hideProcessingIndicator:(int)what {
    [progressHUD hideAnimated:YES];
}

#pragma mark - YohooTaskDelegate
- (void)handleNetworkException {
    [self makeToast:@"网络连接有问题，请检查网络配置"];
}

- (NSString *)getLogonTimeoutExceptionName {
    return LOGON_TIMEOUT_EXCEPTION_NAME;
}

- (void)handleLogonTimeoutException {
    
}

- (id)onAsyncTaskCall:(int)taskFlag withParam:(id)param {
    //[self showProcessingIndicator:0];
    return nil;
}

- (void)onAsyncTaskSuccess:(YohooTaskResult *)taskResult {
    //[self hideProcessingIndicator:0];
}

- (void)onAsyncTaskException:(YohooTaskResult *)result {
    
    if ([result.exception.name isEqualToString:@"LogonTimeoutException"]) {
        [self handleLogonTimeoutException];
        return;
    }
    
    if ([result.exception.name isEqualToString:NETWORK_EXCEPTION_NAME]) {
        [self handleNetworkException];
        return;
    }
    
    if ([result.exception.name isEqualToString:@"RemoteServerException"]) {
        [self handleRemoteServerException:result];
        return;
    }
    
    if ([result.exception.name isEqualToString:@"DuplicateKeyException"]) {
        [self duplicateKeyException:result.exception.reason];
        return;
    }
    
    if ([StringUtils isNotEmpty:result.exception.reason]) {
        [self makeToast:result.exception.reason];
        return;
    }
    
    [self makeToast:result.exception.name];
}

- (void)handleRemoteServerException:(YohooTaskResult *)taskResult {
    [self makeToast:@"远程服务错误，请稍候再试"];
}

- (void)duplicateKeyException:(NSString *)reason {
}

- (void)onAsyncTaskFinally:(YohooTask *)task {
    [self hideProcessingIndicator:task.taskFlag];    
}

- (id)onAsyncTaskCallReal:(int)taskFlag withParam:(id)param {
    return [self onAsyncTaskCall:taskFlag withParam:param];
}

- (void)onAsyncTaskExceptionReal:(YohooTaskResult *)taskResult {
    [self onAsyncTaskException:taskResult];
}

- (void)onAsyncTaskFinallyReal:(YohooTask *)task {
    [self onAsyncTaskFinally:task];
}

- (void)onAsyncTaskSuccessReal:(YohooTaskResult *)taskResult {
    [self onAsyncTaskSuccess:taskResult];
}

#pragma mark - Toast
- (void)makeToast:(NSString *)toast {
    [self makeToast:toast view:self.view];
}

- (void)makeToast:(NSString *)toast view:(UIView *)view  {
    //TODO:
    [view makeToast:toast duration:0.8f position:CSToastPositionCenter];
}

@end
