//
//  PingPongView.m
//  MVPPingPong
//
//  Created by Цырендылыкова Эржена on 08/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "PingPongView.h"

@implementation PingPongView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.presenter showUI];
    [self.presenter startNewGame];
}

-(void)prepareTableUI {
    self.view.backgroundColor = [UIColor colorWithRed:122/255.f green:180/255.f blue:223/255.f alpha:0.8];
    
    self.navigationItem.title = @"Ping Pong";
    
    self.horizontalBorderView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height / 2, self.view.frame.size.width, 5)];
    self.horizontalBorderView.backgroundColor = [UIColor whiteColor];
    
    self.verticalBorderView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 5/2, 0, 5, self.view.frame.size.height)];
    self.verticalBorderView.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Stop" style:UIBarButtonItemStyleDone target:self action:@selector(showSettingsView)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.settingsView = [[[SettingsView alloc] init] prepareSettingsView];
    self.settingsView.presenter = self.presenter;
    
    self.ball = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2, 150, 30, 30)];
    self.ball.backgroundColor = [UIColor whiteColor];
    self.ball.layer.cornerRadius = self.ball.frame.size.height / 2;
    self.ball.layer.masksToBounds = YES;
    
    self.computerPlatform = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - self.view.frame.size.width / 3.2) / 2, 89, self.view.frame.size.width / 3.2, 10)];
    self.computerPlatform.backgroundColor = [UIColor blueColor];
    
    self.myPlatform = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - self.view.frame.size.width / 3.2) / 2, self.view.frame.size.height - 10, self.view.frame.size.width / 3.2, 10)];
    self.myPlatform.backgroundColor = [UIColor blueColor];
    
    self.compScore = [[UILabel alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height / 2 - 50, 50, 50)];
    self.compScore.textColor = [UIColor whiteColor];
    self.compScore.font = [UIFont systemFontOfSize:40.0 weight:UIFontWeightLight];
    
    self.myScore = [[UILabel alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height / 2 + 5, 50, 50)];
    self.myScore.textColor = [UIColor whiteColor];
    self.myScore.font = [UIFont systemFontOfSize:40.0 weight:UIFontWeightLight];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Ping Pong" message:@"Start game" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.presenter startTimer];
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
    
    [self.view addSubview:self.horizontalBorderView];
    [self.view addSubview:self.verticalBorderView];
    [self.view addSubview:self.ball];
    [self.view addSubview:self.computerPlatform];
    [self.view addSubview:self.myPlatform];
    [self.view addSubview:self.compScore];
    [self.view addSubview:self.myScore];
}

-(void)resetUI {
    self.ball.frame = CGRectMake(self.view.frame.size.width / 2, 150, 30, 30);
    self.computerPlatform.center = CGPointMake(self.view.center.x, self.computerPlatform.center.y);
}

-(void)showGameWinner:(NSString *)text {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Ping Pong" message:text preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.presenter startNewGame];
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)showSettingsView {
    [self.view addSubview:self.settingsView];
    [self.presenter pauseGame];
    CATransition *transtion=[CATransition animation];
    [transtion setType:kCATransitionPush];
    [transtion setSubtype:kCATransitionFromTop];
    [transtion setDuration:0.5];
    transtion.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.view.layer addAnimation:transtion forKey:kCATransition];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Play" style:UIBarButtonItemStyleDone target:self action:@selector(hideSettingsView)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

-(void)hideSettingsView {
    CATransition *transition = [CATransition animation];
    transition.duration = 1.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    transition.type = kCATransitionFade;
    [self.view.layer addAnimation:transition forKey:kCATransition];
    [self.presenter startTimer];
    [self.settingsView removeFromSuperview];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Stop" style:UIBarButtonItemStyleDone target:self action:@selector(showSettingsView)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint point = [touch locationInView:self.view];
        if (point.y > self.view.frame.size.height / 2) {
            self.myPlatform.center = CGPointMake(point.x, self.view.frame.size.height - self.myPlatform.frame.size.height / 2);
        }
    }
}

-(void)setScoresWithCompScore: (NSInteger)compScore myScore:(NSInteger)myScore {
    self.compScore.text = [NSString stringWithFormat:@"%ld", (long)compScore];
    self.myScore.text = [NSString stringWithFormat:@"%ld", (long)myScore];
}

-(void)setComputerPlatformCenter {
    self.computerPlatform.center = CGPointMake(self.ball.center.x, self.computerPlatform.center.y);
}

-(void)setBallCenterWithDx: (CGFloat)dx dy:(CGFloat)dy {
    self.ball.center = CGPointMake(self.ball.center.x + dx, self.ball.center.y + dy);
}

-(BOOL)isBallTouchRightOrLeftSide {
    if (self.ball.center.x + self.ball.frame.size.width / 2 > self.view.frame.size.width || self.ball.frame.origin.x < 0) {
        return YES;
    }
    return NO;
}

-(BOOL)isBallTouchMyPlatform {
    if (self.ball.frame.origin.y + self.ball.frame.size.height >= self.myPlatform.frame.origin.y &&
        self.ball.frame.origin.x >= self.myPlatform.frame.origin.x &&
        self.ball.frame.origin.x + self.ball.frame.size.width <= self.myPlatform.frame.origin.x + self.myPlatform.frame.size.width) {
        return YES;
    }
    return NO;
}

-(BOOL)isBallTouchComputerPlatform {
    if (self.ball.frame.origin.y <= 89 + self.computerPlatform.frame.size.height &&
        self.ball.frame.origin.x >= self.computerPlatform.frame.origin.x &&
        self.ball.frame.origin.x <= self.computerPlatform.frame.origin.x + self.computerPlatform.frame.size.width) {
        return YES;
    }
    return NO;
}

-(BOOL)isBallTouchBottomSide {
    if (self.ball.center.y + self.ball.frame.size.height / 2 > self.view.frame.size.height) {
        return YES;
    }
    return NO;
}

-(BOOL)isBallTouchTopSide {
    if (self.ball.frame.origin.y < 89) {
        return YES;
    }
    return NO;
}

-(void)incrementCompScore: (NSInteger)newScore {
    self.compScore.text = [NSString stringWithFormat:@"%ld", newScore];
}

-(void)incrementMyScore: (NSInteger)newScore {
    self.myScore.text = [NSString stringWithFormat:@"%ld", newScore];
}

-(void)clearUIForNewGame {
    [self.ball removeFromSuperview];
    [self.computerPlatform removeFromSuperview];
    [self.myPlatform removeFromSuperview];
    [self.myScore removeFromSuperview];
    [self.compScore removeFromSuperview];
}

@end
