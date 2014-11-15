//
//  UIImageView+BTCComponent.m
//  Pods
//
//  Created by Benny Weingarten-Gabbay on 11/14/14.
//
//

#import "UIImageView+BTCComponent.h"
#import "UIImage+ResizeMagick.h"

#define MAX_IMAGE_SIZE 1024
#define MAX_IMAGE_SIDE_SIZE 32
@implementation UIImageView (BTCComponent)

- (void)btcIsSerializable{}

- (NSString *)btcClass{
    return @"image";
}

- (NSDictionary *)btcAttributes{
    return @{
             @"image": [self base64Image],
             @"hidden": @(self.hidden || self.alpha < 0.01)
            };
}

- (NSString *)base64Image{
    UIImage *theImage = self.image;
    if (self.image != nil) {
        if ([self shouldResize:self.image.size]){
            theImage = [self.image resizedImageWithMaximumSize:CGSizeMake(MAX_IMAGE_SIDE_SIZE,MAX_IMAGE_SIDE_SIZE)];
        }
        NSString *imageString = [UIImagePNGRepresentation(theImage) base64EncodedStringWithOptions:0];
        if (imageString != nil) return imageString;
    }
    return @"";
}

- (BOOL)shouldResize:(CGSize)imageSize{
    return imageSize.height * imageSize.width >= MAX_IMAGE_SIZE;
}
             
@end
