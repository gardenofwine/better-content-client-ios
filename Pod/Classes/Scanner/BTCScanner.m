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
    [self collectVisibleComponentsFromView:[topWindow subviews] inArray:visibleComponents];
    return visibleComponents;
}

#pragma clang diagnostic ignored "-Wundeclared-selector"

- (void)collectVisibleComponentsFromView:(NSArray *)views inArray:(NSMutableArray *)componentArray{
    __weak typeof(self) weakSelf = self;
    [views bk_each:^(UIView *view) {
        if (view.hidden) return;
        if ([view respondsToSelector:@selector(btcIsSerializable)]) {
            if ([view performSelector:@selector(btcIsSerializable) withObject:nil]) {
            [componentArray addObject:[[BTCComponent alloc ] initWithView:view]];
        }
        }
        [weakSelf collectVisibleComponentsFromView:[view subviews] inArray:componentArray];
    }];
}

@end
