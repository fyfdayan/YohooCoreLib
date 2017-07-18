//
//  Utils.h
//  
//
//  Created by Jackson Fu on 6/12/11.
//  
//

#import <Foundation/Foundation.h>

@interface AlertUtils : NSObject

+ (void)alert:(NSString *)message;

+ (void)alert:(NSString *)message buttonDelegate:(id<UIAlertViewDelegate>)delegate;

+ (void)alert:(NSString *)message withTag:(int)tag buttonDelegate:(id<UIAlertViewDelegate>)delegate;

+ (void)confirm:(NSString *)message buttonDelegate:(id<UIAlertViewDelegate>)delegate;

+ (void)confirm:(NSString *)message withTag:(int)tag buttonDelegate:(id<UIAlertViewDelegate>)delegate;

+ (void)confirm:(NSString *)message withButtonTitles:(NSArray *)buttonTitles buttonDelegate:(id<UIAlertViewDelegate>)delegate;

+ (void)confirm:(NSString *)message withButtonTitles:(NSArray *)buttonTitles withTag:(int)tag buttonDelegate:(id<UIAlertViewDelegate>)delegate;

@end
