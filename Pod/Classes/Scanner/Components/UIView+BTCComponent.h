//
//  UIView+BTCComponent.h
//  Pods
//
//  Created by Benny Weingarten-Gabbay on 10/23/14.
//
//

#import <UIKit/UIKit.h>
#import "BTCComponent.h"

@interface UIView (BTCComponent)

- (BTCComponent *)btcSerialize;
- (NSDictionary *)btcAttributes;
- (CGSize)btcSize;
@end
