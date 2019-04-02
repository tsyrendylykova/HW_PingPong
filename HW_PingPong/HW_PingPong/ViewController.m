//
//  ViewController.m
//  HW_PingPong
//
//  Created by Цырендылыкова Эржена on 27/03/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "ViewController.h"
#import "HWSettingsView.h"
#import "HWPingPongGame.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *ball;
@property (nonatomic, strong) UIView *computerPlatform;
@property (nonatomic, strong) UIView *myPlatform;
@property (nonatomic, strong) UIView *horizontalBorderView;
@property (nonatomic, strong) UIView *verticalBorderView;
@property (nonatomic, strong) NSTimer *timerPlatform;
@property (nonatomic, strong) NSTimer *timerBall;
@property (nonatomic, strong) HWSettingsView *settingsView;
@property (nonatomic, strong) UITouch *touch;
@property (nonatomic, strong) HWPingPongGame *game;
@property (nonatomic, strong) UILabel *compScore;
@property (nonatomic, strong) UILabel *myScore;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Ping Pong";
    
    [self newGame];
    [self prepareTableUI];
    [self prepareUI];
    [self prepareScores];
}

-(void)prepareTableUI {
    self.view.backgroundColor = [UIColor colorWithRed:122/255.f green:180/255.f blue:223/255.f alpha:0.8];
    
    self.horizontalBorderView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height / 2, self.view.frame.size.width, 5)];
    self.horizontalBorderView.backgroundColor = [UIColor whiteColor];
    
    self.verticalBorderView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2, 0, 5, self.view.frame.size.height)];
    self.verticalBorderView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.horizontalBorderView];
    [self.view addSubview:self.verticalBorderView];
}

-(void)prepareUI {
    self.ball = [[UIView alloc] initWithFrame:CGRectMake(200, 150, 30, 30)];
    self.ball.backgroundColor = [UIColor whiteColor];
    self.ball.layer.cornerRadius = self.ball.frame.size.height / 2;
    self.ball.layer.masksToBounds = YES;
    
    self.computerPlatform = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 3, 89, self.view.frame.size.width / 3, 30)];
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

-(void)prepareScores {
    _compScore = [[UILabel alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height / 2 - 50, 50, 50)];
    _compScore.textColor = [UIColor whiteColor];
    _compScore.text = [NSString stringWithFormat:@"%ld", (long)self.game.computerScore];
    _compScore.font = [UIFont systemFontOfSize:40.0 weight:UIFontWeightLight];
    
    [self.view addSubview:_compScore];
    
    _myScore = [[UILabel alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height / 2 + 5, 50, 50)];
    _myScore.textColor = [UIColor whiteColor];
    _myScore.text = [NSString stringWithFormat:@"%ld", (long)self.game.myScore];
    _myScore.font = [UIFont systemFontOfSize:40.0 weight:UIFontWeightLight];
    
    [self.view addSubview:_myScore];
}

-(void)newGame {
    self.game = [HWPingPongGame new];
    self.game.computerScore = 0;
    self.game.myScore = 0;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Ping Pong" message:@"Start game" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self startTimer];
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)startTimer {
    self.timerPlatform = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(movementBall) userInfo:nil repeats:YES];
    self.timerBall = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(platformFollowsBall) userInfo:nil repeats:YES];
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

-(void)hideAllViews {
    [self.ball setHidden:YES];
    [self.computerPlatform setHidden:YES];
    [self.myPlatform setHidden:YES];
    [self.compScore setHidden:YES];
    [self.myScore setHidden:YES];
}

-(void)unhideAllViews {
    [self.ball setHidden: NO];
    [self.computerPlatform setHidden:NO];
    [self.myPlatform setHidden:NO];
    [self.compScore setHidden:NO];
    [self.myScore setHidden:NO];
}

-(void)showSettingsView {
    [self pauseGame];
    [self.settingsView showSettingsView];
    [self hideAllViews];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Start" style:UIBarButtonItemStyleDone target:self action:@selector(hideSettingsView)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

-(void)hideSettingsView {
    [self unhideAllViews];
    [self.settingsView hideSettingsView];
    [self startTimer];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Stop" style:UIBarButtonItemStyleDone target:self action:@selector(showSettingsView)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint point = [touch locationInView:self.view];
        if (_touch == nil && point.y > self.view.frame.size.height / 2) {
            _touch = touch;
            _myPlatform.center = CGPointMake(point.x, self.view.frame.size.height - self.myPlatform.frame.size.height / 2);
        }
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint point = [touch locationInView:self.view];
        if (point.y > self.view.frame.size.height / 2) {
            _myPlatform.center = CGPointMake(point.x, self.view.frame.size.height - self.myPlatform.frame.size.height / 2);
        }
    }
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
}

-(Boolean)isBallTouchRightOrLeftSide {
    if (self.ball.center.x + self.ball.frame.size.width / 2 > self.view.frame.size.width || self.ball.frame.origin.x < 0) {
        return YES;
    }
    return NO;
}

-(Boolean)isBallTouchTopOrBottomSide {
    if (self.ball.center.y + self.ball.frame.size.height / 2 > self.view.frame.size.height || self.ball.frame.origin.y < 89 + self.computerPlatform.frame.size.height) {
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
