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
@interface BTCComponent : NSObject

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSDictionary *attributes;
@property (nonatomic, readonly) UIView *view;

- (instancetype)initWithKey:(NSString *)key attributes:(NSDictionary *)attributes;
- (instancetype)initWithMemoryAddressKey:(UIView *)object attributes:(NSDictionary *)attributes;
@end
