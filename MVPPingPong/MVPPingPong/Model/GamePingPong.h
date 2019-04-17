//
//  GamePingPong.h
//  MVPPingPong
//
//  Created by Цырендылыкова Эржена on 08/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GamePingPong : NSObject

@property (nonatomic) NSInteger computerScore;
@property (nonatomic) NSInteger myScore;
@property (nonatomic) CGFloat dx;
@property (nonatomic) CGFloat dy;

-(BOOL)isGameOver;
-(void)selectDifficulty: (CGFloat)difficulty;

@end
