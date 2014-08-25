//
//  BTCServerCoordinator.m
//  Pods
//
//  Created by Benny Weingarten-Gabbay on 8/19/14.
//
//

#import <BlocksKit.h>
#import "BTCServerCoordinator.h"
#import "BTCScanner.h"
#import "BTCComponent.h"
#import "BTCServerCommunicator.h"

@interface BTCServerCoordinator () <BTCServerCommunicatorDelegate>
@property (nonatomic) BTCServerCommunicator *serverCommunicator;
@property (nonatomic) BTCScanner *contentScanner;
@property (nonatomic) NSArray *currentVisibleComponents;

@end

@implementation BTCServerCoordinator

- (void)start{
    self.serverCommunicator = [BTCServerCommunicator new];
    self.serverCommunicator.delegate = self;
    self.contentScanner = [BTCScanner new];
    self.currentVisibleComponents = @[];
    
    [self.serverCommunicator connect];
}

- (void)startScanTask{
    __weak __typeof(&*self)weakSelf = self;
    [NSTimer bk_scheduledTimerWithTimeInterval:1 block:^(NSTimer *timer) {
        NSArray *newVisibleComponents = [weakSelf.contentScanner visibleComponents];
        if ([self visibleComponentsChanged:newVisibleComponents]){
            self.currentVisibleComponents = newVisibleComponents;
            NSLog(@"**== sending changed components to server");
            [weakSelf.serverCommunicator sendComponents:self.currentVisibleComponents];
        }
    } repeats:YES];
}

#pragma mark - BTCServerCommunicatorDelegate
- (void)didConnectToServer{
    [self startScanTask];
}


- (void)receivedBetterContent:(NSArray *)componentsArray{
    NSLog(@"**== Did receive components from server");
}


#pragma mark - visible components processing

- (BOOL)visibleComponentsChanged:(NSArray *)newVisibleComponents{
    if (self.currentVisibleComponents.count != newVisibleComponents.count) return YES;
    
    BOOL changed = [newVisibleComponents bk_any:^BOOL(BTCComponent *component) {
        if ([self.currentVisibleComponents containsObject:component]){
            BTCComponent *curentComponent = [self.currentVisibleComponents objectAtIndex:
                               [self.currentVisibleComponents indexOfObject:component]];
            return ![curentComponent equalToComponent:component];
        } else {
            return YES;
        }
    }];
    
    return changed;
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
