//
//  BTCComponent.h
//  Pods
//
//  Created by Benny Weingarten-Gabbay on 8/24/14.
//
//

#import <Foundation/Foundation.h>
@class BTCComponent;

typedef BOOL (^ComponentComparator)(BTCComponent *comp1, BTCComponent *comp2);

@interface BTCComponent : NSObject

@property (nonatomic) NSString *key;
@property (nonatomic) NSDictionary *attributes;
@property (nonatomic, strong) ComponentComparator comparator;

- (instancetype)initWithKey:(NSString *)key attributes:(NSDictionary *)attributes comparator:(ComponentComparator)comparator;
- (instancetype)initWithMemoryAddressKey:(NSObject *)object attributes:(NSDictionary *)attributes comparator:(ComponentComparator)comparator;

- (BOOL)equalToComponent:(BTCComponent *)otherComponent;

@end
