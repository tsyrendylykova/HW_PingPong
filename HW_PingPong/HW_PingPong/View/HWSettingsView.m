//
//  HWSettingsView.m
//  HW_PingPong
//
//  Created by Цырендылыкова Эржена on 30/03/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "HWSettingsView.h"

@implementation HWSettingsView

static const CGFloat settingsViewMarginLeft = 15;
static const CGFloat settingsViewMarginBottom = 25;
static const CGFloat settingsViewMoveDistance = 900;

+(HWSettingsView *)settingsView
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    HWSettingsView *settingsView = [[HWSettingsView alloc] initWithFrame:CGRectMake(settingsViewMarginLeft, settingsViewMarginBottom, screenWidth - 2 * settingsViewMarginLeft, screenHeight - 2 * settingsViewMarginBottom)];
    settingsView.backgroundColor = [UIColor redColor];
    settingsView.layer.cornerRadius = settingsViewMarginBottom;
    settingsView.layer.masksToBounds =  YES;
    settingsView.layer.borderColor = [UIColor blackColor].CGColor;
    
    settingsView.center = CGPointMake(settingsView.center.x, settingsView.center.y + settingsViewMoveDistance);
    
    return settingsView;
}

-(void)showSettingsView
{
    [UIView animateWithDuration:0.7 animations:^{
        self.center = CGPointMake(self.center.x, self.center.y - settingsViewMoveDistance);
    }];
}

-(void)hideSettingsView
{
    [UIView animateWithDuration:0.7 animations:^{
        self.center = CGPointMake(self.center.x, self.center.y + settingsViewMoveDistance);
    }];
}

@end
