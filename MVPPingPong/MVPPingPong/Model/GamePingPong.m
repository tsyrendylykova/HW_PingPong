//
//  GamePingPong.m
//  MVPPingPong
//
//  Created by Цырендылыкова Эржена on 08/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "GamePingPong.h"

@implementation GamePingPong

-(instancetype)initGame {
    self = [super init];
    return self;
}

-(BOOL)isGameOver {
    if (self.myScore > 5 || self.computerScore > 5) {
        return YES;
    } else {
        return NO;
    }
}

-(void)selectDifficulty: (CGFloat)difficulty {
    if (self.dx > 0) self.dx = difficulty; else self.dx = difficulty * (-1);
    if (self.dy > 0) self.dy = difficulty; else self.dy = difficulty * (-1);
}

@end
