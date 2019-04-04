//
//  HWPingPongGame.m
//  HW_PingPong
//
//  Created by Цырендылыкова Эржена on 01/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "HWPingPongGame.h"

@implementation HWPingPongGame

-(BOOL)isGameOver {
    if (self.myScore > 10 || self.computerScore > 10) {
        return YES;
    } else {
        return NO;
    }
}

-(void)selectLightDiffuculty {
    if (self.dx > 0) self.dx = 0.1; else self.dx = -0.1;
    if (self.dy > 0) self.dy = 0.1; else self.dy = -0.1;
}

-(void)selectMediumDiffuculty {
    if (self.dx > 0) self.dx = 0.3; else self.dx = -0.3;
    if (self.dy > 0) self.dy = 0.3; else self.dy = -0.3;
}

-(void)selectHardDiffuculty {
    if (self.dx > 0) self.dx = 0.5; else self.dx = -0.5;
    if (self.dy > 0) self.dy = 0.5; else self.dy = -0.5;
}


@end
