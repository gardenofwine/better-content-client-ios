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
typedef BOOL (^ComponentComparator)(BTCComponent *comp1, BTCComponent *comp2);

@interface BTCComponent : NSObject

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSDictionary *attributes;
@property (nonatomic, strong) ComponentComparator comparator;
@property (nonatomic, readonly) UIView *view;

- (instancetype)initWithKey:(NSString *)key attributes:(NSDictionary *)attributes comparator:(ComponentComparator)comparator;
- (instancetype)initWithMemoryAddressKey:(UIView *)object attributes:(NSDictionary *)attributes comparator:(ComponentComparator)comparator;
- (BOOL)equalToComponent:(BTCComponent *)otherComponent;

@end
