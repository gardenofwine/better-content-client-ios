//
//  UIView+BTCComponent.m
//  Pods
//
//  Created by Benny Weingarten-Gabbay on 10/23/14.
//
//

#import "UIView+BTCComponent.h"

@implementation UIView (BTCComponent)

- (BTCComponent *)btcSerialize{
    return [[BTCComponent alloc] initWithMemoryAddressKey:self
                                               attributes:@{@"frame" : [NSValue valueWithCGRect:self.frame_to_dict]}];
}


@end
