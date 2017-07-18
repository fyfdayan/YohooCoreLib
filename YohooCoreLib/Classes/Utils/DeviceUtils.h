//
//  DeviceUtils.h
//  
//
//  Created by Jackson Fu on 7/3/12.
//  
//

#import <Foundation/Foundation.h>

@interface DeviceUtils : NSObject

/**
 * 是否为Retina屏幕
 */
+ (BOOL)isRetina;

/**
 * 是否为3.5吋Retina屏幕
 */
+ (BOOL)isRetina3Inch;

/**
 * 是否为4吋Retina屏幕
 */
+ (BOOL)isRetina4Inch;

/**
 *  获取设备屏幕大小
 *
 *  @return 设备屏幕大小
 */
+ (CGRect)getMainScreenSize;

/**
 * 获得设备操作系统版本
 */
+ (float)deviceSystemVersion;

/**
 * 获得设备型号
 */
+ (NSString *)deviceModel;

/**
 * 获得设备当前连接到的WIFI SSID
 */
+ (NSString *)fetchCurrentSSID;

/**
 *	获取iOS设备的MAC地址
 *
 *	@return	MAC地址
 */
+ (NSString *)getMacAddress;


@end
