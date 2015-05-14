//
//  BTCComponent.h
//  Pods
//
//  Created by Benny Weingarten-Gabbay on 8/24/14.
//
//

#import <Foundation/Foundation.h>
@class BTCComponent;


#define ATTRIBUTES_KEY @"attributes"
#define KEY_KEY @"key"
@interface BTCComponent : NSObject

@property (nonatomic, readonly) NSString *key;
@property (nonatomic, readonly) NSDictionary *attributes;
@property (nonatomic, readonly) UIView *view;

- (instancetype)initWithView:(UIView *)view;
- (instancetype)initWithView:(UIView *)view zIndex:(int)zIndex;
- (instancetype)initFromAttributes:(NSDictionary *)attributes;
@end
