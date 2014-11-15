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
             @"text": self.btcSafeText,
             @"font" : @{
                     @"pointSize" : @(self.font.pointSize),
                     @"color" : [self btcHexColor]
                     }
             };
}

- (void)updateWithComponent:(BTCComponent *)newComponent{
    self.text = [newComponent.attributes objectForKey:@"text"];
}

- (NSString *)btcHexColor{
    CGFloat rFloat,gFloat,bFloat,aFloat;
    int r,g,b,a;
    [self.textColor getRed:&rFloat green:&gFloat blue: &bFloat alpha: &aFloat];
    
    r = (int)(255.0 * rFloat);
    g = (int)(255.0 * gFloat);
    b = (int)(255.0 * bFloat);
    a = (int)(255.0 * aFloat);
    
    return [NSString stringWithFormat:@"#%02X%02X%02X",r,g,b];
}

- (NSString *)btcSafeText{
    if (self.text) return self.text;
    return @"";
}

@end
