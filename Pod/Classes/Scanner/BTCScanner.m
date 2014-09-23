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

- (void)collectVisibleComponentsFromView:(NSArray *)views inArray:(NSMutableArray *)componentArray{
    __weak typeof(self) weakSelf = self;
    [views bk_each:^(UIView *view) {
        [componentCollectors bk_each:^(id<BTCComponentCollector> componentCollector) {
            if ([componentCollector isViewCollectible:view])
                [componentArray addObject:[componentCollector componentFromView:view]];
        }];
        
        [weakSelf collectVisibleComponentsFromView:[view subviews] inArray:componentArray];
    }];
}

#pragma mark - component methods
+ (id<BTCComponentCollector>)componentCollectorForView:(UIView *)view{
    __block id<BTCComponentCollector> viewComponentCollector = nil;
    [componentCollectors bk_each:^(id<BTCComponentCollector> componentCollector) {
        if ([componentCollector isViewCollectible:view])
            viewComponentCollector = componentCollector;
    }];
    return viewComponentCollector;
}


#pragma mark - component regisrty
+ (void)registerComponentCollector:(NSString *) componentCollectorClassName{
    Class klass = NSClassFromString(componentCollectorClassName);
    if ([klass conformsToProtocol:@protocol(BTCComponentCollector)]) {
        id<BTCComponentCollector> instance = [[klass alloc] init];
        [componentCollectors addObject:instance];
    } else {
        // TODO error message
    }
}


@end
