//
//  PingPongAssembly.m
//  MVPPingPong
//
//  Created by Цырендылыкова Эржена on 15/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "PingPongAssembly.h"
#import "GamePingPong.h"
#import "PingPongView.h"
#import "PresenterPingPong.h"

@implementation PingPongAssembly

- (UINavigationController *)assemblyPingPong {
    GamePingPong *game = [[GamePingPong alloc] initGame];
    PingPongView *view = [[PingPongView alloc] init];
    PresenterPingPong *presenter = [[PresenterPingPong alloc] initWithView:view model:game];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:view];
    view.presenter = presenter;
    return navigationController;
}

@end
