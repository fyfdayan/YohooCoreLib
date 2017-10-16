//
//  ViewUtils.h
//  
//
//  Created by Jackson Fu on 3/25/13.
//  
//

#import <Foundation/Foundation.h>

@interface ViewUtils : NSObject


/**
 * @method loadViewWithViewClass:
 * @abstract 从与类名对应的XIB文件中加载View对象，View的owner为nil
 * @param viewClass View对象类名
 */
+ (id)loadViewWithViewClass:(Class)viewClass;

/**
 * @method loadViewWithViewClass:
 * @abstract 从与类名对应的XIB文件中加载指定索引的View对象，View的owner为nil
 * @param viewClass View对象类名
 * @param index View在XIB中的顺序索引
 */
+ (id)loadViewWithViewClass:(Class)viewClass atIndex:(int)index;

/**
 * @method loadViewWithViewClass:
 * @abstract 从与类名对应的XIB文件中加载View对象，允许指定View的owner
 * @param viewClass View对象类名
 * @param owner View的owner
 */
+ (id)loadViewWithViewClass:(Class)viewClass owner:(id)owner;

/**
 * @method loadViewWithViewClass:
 * @abstract 从与类名对应的XIB文件中加载指定索引的View对象，允许指定View的owner
 * @param viewClass View对象类名
 * @param owner View的owner
 * @param index View在XIB中的顺序索引
 */
+ (id)loadViewWithViewClass:(Class)viewClass owner:(id)owner atIndex:(int)index;

/**
 * @method loadViewFromNib:
 * @abstract 从XIB文件中加载View对象，View的owner为nil
 * @param nibName XIB文件名
 */
+ (id)loadViewFromNib:(NSString *)nibName;

/**
 * @method loadViewFromNib:
 * @abstract 从与类名对应的XIB文件中加载指定索引的View对象，允许指定View的owner
 * @param nibName XIB文件名
 * @param index View在XIB中的顺序索引
 */
+ (id)loadViewFromNib:(NSString *)nibName atIndex:(int)index;

/**
 * @method loadViewFromNib:
 * @abstract 从XIB文件中加载View对象，允许指定View的owner
 * @param nibName XIB文件名
 */
+ (id)loadViewFromNib:(NSString *)nibName owner:(id)owner;

/**
 * @method loadViewFromNib:
 * @abstract 从与类名对应的XIB文件中加载指定索引的View对象，允许指定View的owner
 * @param nibName XIB文件名
 * @param owner View的owner
 * @param index View在XIB中的顺序索引
 */
+ (id)loadViewFromNib:(NSString *)nibName owner:(id)owner atIndex:(int)index;

/**
 从xib加载view

 @param nibName xib的名称
 @param bundleName bundle 名称
 @return view
 */
+ (id)loadViewFromNib:(NSString *)nibName withBundle:(NSString *)bundleName owner:(id)owner;

/**
 * @method removeAllSubViews:
 * @abstract 删除View的所有sub view
 */
+ (void)removeAllSubViews:(UIView *)view;

/**
 * @method removeSubViews:fromIndex:
 * @abstract 删除View从指定索引开始的sub view
 */
+ (void)removeSubViews:(UIView *)view fromIndex:(int)index;

/**
 * @method removeSubViews:fromIndex:
 * @abstract 删除View中指定索引的sub view
 */
+ (void)removeSubView:(UIView *)view atIndex:(int)index;

@end
