//
//  ApplicationUtils.m
//  
//
//  Created by Jackson Fu on 10/7/12.
//
//

#import "ApplicationUtils.h"
#import "AlertUtils.h"
#import "StringUtils.h"

#pragma mark - OpenAppAlertViewDelegate

@interface OpenAppAlertViewDelegate : NSObject <UIAlertViewDelegate>

@property (copy, nonatomic) NSString *appStoreUrl;

@end

@implementation OpenAppAlertViewDelegate

@synthesize appStoreUrl;

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStoreUrl]];
    }
}

@end


#pragma mark - ApplicationUtils

static ApplicationUtils *_instance;

@interface ApplicationUtils () {
    NSDictionary *infoDictionary;
    OpenAppAlertViewDelegate *openAppAlertViewDelegate;
}

@end

@implementation ApplicationUtils

+ (NSString *)documentPath {
    return [NSString stringWithFormat:@"%@/Documents/", NSHomeDirectory()];
}

+ (NSString *)cachePath {
    
    static NSString *path;
    if (path == nil) {
        NSArray* cachePathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        path = [cachePathArray lastObject];
    }
    
    return path;
}

/**
 * 获取App显示名称
 */
+ (NSString *)appDisplayName {
    return [[ApplicationUtils getInstance] getAppDisplayName];
}

/**
 * 获取App主版本号
 */
+ (NSString *)appMajorVersion {
    return [[ApplicationUtils getInstance] getAppMajorVersion];
}

/**
 * 获取App次版本号
 */
+ (NSString *)appMinorVersion {
    return [[ApplicationUtils getInstance] getAppMinorVersion];
}

+ (UIWindow *)appWindow {
    
    static UIWindow *window;
    if (window == nil) {
        window = [[[[UIApplication sharedApplication] keyWindow] subviews] lastObject];
    }
    
    return window;
}


+ (void)openApplication:(NSString *)appUrl withAppStoreUrl:(NSString *)downloadUrl withPrompt:(NSString *)prompt {
    [[ApplicationUtils getInstance] _openApplication:appUrl withAppStoreUrl:downloadUrl withPrompt:prompt];
}


#pragma mark - Private methods

- (id)init {
    self = [super init];
    infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    return self;
}

+ (ApplicationUtils *)getInstance {
    
    if (_instance == nil) {
        _instance = [[ApplicationUtils alloc] init];
    }
    
    return _instance;
}

- (NSString *)getAppDisplayName {
    NSString *appName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    return appName == nil ? @"" : appName;
}


- (NSString *)getAppMajorVersion {
    NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return version == nil ? @"" : version;
}


- (NSString *)getAppMinorVersion {
    NSString *version = [infoDictionary objectForKey:@"CFBundleVersion"];
    return version == nil ? @"" : version;
}

- (void)_openApplication:(NSString *)appUrl withAppStoreUrl:(NSString *)downloadUrl withPrompt:(NSString *)prompt {
    
    BOOL ret = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appUrl]];
    if (!ret && [StringUtils isNotEmpty:prompt]) {
        
        if ([StringUtils isNotEmpty:downloadUrl]) {
            openAppAlertViewDelegate = [[OpenAppAlertViewDelegate alloc] init];
            openAppAlertViewDelegate.appStoreUrl = downloadUrl;
            
            [AlertUtils confirm:prompt withButtonTitles:@[@"下载", @"取消"] buttonDelegate:openAppAlertViewDelegate];
        } else {
            [AlertUtils alert:prompt ];
        }
    }
}


@end
