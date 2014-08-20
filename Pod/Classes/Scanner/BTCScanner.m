//
//  BTCScanner.m
//  Pods
//
//  Created by Benny Weingarten-Gabbay on 8/19/14.
//
//

#import "BTCScanner.h"
#import <BlocksKit.h>
#import "BTCComponentCollector.h"

@implementation BTCScanner

NSMutableArray *componentScanners;

+(void)initialize{
   componentScanners = [NSMutableArray new];
}
// Each item is a dictionary with one key and yet another dictionary as a value
//[
// {
//     component_id :{
//         attributes..
//     }
// },
// 
//]
- (NSArray *)visibleComponents{
    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
    NSMutableArray *visibleComponents = [NSMutableArray new];
    [self collectVisibleComponentsFromView:[topWindow subviews] inArray:visibleComponents];
    return visibleComponents;
}

- (void)collectVisibleComponentsFromView:(NSArray *)views inArray:(NSMutableArray *)componentArray{
    __weak typeof(self) weakSelf = self;
    [views bk_each:^(UIView *view) {
        if ([view isKindOfClass:[UILabel class]]){
            UILabel *label = (UILabel *)view;
            // TODO only add labels that are visible on sceen
            if (label.text && !label.hidden){
//                [labelDictionary setObject:view forKey:[weakSelf memoryAddress:view]];
            }
        }
        
        [weakSelf collectVisibleComponentsFromView:[view subviews] inArray:componentArray];
    }];
}


#pragma mark - component regisrty
+ (void)registerComponentCollector:(NSString *) componentCollectorClassName{
    Class klass = NSClassFromString(componentCollectorClassName);
    if ([klass conformsToProtocol:@protocol(BTCComponentCollector)]) {
        id<BTCComponentCollector> instance = [[klass alloc] init];
        [componentScanners addObject:instance];
    } else {
        // TODO error message
    }
}


@end
