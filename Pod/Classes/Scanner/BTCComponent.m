//
//  BTCComponent.m
//  Pods
//
//  Created by Benny Weingarten-Gabbay on 8/24/14.
//
//

#import "BTCComponent.h"
#import "MAZeroingWeakRef.h"

@interface BTCComponent ()
@property (nonatomic) MAZeroingWeakRef *viewWeakReference;
@end

@implementation BTCComponent
@synthesize view = _view;
- (instancetype)initWithKey:(NSString *)key attributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        _key = key;
        _attributes = attributes;
    }
    return self;
}

- (instancetype)initWithMemoryAddressKey:(UIView *)object attributes:(NSDictionary *)attributes{
    self.viewWeakReference = [MAZeroingWeakRef refWithTarget:object];
    return [self initWithKey:[self.class memoryAddress:object] attributes:attributes];
}

- (void)mergeAttributes:(NSDictionary *)attributes{
    NSMutableDictionary *currentArrtibutes = [_attributes mutableCopy];
    [currentArrtibutes addEntriesFromDictionary:attributes];
    self.attributes = currentArrtibutes;
}


#pragma mark - get view
- (UIView *)view{
    return (UIView *)self.viewWeakReference.target;
}

#pragma mark - NSObject overrides

- (BOOL)isEqual:(id)other{
    BTCComponent *otherComponent = (BTCComponent *)other;
    return [self.key isEqualToString:otherComponent.key];
}

- (NSUInteger)hash{
    return self.key.hash;
}

#pragma mark - class helpers
+ (NSString *)memoryAddress:(NSObject *)object{
    return [NSString stringWithFormat:@"%p", object];
}


@end
