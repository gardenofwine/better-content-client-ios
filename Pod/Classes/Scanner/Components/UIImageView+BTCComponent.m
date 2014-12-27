//
//  UIImageView+BTCComponent.m
//  Pods
//
//  Created by Benny Weingarten-Gabbay on 11/14/14.
//
//

#import <objc/runtime.h>

#import "UIImageView+BTCComponent.h"
#import "UIImage+ResizeMagick.h"
#import "UIImageView+Additions.h"

#define MAX_IMAGE_SIDE_SIZE 30
#define MAX_IMAGE_SIZE MAX_IMAGE_SIDE_SIZE * MAX_IMAGE_SIDE_SIZE

static char * const SCREENSHOT_KEY = "screenshot";
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

- (CGSize)btcSize{
    UIImage *image = [self screenshot];
    return image.size;
}

- (void)btcSerializeWillStart{
    objc_setAssociatedObject(self, SCREENSHOT_KEY, [self renderedImage], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)btcSerializeDidEnd{
    objc_removeAssociatedObjects(self);
}


#pragma mark - helpers

- (UIImage *)screenshot{
    return objc_getAssociatedObject(self, SCREENSHOT_KEY);
}

- (NSString *)base64Image{
    UIImage *theImage = [self screenshot];
    if (theImage != nil) {
        if ([self shouldResize:theImage.size]){
            theImage = [theImage resizedImageWithMaximumSize:CGSizeMake(MAX_IMAGE_SIDE_SIZE,MAX_IMAGE_SIDE_SIZE)];
        }
        NSString *imageString = [UIImagePNGRepresentation(theImage) base64EncodedStringWithOptions:0];
        if (imageString != nil) return imageString;
    }
    return @"";
}



- (BOOL)shouldResize:(CGSize)imageSize{
    return imageSize.height * imageSize.width >= MAX_IMAGE_SIZE;
}

// This method taken from http://stackoverflow.com/a/7159547/280503
- (UIImage *)renderedImage{
    NSLog(@"**== rendering image");
    // Size of the result rendered image
    CGSize targetImageSize = self.frame.size;
    if (targetImageSize.width == 0 || targetImageSize.height == 0)
        return nil;
    // Check for retina image rendering option
    if (NULL != UIGraphicsBeginImageContextWithOptions) UIGraphicsBeginImageContextWithOptions(targetImageSize, NO, 0);
    else UIGraphicsBeginImageContext(targetImageSize);

    CGContextRef context = UIGraphicsGetCurrentContext();
    [[self layer] renderInContext:context];

    // Get the rendered image
    UIImage *original_image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return original_image;
}

             
@end
