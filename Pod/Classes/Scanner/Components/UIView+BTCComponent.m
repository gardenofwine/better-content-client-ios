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
    NSDictionary *attributes = @{
                                 @"frame" :(__bridge NSDictionary*) CGRectCreateDictionaryRepresentation(globalFrame)
                                 };
    return [[BTCComponent alloc] initWithMemoryAddressKey:self
                                               attributes:attributes];
}



@end
