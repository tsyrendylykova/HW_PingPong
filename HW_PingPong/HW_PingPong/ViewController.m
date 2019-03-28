//
//  ViewController.m
//  HW_PingPong
//
//  Created by Цырендылыкова Эржена on 27/03/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *ball;
@property (nonatomic, strong) UIView *computerPlatform;
@property (nonatomic, strong) UIView *myPlatform;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
    //[self movementBall];
//    [UIView animateWithDuration:2.0 animations:^{
//        [self moveBall];
//    } completion:^(BOOL finished) {
//        [self movementBall];
//    }];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(movementBall) userInfo:nil repeats:YES];

    //[self moveBall];
}

-(void)prepareUI {
    self.ball = [[UIView alloc] initWithFrame:CGRectMake(200, 100, 60, 60)];
    self.ball.backgroundColor = [UIColor blackColor];
    
    self.computerPlatform = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 3, 0, self.view.frame.size.width / 3, 30)];
    self.computerPlatform.backgroundColor = [UIColor blueColor];
    
    self.myPlatform = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 3, self.view.frame.size.height - 30, self.view.frame.size.width / 3, 30)];
    self.myPlatform.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:self.ball];
    [self.view addSubview:self.computerPlatform];
    [self.view addSubview:self.myPlatform];
}

-(void)moveBall {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 1.0;
    animation.repeatCount = 2;
    NSArray *pathArray = @[@(CGPointMake(100.0, 100.0)), @(CGPointMake(50.0, 10.0))];
    animation.values = pathArray;
    animation.autoreverses = YES;
    
    [self.ball.layer addAnimation:animation forKey:@"ballAnimation"];
}
CGFloat dx = 0.1;
CGFloat dy = 0.1;

-(void)movementBall {
    
    //правая стенка или левая
    if (self.ball.center.x + self.ball.frame.size.width / 2 > self.view.frame.size.width || self.ball.frame.origin.x < 0) {
        dx *= -1;
    }
    //верхняя стенка или нижняя
    if (self.ball.center.y + self.ball.frame.size.height / 2 > self.view.frame.size.height || self.ball.frame.origin.y < 0) {
        dy *= -1;
    }
    self.ball.center = CGPointMake(self.ball.center.x + dx, self.ball.center.y + dy);
}


@end
