//
//  BTCScanner.h
//  Pods
//
//  Created by Benny Weingarten-Gabbay on 8/19/14.
//
//

#import <Foundation/Foundation.h>

@interface BTCScanner : NSObject

- (NSArray *)visibleComponents;

+ (void)registerComponentCollector:(NSString *) componentCollectorClassName;
@end
