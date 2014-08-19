//
//  BTCContentController.m
//  Pods
//
//  Created by Benny Weingarten-Gabbay on 7/24/14.
//
//

#import "BTCContentController.h"
#import "BTCServerCoordinator.h"

@implementation BTCContentController

+ (void)load {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(startEngine)
                                                 name:UIApplicationDidFinishLaunchingNotification
                                              object:nil];
}

+ (void)startEngine{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidFinishLaunchingNotification object:nil];
    [[BTCServerCoordinator sharedInstance] start];
}



@end
