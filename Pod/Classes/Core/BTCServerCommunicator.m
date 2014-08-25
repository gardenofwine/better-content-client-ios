//
//  BTCServerCommunicator.m
//  Pods
//
//  Created by Benny Weingarten-Gabbay on 8/25/14.
//
//

#import "BTCServerCommunicator.h"

#import <BlocksKit.h>
#import "SRWebSocket.h"
#import "BTCComponent.h"

#define WEBSOCKET_URL @"ws://localhost"
#define WEBSOCKET_PORT @":5000"
//#define WEBSOCKET_URL @"http://bettercontent.herokuapp.com/"
//#define WEBSOCKET_PORT @""

@interface BTCServerCommunicator () <SRWebSocketDelegate>

@property (nonatomic) SRWebSocket *webSocket;

@end

@implementation BTCServerCommunicator

- (void)connect{
    self.webSocket.delegate = nil;
    self.webSocket = nil;
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", WEBSOCKET_URL, WEBSOCKET_PORT];
    SRWebSocket *newWebSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:urlString]];
    newWebSocket.delegate = self;
    
    [newWebSocket open];
}

- (void)sendComponents:(NSArray *)componentsArray{
    NSData *componentsJSON = [NSJSONSerialization dataWithJSONObject:@{@"type":@"labelMap", @"data": [self componentsJSON:componentsArray]} options:kNilOptions error:nil];

    [self.webSocket send:componentsJSON];
}

#pragma mark - helpers
- (NSArray *)componentsJSON:(NSArray *)componenetsArray{
    // TODO only send the labels that are not null
    return [componenetsArray bk_map:^id(BTCComponent *component) {
        return @{@"key": component.key, @"attributes": component.attributes};
    }];
}


#pragma mark - RocektSocketDelegate
- (void)webSocketDidOpen:(SRWebSocket *)newWebSocket {
    NSLog(@"** webSocketDidOpen");
    self.webSocket = newWebSocket;
    NSData *handshake = [NSJSONSerialization dataWithJSONObject:@{@"type":@"register", @"data": @"nativeApp"} options:kNilOptions error:nil];
    [self.webSocket send:handshake];
    [self.delegate didConnectToServer];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    NSLog(@"** webSocket:didFailWithError %@", error);
   [self performSelector:@selector(connect) withObject:nil afterDelay:5];
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code
           reason:(NSString *)reason wasClean:(BOOL)wasClean {
    NSLog(@"** webSocket:didCloseWithCode");
    [self.delegate didDisconnectFromServer];
    [self connect];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSLog(@"** string received %@", message);
    NSData *jsonData = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    [self.delegate receivedBetterContent:json];
    NSLog(@"** json received %@", json);
}


@end
