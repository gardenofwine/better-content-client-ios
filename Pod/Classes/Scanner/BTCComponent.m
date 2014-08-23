//
//  BTCComponent.m
//  Pods
//
//  Created by Benny Weingarten-Gabbay on 8/24/14.
//
//

#import "BTCComponent.h"

@interface BTCComponent ()
@end

@implementation BTCComponent

- (instancetype)initWithKey:(NSString *)key attributes:(NSDictionary *)attributes comparator:(ComponentComparator)comparator{
    self = [super init];
    if (self) {
        _key = key;
        _attributes = attributes;
        _comparator = comparator;
    }
    return self;
}

- (instancetype)initWithMemoryAddressKey:(NSObject *)object attributes:(NSDictionary *)attributes comparator:(ComponentComparator)comparator{
    return [self initWithKey:[self.class memoryAddress:object] attributes:attributes comparator:comparator];
}

- (BOOL)equalToComponent:(BTCComponent *)otherComponent{
    return self.comparator(self, otherComponent);
}

#pragma mark - NSObject overrides

- (BOOL)isEqual:(id)other{
    BTCComponent *otherComponent = (BTCComponent *)other;
    return [self.key isEqual:otherComponent.key];
}

- (NSUInteger)hash{
    return self.key.hash;
}

#pragma mark - class helpers
+ (NSString *)memoryAddress:(NSObject *)object{
    return [NSString stringWithFormat:@"%p", object];
}


@end
