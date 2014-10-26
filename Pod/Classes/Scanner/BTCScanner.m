//
//  BTCScanner.m
//  Pods
//
//  Created by Benny Weingarten-Gabbay on 8/19/14.
//
//

#import "BTCScanner.h"
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
        if ([view respondsToSelector:@selector(btcIsSerializable)] && [view respondsToSelector:@selector(btcSerialize)]) {
            [componentArray addObject:[view performSelector:@selector(btcSerialize)]];
        }
        [weakSelf collectVisibleComponentsFromView:[view subviews] inArray:componentArray];
    }];
}

@end
