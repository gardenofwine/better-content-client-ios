//
//  UIView+BTCComponent.h
//  Pods
//
//  Created by Benny Weingarten-Gabbay on 10/23/14.
//
//

#import <UIKit/UIKit.h>
#import "BTCComponent.h"

@interface UIView (BTCComponent)

- (BTCComponent *)btcSerialize:(NSNumber *)zIndex;
- (NSDictionary *)btcAttributes;
- (CGSize)btcFrameSize;
- (NSString *)btcClassName;

- (void)btcSerializeWillStart;
- (void)btcSerializeDidEnd;
@end
