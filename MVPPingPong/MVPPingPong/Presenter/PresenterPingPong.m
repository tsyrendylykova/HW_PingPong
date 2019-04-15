//
//  PresenterPingPong.m
//  MVPPingPong
//
//  Created by Цырендылыкова Эржена on 08/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "PresenterPingPong.h"

@implementation PresenterPingPong

-(instancetype)initWithView: (PingPongView *)view model:(GamePingPong *)model {
    self = [super init];
    if (self) {
        _game = model;
        _view = view;
    }
    
    return self;
}

-(void)showUI {
    [self.view prepareTableUI];
    [self.view prepareSettingsView];
}

-(void)startNewGame {
    [self pauseGame];
    self.game.dx = 0.2;
    self.game.dy = 0.2;
    self.game.computerScore = 0;
    self.game.myScore = 0;
    
    if (self.view.settingsView.isHidden) {
        [self.view hideSettingsView];
    }
    [self.view clearUIForNewGame];
    [self.view prepareTableUI];
    [self.view prepareSettingsView];
    [self.view setScoresWithCompScore:self.game.computerScore myScore:self.game.myScore];
}

-(void)startTimer {
    self.timerPlatform = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(movementBall) userInfo:nil repeats:YES];
    self.timerBall = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(moveComputerPlatformAI) userInfo:nil repeats:YES];
}

-(void)pauseGame {
    if ([self.timerPlatform isValid]) {
        [self.timerPlatform invalidate];
    }
    self.timerPlatform = nil;
    if ([self.timerBall isValid]) {
        [self.timerBall invalidate];
    }
    self.timerBall = nil;
}

-(void)movementBall {
    if (self.view.isBallTouchMyPlatform) {
        self.game.dy *= -1;
    }
    else if (self.view.isBallTouchComputerPlatform) {
        self.game.dy *= -1;
    }
    else if (self.view.isBallTouchRightOrLeftSide) {
        self.game.dx *= -1;
    }
    else if (self.isBallTouchBottomSide) {
        self.game.dy *= -1;
    }
    else if (self.isBallTouchTopSide) {
        self.game.dy *= -1;
    }
    
    [self.view setBallCenterWithDx: (CGFloat)self.game.dx dy:(CGFloat)self.game.dy];
}

-(void)moveComputerPlatformAI {
    [self.view setComputerPlatformCenter];
}

-(Boolean)isBallTouchBottomSide {
    if (self.view.ball.center.y + self.view.ball.frame.size.height / 2 > self.view.view.frame.size.height) {
        self.view.compScore.text = [NSString stringWithFormat:@"%ld", (long)++self.game.computerScore];
        if ([self.game isGameOver]) {
            [self pauseGame];
            [self.view showGameWinner:@"Failure!"];
            NSString *scoreString = [NSString stringWithFormat:@"%ld", self.game.computerScore];
            [[NSUserDefaults standardUserDefaults] setObject:scoreString forKey:@"scoreKey"];
        }
        [self reset];
    }
    return NO;
}

-(Boolean)isBallTouchTopSide {
    if (self.view.ball.frame.origin.y < 89) {
        self.view.myScore.text = [NSString stringWithFormat:@"%ld", (long)++self.game.myScore];
        if ([self.game isGameOver]) {
            [self pauseGame];
            [self.view showGameWinner:@"You`re a winner!"];
        }
        [self reset];
    }
    return NO;
}

-(void)reset {
    self.view.ball.frame = CGRectMake(200, 150, 30, 30);
    self.view.computerPlatform.center = CGPointMake(self.view.ball.center.x, self.view.computerPlatform.center.y);
    if ((arc4random() % 2) == 0) {
        self.game.dx *= -1;
    } else {
        self.game.dx *= 1;
    }
}

-(void)selectDifficulty: (CGFloat)difficulty {
    [self.game selectDifficulty: difficulty];
    [self.view hideSettingsView];
}

@end
