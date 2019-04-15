//
//  PingPongProtocols.h
//  MVPPingPong
//
//  Created by Цырендылыкова Эржена on 15/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

@protocol PingPongViewProtocol <NSObject>

-(void)prepareTableUI;
-(void)prepareSettingsView;
-(void)setScoresWithCompScore: (NSInteger)compScore myScore:(NSInteger)myScore;
-(void)setComputerPlatformCenter;
-(void)setBallCenterWithDx: (CGFloat)dx dy:(CGFloat)dy;
-(Boolean)isBallTouchRightOrLeftSide;
-(Boolean)isBallTouchMyPlatform;
-(Boolean)isBallTouchComputerPlatform;
-(Boolean)isBallTouchBottomSide;
-(Boolean)isBallTouchTopSide;
-(void)clearUIForNewGame;
-(void)showSettingsView;
-(void)hideSettingsView;
-(void)incrementCompScore: (NSInteger)newScore;
-(void)incrementMyScore: (NSInteger)newScore;
-(void)resetUI;
-(void)showGameWinner:(NSString *)text;

@end

@protocol PingPongPresenterProtocol <NSObject>

-(void)showUI;
-(void)startNewGame;
-(void)startTimer;
-(void)pauseGame;
-(void)selectDifficulty: (CGFloat)difficulty;

@end
