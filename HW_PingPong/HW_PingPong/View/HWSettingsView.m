//
//  HWSettingsView.m
//  HW_PingPong
//
//  Created by Цырендылыкова Эржена on 30/03/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "HWSettingsView.h"

@implementation HWSettingsView

+(HWSettingsView *)settingsView
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    HWSettingsView *settingsView = [[HWSettingsView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    settingsView.backgroundColor = [UIColor whiteColor];
    
    return settingsView;
}

@end
