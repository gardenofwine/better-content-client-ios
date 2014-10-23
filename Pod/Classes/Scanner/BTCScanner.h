//
//  BTCScanner.h
//  Pods
//
//  Created by Benny Weingarten-Gabbay on 8/19/14.
//
//

#import <Foundation/Foundation.h>
#import "BTCComponentCollector.h"

@interface BTCScanner : NSObject

- (NSArray *)visibleComponents;
//+ (void)registerComponentCollector:(NSString *) componentCollectorClassName;
//+ (id<BTCComponentCollector>)componentCollectorForView:(UIView *)view;
@end
