//
//  BTCServerCoordinator.h
//  Pods
//
//  Created by Benny Weingarten-Gabbay on 8/19/14.
//
//

#import <Foundation/Foundation.h>

@interface BTCServerCoordinator : NSObject
- (void)start;
+ (BTCServerCoordinator *)sharedInstance;

@end
