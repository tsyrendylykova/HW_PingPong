//
//  PresenterPingPong.m
//  MVPPingPong
//
//  Created by Цырендылыкова Эржена on 08/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "PresenterPingPong.h"

@implementation PresenterPingPong

-(id)initWithView: (PingPongView *)view withModel:(GamePingPong *)model {
    self = [super init];
    if (self) {
        self.game = model;
        self.view = view;
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
    self.view.compScore.text = @"0";
    self.view.myScore.text = @"0";
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Ping Pong" message:@"Start game" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self startTimer];
    }];
    [alertController addAction:action];
    [self.view presentViewController:alertController animated:YES completion:nil];
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
    if (self.isBallTouchMyPlatformAtLeftAngle) {
        self.game.dy *= -1;
        self.game.dx *= -1;
    }
    if (self.isBallTouchMyPlatformAtRightAngle) {
        self.game.dy *= -1;
        self.game.dx *= -1;
    }
    else if (self.isBallTouchMyPlatform) {
        self.game.dy *= -1;
    }
    else if (self.isBallTouchComputerPlatform) {
        self.game.dy *= -1;
    }
    else if (self.isBallTouchRightOrLeftSide) {
        self.game.dx *= -1;
    }
    else if (self.isBallTouchTopOrBottomSide) {
        self.game.dy *= -1;
    }
    self.view.ball.center = CGPointMake(self.view.ball.center.x + self.game.dx, self.view.ball.center.y + self.game.dy);
}

-(void)moveComputerPlatformAI {
    CGFloat pointX = self.view.ball.center.x;
    self.view.computerPlatform.center = CGPointMake(pointX, self.view.computerPlatform.center.y);
}

-(Boolean)isBallTouchRightOrLeftSide {
    if (self.view.ball.center.x + self.view.ball.frame.size.width / 2 > self.view.view.frame.size.width || self.view.ball.frame.origin.x < 0) {
        return YES;
    }
    return NO;
}

-(Boolean)isBallTouchTopOrBottomSide {
    if (self.view.ball.center.y + self.view.ball.frame.size.height / 2 >= self.view.view.frame.size.height) {
        self.view.compScore.text = [NSString stringWithFormat:@"%ld", (long)++self.game.computerScore];
        if ([self.game isGameOver]) {
            [self pauseGame];
            [self showGameWinner:@"Failure!"];
        } else {
            [self reset];
        }
    } else if (self.view.ball.frame.origin.y < 89) {
        self.view.myScore.text = [NSString stringWithFormat:@"%ld", (long)++self.game.myScore];
        if ([self.game isGameOver]) {
            [self pauseGame];
            [self showGameWinner:@"You`re a winner!"];
        } else {
            [self reset];
        }
    }
    return NO;
}

-(void)showGameWinner:(NSString *)text {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Ping Pong" message:text preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self startNewGame];
    }];
    [alertController addAction:action];
    [self.view presentViewController:alertController animated:YES completion:nil];
}

-(void)reset {
    self.view.ball.frame = CGRectMake(self.view.view.frame.size.width / 2, 125 + self.view.computerPlatform.frame.size.height, 30, 30);
    if ((arc4random() % 2) == 0) {
        self.game.dx *= -1;
    } else {
        self.game.dx *= 1;
    }
}

-(void)startNewGameButton {
    [self hideSettingsView];
    [self clearUIForNewGame];
    [self.view prepareTableUI];
    [self.view prepareSettingsView];
    [self startNewGame];
}

-(void)clearUIForNewGame {
    [self.view.ball removeFromSuperview];
    [self.view.computerPlatform removeFromSuperview];
    [self.view.myPlatform removeFromSuperview];
    [self.view.myScore removeFromSuperview];
    [self.view.compScore removeFromSuperview];
}

-(void)showSettingsView {
    [self pauseGame];
    [self.view.view addSubview:self.view.settingsView];
    
    CATransition *transtion=[CATransition animation];
    [transtion setType:kCATransitionPush];
    [transtion setSubtype:kCATransitionFromTop];
    [transtion setDuration:0.5];
    transtion.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.view.view.layer addAnimation:transtion forKey:kCATransition];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Play" style:UIBarButtonItemStyleDone target:self action:@selector(hideSettingsView)];
    self.view.navigationItem.rightBarButtonItem = rightBarButton;
}

-(void)hideSettingsView {
    
    [self.view.settingsView removeFromSuperview];
    CATransition *transition = [CATransition animation];
    transition.duration = 1.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    transition.type = kCATransitionFade;
    [self.view.view.layer addAnimation:transition forKey:kCATransition];
    
    [self startTimer];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Stop" style:UIBarButtonItemStyleDone target:self action:@selector(showSettingsView)];
    self.view.navigationItem.rightBarButtonItem = rightBarButton;
}

-(void)selectLightDifficulty {
    [self.game selectLightDiffuculty];
    [self hideSettingsView];
}

-(void)selectMediumDifficulty {
    [self.game selectMediumDiffuculty];
    [self hideSettingsView];
}

-(void)selectHardDifficulty {
    [self.game selectHardDiffuculty];
    [self hideSettingsView];
}

-(Boolean)isBallTouchMyPlatform {
    if (self.view.ball.frame.origin.y + self.view.ball.frame.size.height >= self.view.myPlatform.frame.origin.y &&
        self.view.ball.frame.origin.x >= self.view.myPlatform.frame.origin.x &&
        self.view.ball.frame.origin.x + self.view.ball.frame.size.width <= self.view.myPlatform.frame.origin.x + self.view.myPlatform.frame.size.width) {
        return YES;
    }
    return NO;
}

-(Boolean)isBallTouchMyPlatformAtLeftAngle {
    if (self.view.ball.frame.origin.y + self.view.ball.frame.size.height >= self.view.myPlatform.frame.origin.y &&
        self.view.ball.frame.origin.y + self.view.ball.frame.size.height <= self.view.myPlatform.frame.origin.y  + 10 &&
        self.view.ball.center.x + self.view.ball.frame.size.width / 3 >= self.view.myPlatform.frame.origin.x &&
        self.view.ball.center.x < self.view.myPlatform.frame.origin.x) {
        return YES;
    }
    return NO;
}

-(Boolean)isBallTouchMyPlatformAtRightAngle {
    if (self.view.ball.frame.origin.y + self.view.ball.frame.size.height >= self.view.myPlatform.frame.origin.y &&
        self.view.ball.frame.origin.y + self.view.ball.frame.size.height <= self.view.myPlatform.frame.origin.y + 10 &&
        self.view.ball.center.x - self.view.ball.frame.size.width / 3 <= self.view.myPlatform.frame.origin.x + self.view.myPlatform.frame.size.width &&
        self.view.ball.center.x > self.view.myPlatform.frame.origin.x + self.view.myPlatform.frame.size.width) {
        return YES;
    }
    return NO;
}

-(Boolean)isBallTouchComputerPlatform {
    if (self.view.ball.frame.origin.y <= 89 + self.view.computerPlatform.frame.size.height &&
        self.view.ball.frame.origin.x >= self.view.computerPlatform.frame.origin.x &&
        self.view.ball.frame.origin.x <= self.view.computerPlatform.frame.origin.x + self.view.computerPlatform.frame.size.width) {
        return YES;
    }
    return NO;
}

-(void)setPointMyPlatform: (CGPoint)point {
    if (point.y > self.view.view.frame.size.height / 2) {
        self.view.myPlatform.center = CGPointMake(point.x, self.view.view.frame.size.height - self.view.myPlatform.frame.size.height / 2);
    }
}


@end
