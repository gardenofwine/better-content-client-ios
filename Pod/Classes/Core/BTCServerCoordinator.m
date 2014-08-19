//
//  BTCServerCoordinator.m
//  Pods
//
//  Created by Benny Weingarten-Gabbay on 8/19/14.
//
//

#import "BTCServerCoordinator.h"
#import "BTCScanner.h"

@interface BTCServerCoordinator ()
@property (nonatomic) BTCScanner *contentScanner;
@end


@implementation BTCServerCoordinator

- (void)start{
    self.contentScanner = [BTCScanner new];
    
//    self.labelRegistry = [NOCLabelsRegistry new];
//    self.labelRegistry.delegate = self;
//    [self initiateLabelScanningTask];
//    
//    [self connectWebSocket];
    
}


#pragma mark - singelton

+ (BTCServerCoordinator *)sharedInstance {
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static BTCServerCoordinator * _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    
    // returns the same object each time
    return _sharedObject;
}

@end
