//
//  HWSettingsView.h
//  HW_PingPong
//
//  Created by Цырендылыкова Эржена on 30/03/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HWSettingsView : UIView

+(HWSettingsView *)settingsView;

-(void)showSettingsView;
-(void)hideSettingsView;

@end

NS_ASSUME_NONNULL_END
