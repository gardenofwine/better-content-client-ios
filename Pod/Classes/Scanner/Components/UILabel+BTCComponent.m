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

- (NSString *)btcClassName{
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
    CGFloat rFloat =0 ,gFloat = 0,bFloat = 0,aFloat = 0;
    
    int r,g,b,a;
    const CGFloat* components = CGColorGetComponents(self.textColor.CGColor);
    r = (int)(255.0 * components[0]);
    g = (int)(255.0 * components[1]);
    b = (int)(255.0 * components[2]);
    a = (int)(255.0 * aFloat);

    // This is a non-RGB color
    if(CGColorGetNumberOfComponents(self.textColor.CGColor) == 2) {
        g = b = r;
    }
    
    return [NSString stringWithFormat:@"#%02X%02X%02X",r,g,b];
}

- (NSString *)btcSafeText{
    if (self.text) return self.text;
    return @"";
}

@end
