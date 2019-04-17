//
//  PingPongView.h
//  MVPPingPong
//
//  Created by Цырендылыкова Эржена on 08/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PresenterPingPong.h"
#import "SettingsView.h"
#import "PingPongProtocols.h"

@class PresenterPingPong;
@class SettingsView;

@interface PingPongView : UIViewController <PingPongViewProtocol>

@property (nonatomic, strong) PresenterPingPong *presenter;
@property (nonatomic, strong) SettingsView *settingsView;
@property (nonatomic, strong) UIView *horizontalBorderView;
@property (nonatomic, strong) UIView *verticalBorderView;
@property (nonatomic, strong) UIView *ball;
@property (nonatomic, strong) UIView *computerPlatform;
@property (nonatomic, strong) UIView *myPlatform;
@property (nonatomic, strong) UILabel *compScore;
@property (nonatomic, strong) UILabel *myScore;

@end
