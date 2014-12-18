//
//  UIImageView+BTCComponent.m
//  Pods
//
//  Created by Benny Weingarten-Gabbay on 11/14/14.
//
//

#import "UIImageView+BTCComponent.h"
#import "UIImage+ResizeMagick.h"
#import "UIImageView+Additions.h"

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
             @"hidden": @(self.hidden || self.alpha < 0.01),
            };
}

//- (CGSize)btcSize{
//    CGSize imageSize = self.image.size;
//    if (self.tag == 99)
//        NSLog(@"**== view size %@, image size %@", NSStringFromCGSize(self.frame.size), NSStringFromCGSize(imageSize));
//    CGSize scale = [self btcImageScale];
//    if (!isnan(scale.width) && !isnan(scale.height) && isfinite(scale.height) && isfinite(scale.width)){
//        imageSize.width *= scale.width;
//        imageSize.height *= scale.height;
//    }
//    return imageSize;
//}

- (NSString *)base64Image{
    UIImage *theImage = [self renderedImage];
    if (self.image != nil) {
        if ([self shouldResize:self.image.size]){
            theImage = [self.image resizedImageWithMaximumSize:CGSizeMake(MAX_IMAGE_SIDE_SIZE,MAX_IMAGE_SIDE_SIZE)];
        }
        NSString *imageString = [UIImagePNGRepresentation(theImage) base64EncodedStringWithOptions:0];
        if (imageString != nil) return imageString;
    }
    return @"";
}

// This method taken from http://stackoverflow.com/a/7159547/280503
- (UIImage *)renderedImage{
    // Size of the result rendered image
    CGSize targetImageSize = self.frame.size;
    if (targetImageSize.width == 0 || targetImageSize.height == 0)
        return nil;
    // Check for retina image rendering option
    if (NULL != UIGraphicsBeginImageContextWithOptions) UIGraphicsBeginImageContextWithOptions(targetImageSize, NO, 0);
    else UIGraphicsBeginImageContext(targetImageSize);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    // The view to be rendered
    [[self layer] renderInContext:context];
    // Get the rendered image
    UIImage *original_image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return original_image;
}

- (BOOL)shouldResize:(CGSize)imageSize{
    return imageSize.height * imageSize.width >= MAX_IMAGE_SIZE;
}
             
@end
