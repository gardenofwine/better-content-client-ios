//
//  BTCScanner.m
//  Pods
//
//  Created by Benny Weingarten-Gabbay on 8/19/14.
//
//

#import "BTCScanner.h"
#import "BTCComponent.h"
#import <BlocksKit.h>

@implementation BTCScanner

NSMutableArray *componentCollectors;

+(void)initialize{
   componentCollectors = [NSMutableArray new];
}
// Each item is a BTCComponent object
- (NSArray *)visibleComponents{
    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
    NSMutableArray *visibleComponents = [NSMutableArray new];
    [self collectVisibleComponentsFromView:[topWindow subviews] inArray:visibleComponents index:0];
    return visibleComponents;
}

#pragma clang diagnostic ignored "-Wundeclared-selector"

- (void)collectVisibleComponentsFromView:(NSArray *)views inArray:(NSMutableArray *)componentArray index:(int)zIndex{
    __block int index = zIndex;
    __weak typeof(self) weakSelf = self;
    [views bk_each:^(UIView *view) {
        if (view.hidden || view.alpha < 0.01) return;
        BOOL collectView = ([view respondsToSelector:@selector(btcIsSerializable)] && [view performSelector:@selector(btcIsSerializable)]);
        collectView = collectView || [view isMemberOfClass:[UIView class]];
        if (collectView) {
            [componentArray addObject:[[BTCComponent alloc ] initWithView:view zIndex:index]];
            index = index + 1;
        }
        [weakSelf collectVisibleComponentsFromView:[view subviews] inArray:componentArray index:index];
    }];
}

@end
