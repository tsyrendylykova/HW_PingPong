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
    if (self.myScore > 1 || self.computerScore > 1) {
        return YES;
    } else {
        return NO;
    }
}

-(void)selectLightDiffuculty {
    self.dx = 0.1;
    self.dy = 0.1;
}

-(void)selectMediumDiffuculty {
    self.dx = 0.3;
    self.dy = 0.3;
}

-(void)selectHardDiffuculty {
    self.dx = 0.5;
    self.dy = 0.5;
}


@end
