//
//  UIView+BTCComponent.m
//  Pods
//
//  Created by Benny Weingarten-Gabbay on 10/23/14.
//
//

#import "UIView+BTCComponent.h"

@implementation UIView (BTCComponent)

- (NSDictionary *)btcSerialize:(NSNumber *)zIndex {
    [self btcSerializeWillStart];
    CGRect globalFrame = [self btcGlobalFrame];
    CGSize size = [self btcCorrectSizeFromFrame:globalFrame];
    NSMutableDictionary *baseAttributes = [NSMutableDictionary new];
    NSDictionary *backgroundColor = [self btcRGBAColorFromUIColor:self.backgroundColor];
    if ([NSStringFromClass([self class]) isEqualToString:@"_UINavigationBarBackIndicatorView"]){
        NSLog(@"");
    }
    [baseAttributes addEntriesFromDictionary:@{
                                               @"backgroundColor": backgroundColor == nil ? @"" : backgroundColor,
                                               @"z-index":zIndex,
                                               @"native-class": NSStringFromClass([self class]),
                                               @"frame" :@{
                                                       @"X": @(globalFrame.origin.x),
                                                       @"Y": @(globalFrame.origin.y),
                                                       @"Width": @(size.width),
                                                       @"Height": @(size.height)
                                                       },
                                               @"nativeClass" : [[self class] description],
                                               @"class" : [self btcClassName]
                                               }];
    [baseAttributes addEntriesFromDictionary:[self btcAttributes]];
    
    [self btcSerializeDidEnd];
    return baseAttributes;
}

#pragma mark - defualt implementations
- (BOOL)btcIsSerializable {
    return NO;
}
- (NSDictionary *)btcAttributes {
    return @{};
}
- (CGSize)btcFrameSize {
    return self.frame.size;
}
- (NSString *)btcClassName {
    return @"view";
}
- (void)btcSerializeWillStart {
}
- (void)btcSerializeDidEnd {
}


#pragma mark - helpers

- (CGRect)btcGlobalFrame {
    return [self convertRect:self.bounds toView:nil];
}

- (CGSize)btcCorrectSizeFromFrame:(CGRect)frame {
    CGSize size = [self btcFrameSize];
    if (size.width == 0 && size.height == 0) {
        size = frame.size;
    }
    return size;
}

- (NSDictionary *)btcRGBAColorFromUIColor:(UIColor *) color {
    if (color == nil) return nil;
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([color CGColor]);
    CGColorSpaceModel colorSpaceModel = CGColorSpaceGetModel(colorSpace);
    if (colorSpaceModel == kCGColorSpaceModelRGB) {
        CGFloat r, g, b, a;
        [color getRed: &r green:&g blue:&b alpha:&a];
        return @{
                 @"r": [NSNumber numberWithFloat:r * 255],
                 @"g": [NSNumber numberWithFloat:g * 255],
                 @"b": [NSNumber numberWithFloat:b * 255],
                 @"a": [NSNumber numberWithFloat:a * self.alpha]
                 };
    } else if (colorSpaceModel == kCGColorSpaceModelMonochrome) {
        CGFloat w, a;
        [color getWhite:&w alpha:&a];
        return @{
                 @"r": [[NSNumber numberWithFloat:w * 255] stringValue],
                 @"g": [NSNumber numberWithFloat:w * 255],
                 @"b": [NSNumber numberWithFloat:w * 255],
                 @"a": [NSNumber numberWithFloat:a * self.alpha]
                 };
        
    } else {
        NSLog(@"[BTC]: Can't figure out rgba for color space model '%d'", colorSpaceModel);
        return nil;
    }
}

@end
