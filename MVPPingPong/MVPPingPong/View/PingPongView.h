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

-(void)prepareTableUI;
-(void)prepareSettingsView;

@end

NS_ASSUME_NONNULL_END
