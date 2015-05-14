//
//  UIView+BTCComponent.m
//  Pods
//
//  Created by Benny Weingarten-Gabbay on 10/23/14.
//
//

#import "UIView+BTCComponent.h"
#import "UIColor+HexColors.h"

@implementation UIView (BTCComponent)

- (NSDictionary *)btcSerialize:(NSNumber *)zIndex{
    [self btcSerializeWillStart];
    CGRect globalFrame = [self btcGlobalFrame];
    CGSize size = [self btcCorrectSizeFromFrame:globalFrame];
    NSMutableDictionary *baseAttributes = [NSMutableDictionary new];
    NSString *hexColor = [UIColor hexValuesFromUIColor:self.backgroundColor];
    hexColor = hexColor == nil ? @"" : hexColor;
    [baseAttributes addEntriesFromDictionary:@{
                                               @"backgroundColor": hexColor,
                                               @"z-index":zIndex,
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
- (BOOL)btcIsSerializable{return NO;}
- (NSDictionary *)btcAttributes{return @{};}
- (CGSize)btcFrameSize{return self.frame.size;}
- (NSString *)btcClassName{return @"view";}
- (void)btcSerializeWillStart{}
- (void)btcSerializeDidEnd{}


#pragma mark - helpers

- (CGRect)btcGlobalFrame{
    return [self convertRect:self.bounds toView:nil];
}

- (CGSize)btcCorrectSizeFromFrame:(CGRect)frame{
    CGSize size = [self btcFrameSize];
    if (size.width == 0 && size.height == 0){
        size = frame.size;
    }
    return size;
}

@end
