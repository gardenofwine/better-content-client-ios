//
//  BTCComponentCollector.h
//  Pods
//
//  Created by Benny Weingarten-Gabbay on 8/19/14.
//
//

#import <Foundation/Foundation.h>
#import "BTCComponent.h"
@protocol BTCComponentCollector

- (BOOL)isViewCollectible:(UIView *)view;
- (BTCComponent *)componentFromView:(UIView *)view;
@end
