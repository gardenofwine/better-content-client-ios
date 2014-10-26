//
//  UILabel+BTCComponent.m
//  Pods
//
//  Created by Benny Weingarten-Gabbay on 10/22/14.
//
//

#import "UILabel+BTCComponent.h"
#import "UIView+BTCComponent.h"

@implementation UILabel (BTCLabel)

- (void)btcIsSerializable{}

- (BTCComponent *)btcSerialize{
    BTCComponent *component = [super btcSerialize];
    [component mergeAttributes:@{@"text": self.text}];
    return component;
}

- (void)updateWithComponent:(BTCComponent *)newComponent{
    self.text = [newComponent.attributes objectForKey:@"text"];
}

@end
