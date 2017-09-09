//
//  ViewLoader.m
//  Pods
//
//  Created by 傅雁锋 on 2017/7/13.
//
//

#import "ViewLoader.h"
#import "StringUtils.h"

@implementation ViewLoader

- (NSString *)frameworkName {
    return @"";
}

- (id)loadViewWithViewClass:(Class)viewClass {
    return [self loadViewWithViewClass:viewClass owner:nil];
}

- (id)loadViewWithViewClass:(Class)viewClass atIndex:(int)index {
    return [self loadViewWithViewClass:viewClass owner:nil atIndex:index];
}

- (id)loadViewWithViewClass:(Class)viewClass owner:(id)owner {
    return [self loadViewWithViewClass:viewClass owner:owner atIndex:0];
}

- (id)loadViewWithViewClass:(Class)viewClass owner:(id)owner atIndex:(int)index {
    NSString *nibName = NSStringFromClass(viewClass);
    
    NSBundle *bundle = [NSBundle bundleForClass:viewClass];
    NSArray *views = [bundle loadNibNamed:nibName owner:owner options:nil];
    if (index >= 0 && index < views.count) {
        return views[index];
    }
    
    return nil;
}

- (id)loadViewFromNib:(NSString *)nibName {
    return [self loadViewFromNib:nibName owner:nil atIndex:0];
}


- (id)loadViewFromNib:(NSString *)nibName owner:(id)owner {
    return [self loadViewFromNib:nibName owner:owner atIndex:0];
}

- (id)loadViewFromNib:(NSString *)nibName atIndex:(int)index {
    return [self loadViewFromNib:nibName owner:nil atIndex:index];
}

- (id)loadViewFromNib:(NSString *)nibName owner:(id)owner atIndex:(int)index {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:nibName owner:owner options:nil];
    
    if (index >= 0 && index < views.count) {
        return views[index];
    }
    
    return nil;
}


- (void)removeAllSubViews:(UIView *)view {
    for (UIView *subView in view.subviews) {
        [subView removeFromSuperview];
    }
}

- (void)removeSubViews:(UIView *)view fromIndex:(int)index {
    
    if (index >= view.subviews.count) {
        return;
    }
    
    for (int i=index; i<view.subviews.count; i++) {
        [view.subviews[i] removeFromSuperview];
    }
}

- (void)removeSubView:(UIView *)view atIndex:(int)index {
    
    if (index >= view.subviews.count) {
        return;
    }
    
    [view.subviews[index] removeFromSuperview];
}

@end
