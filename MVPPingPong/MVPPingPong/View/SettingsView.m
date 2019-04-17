//
//  SettingsView.m
//  MVPPingPong
//
//  Created by Цырендылыкова Эржена on 16/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "SettingsView.h"

@implementation SettingsView

-(SettingsView *)prepareSettingsView {
    SettingsView *settingsView = [[SettingsView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    settingsView.backgroundColor = [UIColor whiteColor];
    
    UIButton *startNewGame = [[UIButton alloc] initWithFrame:CGRectMake(settingsView.frame.size.width / 2 - 100, 200, 200, 40)];
    [startNewGame setTitle:@"Start new game" forState:UIControlStateNormal];
    [startNewGame setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    startNewGame.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
    startNewGame.layer.cornerRadius = 10;
    startNewGame.layer.masksToBounds = YES;
    startNewGame.backgroundColor = [UIColor colorWithRed:122/255.f green:180/255.f blue:223/255.f alpha:0.8];
    [startNewGame addTarget:self action:@selector(didTapStartNewGame) forControlEvents:UIControlEventTouchUpInside];
    [settingsView addSubview:startNewGame];
    
    UILabel *labelName = [[UILabel alloc] initWithFrame:CGRectMake(settingsView.frame.size.width / 2 - 100, startNewGame.frame.origin.y + startNewGame.frame.size.height + 10, 200, 40)];
    labelName.text = @"Choose difficulty:";
    labelName.textAlignment = NSTextAlignmentCenter;
    labelName.font = [UIFont systemFontOfSize:20.0 weight:UIFontWeightSemibold];;
    [settingsView addSubview:labelName];
    
    UIButton *lightDifficulty = [[UIButton alloc] initWithFrame:CGRectMake(settingsView.frame.size.width / 2 - 100, labelName.frame.origin.y + labelName.frame.size.height + 10, 200, 40)];
    [lightDifficulty setTitle:@"Light" forState:UIControlStateNormal];
    lightDifficulty.layer.cornerRadius = 10;
    lightDifficulty.layer.masksToBounds = YES;
    lightDifficulty.backgroundColor = [UIColor colorWithRed:122/255.f green:180/255.f blue:223/255.f alpha:0.8];
    [lightDifficulty addTarget:self action:@selector(didTapLightDifficulty) forControlEvents:UIControlEventTouchUpInside];
    [settingsView addSubview:lightDifficulty];
    
    UIButton *mediumDifficulty = [[UIButton alloc] initWithFrame:CGRectMake(settingsView.frame.size.width / 2 - 100, lightDifficulty.frame.origin.y + lightDifficulty.frame.size.height + 5, 200, 40)];
    [mediumDifficulty setTitle:@"Medium" forState:UIControlStateNormal];
    mediumDifficulty.layer.cornerRadius = 10;
    mediumDifficulty.layer.masksToBounds = YES;
    mediumDifficulty.backgroundColor = [UIColor colorWithRed:122/255.f green:180/255.f blue:223/255.f alpha:0.8];
    [mediumDifficulty addTarget:self action:@selector(didTapMediumDifficulty) forControlEvents:UIControlEventTouchUpInside];
    [settingsView addSubview:mediumDifficulty];
    
    UIButton *hardDifficulty = [[UIButton alloc] initWithFrame:CGRectMake(settingsView.frame.size.width / 2 - 100, mediumDifficulty.frame.origin.y + mediumDifficulty.frame.size.height + 5, 200, 40)];
    [hardDifficulty setTitle:@"Hard" forState:UIControlStateNormal];
    hardDifficulty.layer.cornerRadius = 10;
    hardDifficulty.layer.masksToBounds = YES;
    hardDifficulty.backgroundColor = [UIColor colorWithRed:122/255.f green:180/255.f blue:223/255.f alpha:0.8];
    [hardDifficulty addTarget:self action:@selector(didTapHardDifficulty) forControlEvents:UIControlEventTouchUpInside];
    [settingsView addSubview:hardDifficulty];
    
    return settingsView;
}

-(void)didTapStartNewGame {
    [self.presenter hideSettingsView];
    [self.presenter startNewGame];
}

-(void)didTapLightDifficulty {
    [self.presenter selectDifficulty:0.2];
}

-(void)didTapMediumDifficulty {
    [self.presenter selectDifficulty:0.3];
}

-(void)didTapHardDifficulty {
    [self.presenter selectDifficulty:0.5];
}


@end
