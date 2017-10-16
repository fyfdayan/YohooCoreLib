//
//  ViewUtils.m
//  
//
//  Created by Jackson Fu on 3/25/13.
//  
//

#import "ViewUtils.h"
#import "ViewLoader.h"

@implementation ViewUtils
+ (ViewLoader *)getLoader {
    return [[ViewLoader alloc] init];
}

+ (id)loadViewWithViewClass:(Class)viewClass {
    return [[ViewUtils getLoader] loadViewWithViewClass:viewClass];
}

+ (id)loadViewWithViewClass:(Class)viewClass atIndex:(int)index {
    return [[ViewUtils getLoader] loadViewWithViewClass:viewClass owner:nil atIndex:index];
}

+ (id)loadViewWithViewClass:(Class)viewClass owner:(id)owner {
    return [[ViewUtils getLoader] loadViewWithViewClass:viewClass owner:owner atIndex:0];
}

+ (id)loadViewWithViewClass:(Class)viewClass owner:(id)owner atIndex:(int)index {
    return [[ViewUtils getLoader] loadViewFromNib:NSStringFromClass(viewClass) owner:owner atIndex:index];
}

+ (id)loadViewFromNib:(NSString *)nibName {
    return [[ViewUtils getLoader] loadViewFromNib:nibName owner:nil atIndex:0];
}


+ (id)loadViewFromNib:(NSString *)nibName owner:(id)owner {
    return [[ViewUtils getLoader] loadViewFromNib:nibName owner:owner atIndex:0];
}

+ (id)loadViewFromNib:(NSString *)nibName atIndex:(int)index {
    return [[ViewUtils getLoader] loadViewFromNib:nibName owner:nil atIndex:index];
}

+ (id)loadViewFromNib:(NSString *)nibName owner:(id)owner atIndex:(int)index {
    return [[ViewUtils getLoader] loadViewFromNib:nibName owner:owner atIndex:index];
}

+ (id)loadViewFromNib:(NSString *)nibName withBundle:(NSString *)bundleName owner:(id)owner {
    NSBundle *bundle = [NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:bundleName]];
    NSArray *views = [bundle loadNibNamed:nibName owner:owner options:nil];
    NSInteger index = 0;
    if (index >= 0 && index < views.count) {
        return views[index];
    }
    
    return nil;
}


+ (void)removeAllSubViews:(UIView *)view {
    [[ViewUtils getLoader] removeAllSubViews:view];
}

+ (void)removeSubViews:(UIView *)view fromIndex:(int)index {
    [[ViewUtils getLoader] removeSubViews:view fromIndex:index];
}

+ (void)removeSubView:(UIView *)view atIndex:(int)index {
    [[ViewUtils getLoader] removeSubView:view atIndex:index];
}

@end
