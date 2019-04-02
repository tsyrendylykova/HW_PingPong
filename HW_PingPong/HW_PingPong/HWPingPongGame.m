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

@end
