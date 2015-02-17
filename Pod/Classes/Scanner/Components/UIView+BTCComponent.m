//
//  UIView+BTCComponent.m
//  Pods
//
//  Created by Benny Weingarten-Gabbay on 10/23/14.
//
//

#import "UIView+BTCComponent.h"

@implementation UIView (BTCComponent)

- (NSDictionary *)btcSerialize{
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
                                @"class" : [self btcClassName]
                                 }];
    [baseAttributes addEntriesFromDictionary:[self btcAttributes]];
    
    [self btcSerializeDidEnd];
    return baseAttributes;
}

#pragma mark - defualt implementations
- (NSDictionary *)btcAttributes{return @{};}
- (CGSize)btcFrameSize{return CGSizeZero;}
- (NSString *)btcClassName{return @"";}
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
