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

NS_ASSUME_NONNULL_BEGIN

@class PingPongView;

@interface PresenterPingPong : NSObject

@property (nonatomic, strong) GamePingPong *game;
@property (nonatomic, strong) PingPongView *view;
@property (nonatomic, strong) NSTimer *timerPlatform;
@property (nonatomic, strong) NSTimer *timerBall;

-(instancetype)initWithView: (PingPongView *)view model:(GamePingPong *)model;
-(void)showUI;
-(void)startNewGame;
-(void)startTimer;


//для протокола
-(void)pauseGame;
-(void)selectDifficulty: (CGFloat)difficulty;


@end

NS_ASSUME_NONNULL_END
