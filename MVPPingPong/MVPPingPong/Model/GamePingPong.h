//
//  GamePingPong.h
//  MVPPingPong
//
//  Created by Цырендылыкова Эржена on 08/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GamePingPong : NSObject

@property (nonatomic) NSInteger computerScore;
@property (nonatomic) NSInteger myScore;
@property (nonatomic) CGFloat dx;
@property (nonatomic) CGFloat dy;

-(instancetype)initGame;
-(BOOL)isGameOver;

-(void)selectDifficulty: (CGFloat)difficulty;

@end

NS_ASSUME_NONNULL_END
