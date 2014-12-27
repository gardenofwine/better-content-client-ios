//
//  UIView+BTCComponent.m
//  Pods
//
//  Created by Benny Weingarten-Gabbay on 10/23/14.
//
//

#import "UIView+BTCComponent.h"

@implementation UIView (BTCComponent)

- (BTCComponent *)btcSerialize{
    [self btcSerializeWillStart];
    CGRect globalFrame = [self btcGlobalFrame];
    CGSize size = [self btcCorrectSizeFromFrame:globalFrame];
    NSMutableDictionary *baseAttributes = [NSMutableDictionary new];
    [baseAttributes addEntriesFromDictionary:@{
                                @"frame" :@{
                                        @"X": @(globalFrame.origin.x),
                                        @"Y": @(globalFrame.origin.y),
                                        @"Width": @(size.width),
                                        @"Height": @(size.height)
                                           },
                                @"class" : [self btcClass]
                                 }];
    [baseAttributes addEntriesFromDictionary:[self btcAttributes]];
    
    [self btcSerializeDidEnd];
    return [[BTCComponent alloc] initWithMemoryAddressKey:self
                                               attributes:baseAttributes];
}

#pragma mark - defualt implementations
- (NSDictionary *)btcAttributes{return @{};}
- (CGSize)btcSize{return CGSizeZero;}
- (NSString *)btcClass{return @"";}
- (void)btcSerializeWillStart{}
- (void)btcSerializeDidEnd{}


#pragma mark - helpers

- (CGRect)btcGlobalFrame{
    return [self convertRect:self.bounds toView:nil];
}

- (CGSize)btcCorrectSizeFromFrame:(CGRect)frame{
    CGSize size = [self btcSize];
    if (size.width == 0 && size.height == 0){
        size = frame.size;
    }
    return size;
}

@end
