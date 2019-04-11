//
//  PingPongView.m
//  MVPPingPong
//
//  Created by Цырендылыкова Эржена on 08/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "PingPongView.h"

@interface PingPongView ()

@end

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
    
    self.ball = [[UIView alloc] initWithFrame:CGRectMake(200, 150, 30, 30)];
    self.ball.backgroundColor = [UIColor whiteColor];
    self.ball.layer.cornerRadius = self.ball.frame.size.height / 2;
    self.ball.layer.masksToBounds = YES;
    
    self.computerPlatform = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 3, 89, self.view.frame.size.width / 3, 30)];
    self.computerPlatform.backgroundColor = [UIColor blueColor];
    
    self.myPlatform = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 3, self.view.frame.size.height - 30, self.view.frame.size.width / 3, 30)];
    self.myPlatform.backgroundColor = [UIColor blueColor];
    
    self.compScore = [[UILabel alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height / 2 - 50, 50, 50)];
    self.compScore.textColor = [UIColor whiteColor];
    self.compScore.font = [UIFont systemFontOfSize:40.0 weight:UIFontWeightLight];
    
    self.myScore = [[UILabel alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height / 2 + 5, 50, 50)];
    self.myScore.textColor = [UIColor whiteColor];
    self.myScore.font = [UIFont systemFontOfSize:40.0 weight:UIFontWeightLight];
    
    
    [self.view addSubview:self.horizontalBorderView];
    [self.view addSubview:self.verticalBorderView];
    [self.view addSubview:self.ball];
    [self.view addSubview:self.computerPlatform];
    [self.view addSubview:self.myPlatform];
    [self.view addSubview:self.compScore];
    [self.view addSubview:self.myScore];
}

-(void)prepareSettingsView {
    self.settingsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.settingsView.backgroundColor = [UIColor whiteColor];
    
    UIButton *startNewGame = [[UIButton alloc] initWithFrame:CGRectMake(self.settingsView.frame.size.width / 2 - 100, 200, 200, 40)];
    [startNewGame setTitle:@"Start new game" forState:UIControlStateNormal];
    [startNewGame setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    startNewGame.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
    startNewGame.layer.cornerRadius = 10;
    startNewGame.layer.masksToBounds = YES;
    startNewGame.backgroundColor = [UIColor colorWithRed:122/255.f green:180/255.f blue:223/255.f alpha:0.8];
    [startNewGame addTarget:self action:@selector(startNewGame) forControlEvents:UIControlEventTouchUpInside];
    [self.settingsView addSubview:startNewGame];
    
    UILabel *labelName = [[UILabel alloc] initWithFrame:CGRectMake(self.settingsView.frame.size.width / 2 - 100, startNewGame.frame.origin.y + startNewGame.frame.size.height + 10, 200, 40)];
    labelName.text = @"Choose difficulty:";
    labelName.textAlignment = NSTextAlignmentCenter;
    labelName.font = [UIFont systemFontOfSize:20.0 weight:UIFontWeightSemibold];;
    [self.settingsView addSubview:labelName];
    
    UIButton *lightDifficulty = [[UIButton alloc] initWithFrame:CGRectMake(self.settingsView.frame.size.width / 2 - 100, labelName.frame.origin.y + labelName.frame.size.height + 10, 200, 40)];
    [lightDifficulty setTitle:@"Light" forState:UIControlStateNormal];
    lightDifficulty.layer.cornerRadius = 10;
    lightDifficulty.layer.masksToBounds = YES;
    lightDifficulty.backgroundColor = [UIColor colorWithRed:122/255.f green:180/255.f blue:223/255.f alpha:0.8];
    [lightDifficulty addTarget:self action:@selector(selectLightDifficulty) forControlEvents:UIControlEventTouchUpInside];
    [self.settingsView addSubview:lightDifficulty];
    
    UIButton *mediumDifficulty = [[UIButton alloc] initWithFrame:CGRectMake(self.settingsView.frame.size.width / 2 - 100, lightDifficulty.frame.origin.y + lightDifficulty.frame.size.height + 5, 200, 40)];
    [mediumDifficulty setTitle:@"Medium" forState:UIControlStateNormal];
    mediumDifficulty.layer.cornerRadius = 10;
    mediumDifficulty.layer.masksToBounds = YES;
    mediumDifficulty.backgroundColor = [UIColor colorWithRed:122/255.f green:180/255.f blue:223/255.f alpha:0.8];
    [mediumDifficulty addTarget:self action:@selector(selectMediumDifficulty) forControlEvents:UIControlEventTouchUpInside];
    [self.settingsView addSubview:mediumDifficulty];
    
    UIButton *hardDifficulty = [[UIButton alloc] initWithFrame:CGRectMake(self.settingsView.frame.size.width / 2 - 100, mediumDifficulty.frame.origin.y + mediumDifficulty.frame.size.height + 5, 200, 40)];
    [hardDifficulty setTitle:@"Hard" forState:UIControlStateNormal];
    hardDifficulty.layer.cornerRadius = 10;
    hardDifficulty.layer.masksToBounds = YES;
    hardDifficulty.backgroundColor = [UIColor colorWithRed:122/255.f green:180/255.f blue:223/255.f alpha:0.8];
    [hardDifficulty addTarget:self action:@selector(selectHardDifficulty) forControlEvents:UIControlEventTouchUpInside];
    [self.settingsView addSubview:hardDifficulty];
    
}

-(void)showSettingsView {
    [self.presenter showSettingsView];
}

-(void)selectLightDifficulty {
    [self.presenter selectLightDifficulty];
}

-(void)selectMediumDifficulty {
    [self.presenter selectMediumDifficulty];
}

-(void)selectHardDifficulty {
    [self.presenter selectHardDifficulty];
}

-(void)startNewGame {
    [self.presenter startNewGameButton];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint point = [touch locationInView:self.view];
        [self.presenter setPointMyPlatform: point];
    }
}


@end
