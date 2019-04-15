//
//  PingPongView.h
//  MVPPingPong
//
//  Created by Цырендылыкова Эржена on 08/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PresenterPingPong.h"

@class PresenterPingPong;

NS_ASSUME_NONNULL_BEGIN

@interface PingPongView : UIViewController

@property (nonatomic, strong) PresenterPingPong *presenter;
@property (nonatomic, strong) UIView *horizontalBorderView;
@property (nonatomic, strong) UIView *verticalBorderView;
@property (nonatomic, strong) UIView *ball;
@property (nonatomic, strong) UIView *computerPlatform;
@property (nonatomic, strong) UIView *myPlatform;
@property (nonatomic, strong) UILabel *compScore;
@property (nonatomic, strong) UILabel *myScore;
@property (nonatomic, strong) UIView *settingsView;

// для протокола
// + то что вызывается во viewDidLoad надо не забыть
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

NS_ASSUME_NONNULL_END
