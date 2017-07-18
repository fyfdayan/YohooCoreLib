//
//  CameraUtils.m
//  CompanyPlus
//
//  Created by 陈国梁 on 15/7/8.
//  Copyright (c) 2015年 厦门象形远教网络科技有限公司. All rights reserved.
//

#import "CameraUtils.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>

@implementation CameraUtils

+ (BOOL)getCameraCanUse {
    BOOL isCameraValid = YES;
    //ios7之前系统默认拥有权限
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        if (authStatus == AVAuthorizationStatusDenied)
        {
            isCameraValid = NO;
        }
    }
    return isCameraValid;
}

+ (BOOL)getAssetsLibraryCanUse {
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    
    if(author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied){
        return NO;
    }
    
    return YES;
}

@end
