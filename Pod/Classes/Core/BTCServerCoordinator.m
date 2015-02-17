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
@property (nonatomic) NSTimer *scanTask;

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
    __weak __typeof(self)weakSelf = self;
    self.scanTask = [NSTimer bk_scheduledTimerWithTimeInterval:1 block:^(NSTimer *timer) {
        NSArray *newVisibleComponents = [weakSelf.contentScanner visibleComponents];
        if ([self visibleComponentsChanged:newVisibleComponents]){
            self.currentVisibleComponents = newVisibleComponents;
            [weakSelf.serverCommunicator sendViews:[weakSelf serializedViews:newVisibleComponents]];
        }
    } repeats:YES];
}

- (void)stopScanTask{
    [self.scanTask invalidate];
    self.scanTask = nil;
    self.currentVisibleComponents = nil;
}

#pragma mark - helpers
- (NSArray *)serializedViews:(NSArray *)componenetsArray{
    return [componenetsArray bk_map:^id(BTCComponent *component) {
        return component.attributes;
    }];
}

#pragma mark - BTCServerCommunicatorDelegate
- (void)didConnectToServer{
    [self startScanTask];
}

- (void)didDisconnectFromServer{
    [self stopScanTask];
}

- (void)receivedBetterContent:(NSArray *)componentsArray{
    NSArray *btcComponents = [componentsArray bk_map:^id(NSDictionary *componentDict) {
        return [[BTCComponent alloc] initFromAttributes:componentDict];
    }];

    [self updateVisibleComponents:btcComponents];
}

#pragma mark - visible components processing

- (BOOL)visibleComponentsChanged:(NSArray *)newVisibleComponents{
    if (self.currentVisibleComponents.count != newVisibleComponents.count) return YES;
    
    BOOL changed = [newVisibleComponents bk_any:^BOOL(BTCComponent *component) {
        if ([self.currentVisibleComponents containsObject:component]){
            BTCComponent *currentComponent = [self.currentVisibleComponents objectAtIndex:
                               [self.currentVisibleComponents indexOfObject:component]];
            if (currentComponent.view && component.view) {
                return ![currentComponent.view isEqual:component.view];
            }
        }
        return YES;
    }];
    
    return changed;
}

#pragma clang diagnostic ignored "-Wundeclared-selector"

- (void)updateVisibleComponents:(NSArray *)updatedComponents{
    [updatedComponents bk_each:^(BTCComponent *newComponent) {
        if([self.currentVisibleComponents containsObject:newComponent]){
            BTCComponent *currentComponent = [self.currentVisibleComponents objectAtIndex:[self.currentVisibleComponents indexOfObject:newComponent]];
            UIView *currentView = currentComponent.view;
            if (currentView){
                if ([currentComponent.view respondsToSelector:@selector(updateWithComponent:)]){
                    [currentComponent.view performSelector:@selector(updateWithComponent:) withObject:newComponent];
                }
            }
        }
    }];

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
