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
@synthesize attributes = _attributes;

- (instancetype)initWithView:(UIView *)view {
    self = [super init];
    if (self) {
        self.viewWeakReference = [MAZeroingWeakRef refWithTarget:view];
        _key = [self.class memoryAddress:view];
    }
    return self;
}

- (instancetype)initFromAttributes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        _key = [attributes objectForKey:KEY_KEY];
        _attributes = [attributes objectForKey:ATTRIBUTES_KEY];
    }
    return self;
    
}

#pragma clang diagnostic ignored "-Wundeclared-selector"
- (NSDictionary *)attributes{
    if (!_attributes) {
        if ([self.view respondsToSelector:@selector(btcSerialize)])
         _attributes = @{@"key": self.key, ATTRIBUTES_KEY: [self.view performSelector:@selector(btcSerialize)]};
    }
    return _attributes;
}

#pragma mark - get view
// Retuns nil if the view has already been deallocated
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
