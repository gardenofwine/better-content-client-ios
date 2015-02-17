//
//  BTCServerCommunicator.h
//  Pods
//
//  Created by Benny Weingarten-Gabbay on 8/25/14.
//
//

#import <Foundation/Foundation.h>

@protocol BTCServerCommunicatorDelegate <NSObject>

- (void)receivedBetterContent:(NSArray *)componentsArray;
- (void)didConnectToServer;
- (void)didDisconnectFromServer;

@end

@interface BTCServerCommunicator : NSObject

@property (nonatomic) id<BTCServerCommunicatorDelegate> delegate;

- (void)connect;
- (void)sendViews:(NSArray *)serializedViews;

@end
