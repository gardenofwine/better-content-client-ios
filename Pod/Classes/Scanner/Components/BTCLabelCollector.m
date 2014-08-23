//
//  BTCLabelCollector.m
//  Pods
//
//  Created by Benny Weingarten-Gabbay on 8/19/14.
//
//

#import "BTCLabelCollector.h"

#define BTC_LABEL_ATTRIBUTE_TEXT @"text"
@implementation BTCLabelCollector

- (BOOL)isViewCollectible:(UIView *)view{
    if ([view isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)view;
        // TODO only add labels that are visible on sceen
        return (label.text && !label.hidden);
    }
    
    return NO;
}

- (BTCComponent *)componentFromView:(UIView *)view{
    UILabel *label = (UILabel *)view;
    ComponentComparator comparator = ^BOOL(BTCComponent *comp1, BTCComponent *comp2) {
        NSString *string1 = [self labelTextFromComponent:comp1];
        NSString *string2 = [self labelTextFromComponent:comp2];
        return [string1 isEqualToString:string2];
        
    };
    return [[BTCComponent alloc] initWithMemoryAddressKey:view
                                               attributes:@{BTC_LABEL_ATTRIBUTE_TEXT : label.text}
                                               comparator:comparator];
}

- (NSString *)labelTextFromComponent:(BTCComponent *)component{
    return [component.attributes objectForKey:BTC_LABEL_ATTRIBUTE_TEXT];
}


@end
