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
    CGRect globalFrame = [self convertRect:self.bounds toView:nil];
    return [[BTCComponent alloc] initWithMemoryAddressKey:self
                                               attributes:@{@"frame" :(__bridge NSDictionary*) CGRectCreateDictionaryRepresentation(globalFrame)}];
}



@end
