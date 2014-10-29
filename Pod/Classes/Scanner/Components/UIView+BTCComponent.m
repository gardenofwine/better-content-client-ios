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
    NSMutableDictionary *baseAttributes = [NSMutableDictionary new];
    [baseAttributes addEntriesFromDictionary:@{
                                 @"frame" :(__bridge NSDictionary*) CGRectCreateDictionaryRepresentation(globalFrame),
                                 @"class" : NSStringFromClass([self class])
                                 }];
    [baseAttributes addEntriesFromDictionary:[self btcAttributes]];
    
    return [[BTCComponent alloc] initWithMemoryAddressKey:self
                                               attributes:baseAttributes];
}

- (NSDictionary *)btcAttributes{
    return @{};
}


@end
