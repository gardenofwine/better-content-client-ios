//
//  BTCComponentCollector.h
//  Pods
//
//  Created by Benny Weingarten-Gabbay on 8/19/14.
//
//

#import <Foundation/Foundation.h>

@protocol BTCComponentCollector

- (BOOL)isViewCollectible:(UIView *)view;
- (NSDictionary *)componentFromView:(UIView *)view;
@end
