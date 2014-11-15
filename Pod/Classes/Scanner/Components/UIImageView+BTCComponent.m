//
//  UIImageView+BTCComponent.m
//  Pods
//
//  Created by Benny Weingarten-Gabbay on 11/14/14.
//
//

#import "UIImageView+BTCComponent.h"
#import "UIImage+Resize.h"

#define MAX_IMAGE_SIZE 1000
#define MAX_IMAGE_SIDE_SIZE 50
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
            theImage = [self.image resizedImage:[self scaledDownImageSize:self.image.size] interpolationQuality:kCGInterpolationLow];
        }
        NSString *imageString = [UIImagePNGRepresentation(theImage) base64EncodedStringWithOptions:0];
        if (imageString != nil) return imageString;
    }
    return @"";
}

- (BOOL)shouldResize:(CGSize)imageSize{
    return imageSize.height * imageSize.width >= MAX_IMAGE_SIZE;
}

- (CGSize)scaledDownImageSize:(CGSize)originalSize{
    CGFloat maxSide = MAX(originalSize.width, originalSize.height);
    CGFloat scaleFactor = MAX_IMAGE_SIDE_SIZE / maxSide;
    
    return CGSizeMake(originalSize.width * scaleFactor, originalSize.height * scaleFactor);
}
                               
             
@end
