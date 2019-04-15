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

+ (UIViewController *)assemblyPingPong {
    GamePingPong *game = [[GamePingPong alloc] init];
    PingPongView *view = [[PingPongView alloc] init];
    PresenterPingPong *presenter = [[PresenterPingPong alloc] initWithView:view model:game];
    view.presenter = presenter;
    return view;
}

@end
