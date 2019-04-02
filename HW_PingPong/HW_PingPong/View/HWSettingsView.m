//
//  HWSettingsView.m
//  HW_PingPong
//
//  Created by Цырендылыкова Эржена on 30/03/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "HWSettingsView.h"

@implementation HWSettingsView

static const CGFloat settingsViewMarginLeft = 25;
static const CGFloat settingsViewMarginBottom = 105;
static const CGFloat settingsViewMoveDistance = 900;

+(HWSettingsView *)settingsView
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    HWSettingsView *settingsView = [[HWSettingsView alloc] initWithFrame:CGRectMake(settingsViewMarginLeft, settingsViewMarginBottom, screenWidth - 2 * settingsViewMarginLeft, screenHeight - settingsViewMarginBottom - 20)];
    settingsView.backgroundColor = [UIColor whiteColor];
    settingsView.layer.cornerRadius = settingsViewMarginBottom / 5;
    settingsView.layer.masksToBounds =  YES;
    settingsView.layer.borderColor = [UIColor blackColor].CGColor;
    
    settingsView.center = CGPointMake(settingsView.center.x, settingsView.center.y + settingsViewMoveDistance);
    
    return settingsView;
}

-(void)showSettingsView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.center = CGPointMake(self.center.x, self.center.y - settingsViewMoveDistance);
        self.alpha = 1;
    }];
}

-(void)hideSettingsView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.center = CGPointMake(self.center.x, self.center.y + settingsViewMoveDistance);
        self.alpha = 1;
    }];
}

@end
