//
//  SettingsView.h
//  MVPPingPong
//
//  Created by Цырендылыкова Эржена on 16/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PingPongProtocols.h"
#import "PresenterPingPong.h"

@class PresenterPingPong;

@interface SettingsView : UIView

@property (nonatomic, strong) PresenterPingPong *presenter;

-(SettingsView *)prepareSettingsView;

@end
