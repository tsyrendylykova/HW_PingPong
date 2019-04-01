//
//  ViewController.m
//  HW_PingPong
//
//  Created by Цырендылыкова Эржена on 27/03/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "ViewController.h"
#import "HWSettingsView.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *ball;
@property (nonatomic, strong) UIView *computerPlatform;
@property (nonatomic, strong) UIView *myPlatform;
@property (nonatomic, strong) NSTimer *timerPlatform;
@property (nonatomic, strong) NSTimer *timerBall;
@property (nonatomic, strong) HWSettingsView *settingsView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Ping Pong";
    
    [self prepareUI];
    [self startTimer];
}

-(void)prepareUI {
    self.ball = [[UIView alloc] initWithFrame:CGRectMake(200, 100, 60, 60)];
    self.ball.backgroundColor = [UIColor blackColor];
    self.ball.layer.cornerRadius = self.ball.frame.size.height / 2;
    self.ball.layer.masksToBounds = YES;
    
    self.computerPlatform = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 3, 64, self.view.frame.size.width / 3, 30)];
    self.computerPlatform.backgroundColor = [UIColor blueColor];
    
    self.myPlatform = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 3, self.view.frame.size.height - 30, self.view.frame.size.width / 3, 30)];
    self.myPlatform.backgroundColor = [UIColor blueColor];
    
    self.settingsView = [HWSettingsView settingsView];
    [self.view addSubview:self.settingsView];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Stop" style:UIBarButtonItemStyleDone target:self action:@selector(showSettingsView)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    [self.view addSubview:self.ball];
    [self.view addSubview:self.computerPlatform];
    [self.view addSubview:self.myPlatform];
}

-(void)startTimer {
    self.timerPlatform = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(movementBall) userInfo:nil repeats:YES];
    self.timerBall = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(platformFollowsBall) userInfo:nil repeats:YES];
}

-(void)stopTimer {
    if ([self.timerPlatform isValid]) {
        [self.timerPlatform invalidate];
    }
    self.timerPlatform = nil;
    if ([self.timerBall isValid]) {
        [self.timerBall invalidate];
    }
    self.timerBall = nil;
}

-(void)showSettingsView {
    [self stopTimer];
    [self.settingsView showSettingsView];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Start" style:UIBarButtonItemStyleDone target:self action:@selector(hideSettingsView)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

-(void)hideSettingsView {
    [self.settingsView hideSettingsView];
    [self startTimer];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Stop" style:UIBarButtonItemStyleDone target:self action:@selector(showSettingsView)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}



CGFloat dx = 0.1;
CGFloat dy = 0.1;

-(void)movementBall {
    if (self.isBallTouchMyPlatform) {
        dy *= -1;
    }
    else if (self.isBallTouchComputerPlatform) {
        dy *= -1;
    }
    else if (self.isBallTouchRightOrLeftSide) {
        dx *= -1;
    }
    else if (self.isBallTouchTopOrBottomSide) {
        dy *= -1;
    }
    self.ball.center = CGPointMake(self.ball.center.x + dx, self.ball.center.y + dy);
}

-(void)platformFollowsBall {
    CGFloat pointX = self.ball.center.x;
    self.computerPlatform.center = CGPointMake(pointX, self.computerPlatform.center.y);
    self.myPlatform.center = CGPointMake(pointX, self.myPlatform.center.y);
}

-(Boolean)isBallTouchRightOrLeftSide {
    if (self.ball.center.x + self.ball.frame.size.width / 2 > self.view.frame.size.width || self.ball.frame.origin.x < 0) {
        return YES;
    }
    return NO;
}

-(Boolean)isBallTouchTopOrBottomSide {
    if (self.ball.center.y + self.ball.frame.size.height / 2 > self.view.frame.size.height || self.ball.frame.origin.y < 64 + self.computerPlatform.frame.size.height) {
        return YES;
    }
    return NO;
}

-(Boolean)isBallTouchMyPlatform {
    if (self.ball.frame.origin.y + self.ball.frame.size.height >= self.myPlatform.frame.origin.y &&
        self.ball.frame.origin.x >= self.myPlatform.frame.origin.x && self.ball.frame.origin.x <= self.myPlatform.frame.origin.x + self.myPlatform.frame.size.width) {
        return YES;
    }
    return NO;
}

-(Boolean)isBallTouchComputerPlatform {
    if (self.ball.frame.origin.y <= self.computerPlatform.frame.size.height &&
        self.ball.frame.origin.x >= self.computerPlatform.frame.origin.x &&
        self.ball.frame.origin.x <= self.computerPlatform.frame.origin.x + self.computerPlatform.frame.size.width) {
        return YES;
    }
    return NO;
}


@end
