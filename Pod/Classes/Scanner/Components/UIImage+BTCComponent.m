//
//  UIImage+BTCComponent.m
//  Pods
//
//  Created by Benny Weingarten-Gabbay on 11/14/14.
//
//

#import "UIImage+BTCComponent.h"

@implementation UIImage (BTCComponent)

- (void)btcIsSerializable{}

- (NSString *)btcClass{
    return @"image";
}

- (NSDictionary *)btcAttributes{
    return @{};
}

@end
