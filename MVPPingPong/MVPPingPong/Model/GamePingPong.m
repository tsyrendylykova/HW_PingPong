//
//  GamePingPong.m
//  MVPPingPong
//
//  Created by Цырендылыкова Эржена on 08/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "GamePingPong.h"

@implementation GamePingPong

-(id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

-(BOOL)isGameOver {
    if (self.myScore > 11 || self.computerScore > 11) {
        return YES;
    } else {
        return NO;
    }
}

-(void)selectLightDiffuculty {
    if (self.dx > 0) self.dx = 0.2; else self.dx = -0.2;
    if (self.dy > 0) self.dy = 0.2; else self.dy = -0.2;
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
