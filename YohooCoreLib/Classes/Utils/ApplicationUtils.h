//
//  ApplicationUtils.h
//  
//
//  Created by Jackson Fu on 10/7/12.
//
//

#import <Foundation/Foundation.h>

@interface ApplicationUtils : NSObject

/**
 * 获取App文档路径
 */
+ (NSString *)documentPath;

/**
 * 获取App缓存路径
 */
+ (NSString *)cachePath;

/**
 * 获取App显示名称
 */
+ (NSString *)appDisplayName;

/**
 * 获取App主版本号
 */
+ (NSString *)appMajorVersion;

/**
 * 获取App次版本号
 */
+ (NSString *)appMinorVersion;

/**
 *	获取当前Application的Window
 *
 *	@return 当前应用的窗口主体
 */
+ (UIWindow *)appWindow;

/**
 *  打开第三方App，如果打开失败，则提示用户，如果提供了App Store下载url，则跳转至App Store对应页面下载
 *
 *  @param appUrl   app地址
 *  @param downloadUrl  下载地址
 *  @param prompt   内容
 */
+ (void)openApplication:(NSString *)appUrl withAppStoreUrl:(NSString *)downloadUrl withPrompt:(NSString *)prompt;

@end
