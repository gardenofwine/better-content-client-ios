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

- (NSString *)btcClass{
    return @"label";
}

- (NSDictionary *)btcAttributes{
    return @{
             @"text": self.safeText,
             @"font" : @{
                     @"pointSize" : @(self.font.pointSize)
                     }
             };
}

- (void)updateWithComponent:(BTCComponent *)newComponent{
    self.text = [newComponent.attributes objectForKey:@"text"];
}

- (NSString *)safeText{
    if (self.text) return self.text;
    return @"";
}

@end
