//
//  PresenterPingPong.h
//  MVPPingPong
//
//  Created by Цырендылыкова Эржена on 08/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GamePingPong.h"
#import "PingPongView.h"
#import "PingPongProtocols.h"

@class PingPongView;

@interface PresenterPingPong : NSObject <PingPongPresenterProtocol>

@property (nonatomic, strong) GamePingPong *game;
@property (nonatomic, strong) PingPongView *view;

-(instancetype)initWithView: (PingPongView *)view model:(GamePingPong *)model;

@end
