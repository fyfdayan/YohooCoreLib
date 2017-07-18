//
//  Utils.m
//  
//
//  Created by Jackson Fu on 6/12/11.
//  
//

#import "AlertUtils.h"

@implementation AlertUtils

+ (void)alert:(NSString *)message {
    [AlertUtils alert:message withTag:0 buttonDelegate:nil];
}

+ (void)alert:(NSString *)message buttonDelegate:(id<UIAlertViewDelegate>)delegate {
    [AlertUtils alert:message withTag:0 buttonDelegate:delegate];
}

+ (void)alert:(NSString *)message withTag:(int)tag buttonDelegate:(id<UIAlertViewDelegate>)delegate {
        
    UIAlertView *alertView = [[UIAlertView alloc] init];
    alertView.tag = tag;
    [alertView setTitle:@""];
    [alertView setMessage:message];

    [alertView addButtonWithTitle:@"确定"];
    [alertView setDelegate:delegate];
    [alertView show];
}

+ (void)confirm:(NSString *)message buttonDelegate:(id<UIAlertViewDelegate>)delegate {
    [AlertUtils confirm:message withButtonTitles:@[@"确定", @"取消"] withTag:0 buttonDelegate:delegate];
}

+ (void)confirm:(NSString *)message withTag:(int)tag buttonDelegate:(id<UIAlertViewDelegate>)delegate {
    [AlertUtils confirm:message withButtonTitles:@[@"确定", @"取消"] withTag:tag buttonDelegate:delegate];
}

+ (void)confirm:(NSString *)message withButtonTitles:(NSArray *)buttonTitles buttonDelegate:(NSObject<UIAlertViewDelegate> *)delegate {
    [AlertUtils confirm:message withButtonTitles:buttonTitles withTag:0 buttonDelegate:delegate];
}

+ (void)confirm:(NSString *)message withButtonTitles:(NSArray *)buttonTitles withTag:(int)tag buttonDelegate:(id<UIAlertViewDelegate>)delegate {
    
    
    UIAlertView *alertView = [[UIAlertView alloc] init];
    alertView.tag = tag;
    [alertView setTitle:@""];
    [alertView setMessage:message];
    [alertView setDelegate:delegate];
    
    for (NSString *title in buttonTitles) {
        [alertView addButtonWithTitle:title];
    }
    
    [alertView show];
}

@end
