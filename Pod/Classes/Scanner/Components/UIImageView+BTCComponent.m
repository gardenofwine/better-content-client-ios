//
//  UIImageView+BTCComponent.m
//  Pods
//
//  Created by Benny Weingarten-Gabbay on 11/14/14.
//
//

#import "UIImageView+BTCComponent.h"

@implementation UIImageView (BTCComponent)

- (void)btcIsSerializable{}

- (NSString *)btcClass{
    return @"image";
}

- (NSDictionary *)btcAttributes{
    return @{};
}

@end
