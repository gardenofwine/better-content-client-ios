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
    return @{
             @"image": [self base64Image],
             @"hidden": @(self.hidden)
            };
}

- (NSString *)base64Image{
    if (self.image != nil) {
        NSString *imageString = [UIImagePNGRepresentation(self.image) base64EncodedStringWithOptions:0];
        if (imageString != nil) return imageString;
    }
    return @"";
    
}
@end
