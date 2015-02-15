//
//  BTCServerCommunicator.m
//  Pods
//
//  Created by Benny Weingarten-Gabbay on 8/25/14.
//
//

#import "BTCServerCommunicator.h"

#import <BlocksKit.h>
#import "BTCConstants.h"
#import "SRWebSocket.h"
#import "BTCComponent.h"

@interface BTCServerCommunicator () <SRWebSocketDelegate>

@property (nonatomic) SRWebSocket *webSocket;
// For some reason the socket gets killed if no communication is being done every X seconds
@property (nonatomic) NSTimer *keepAlive;

@end

#define MESSAGE_TYPE_KEY @"type"
#define MESSAGE_DATA_KEY @"data"

#define MESSAGE_TYPE_CONTENT @"ui"


#define KEEP_ALIVE_INTERVAL 10

@implementation BTCServerCommunicator

- (void)connect{
    self.webSocket.delegate = nil;
    self.webSocket = nil;
    
    SRWebSocket *newWebSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:BTC_WEBSOCKET_URL]];
    newWebSocket.delegate = self;
    
    [newWebSocket open];
}

- (void)sendComponents:(NSArray *)componentsArray{
    NSData *componentsJSON = [NSJSONSerialization dataWithJSONObject:@{MESSAGE_TYPE_KEY:MESSAGE_TYPE_CONTENT, MESSAGE_DATA_KEY: [self componentsJSON:componentsArray]} options:kNilOptions error:nil];

    [self.webSocket send:componentsJSON];
}

#pragma mark - helpers
- (NSArray *)componentsJSON:(NSArray *)componenetsArray{
    return [componenetsArray bk_map:^id(BTCComponent *component) {
        return @{@"key": component.key, ATTRIBUTES_KEY: component.attributes};
    }];
}

- (void)startKeepAlive{
    __weak __typeof(self)weakSelf = self;
    self.keepAlive = [NSTimer bk_scheduledTimerWithTimeInterval:KEEP_ALIVE_INTERVAL block:^(NSTimer *timer) {
        [weakSelf.webSocket send:[NSJSONSerialization dataWithJSONObject:@{@"type":@"ping"} options:kNilOptions error:nil]];
    } repeats:YES];
}

- (void)serverDisconnectedActions{
    [self.keepAlive invalidate];
    self.keepAlive = nil;
    [self.delegate didDisconnectFromServer];
}

#pragma mark - RocektSocketDelegate
- (void)webSocketDidOpen:(SRWebSocket *)newWebSocket {
    self.webSocket = newWebSocket;
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    NSData *handshake = [NSJSONSerialization dataWithJSONObject:@{
                                                                  @"type":@"register",
                                                                  @"data": @{
                                                                          @"app" : @"nativeApp",
                                                                          @"appName" : bundleIdentifier
                                                                          }
                                                                  }
                                                        options:kNilOptions error:nil];
    [self.webSocket send:handshake];
    [self startKeepAlive];
    [self.delegate didConnectToServer];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    [self serverDisconnectedActions];
    [self performSelector:@selector(connect) withObject:nil afterDelay:5];
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code
           reason:(NSString *)reason wasClean:(BOOL)wasClean {
    [self serverDisconnectedActions];
    [self.delegate didDisconnectFromServer];
    [self connect];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSData *jsonData = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *rawComponents = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    NSArray *components = [rawComponents bk_map:^id(NSDictionary *componentDict) {
        NSString *key = [componentDict objectForKey:@"key"];
        return [[BTCComponent alloc] initWithKey:key attributes:[componentDict objectForKey:ATTRIBUTES_KEY] /*comparator:NULL*/];
    }];
    [self.delegate receivedBetterContent:components];
}

@end
