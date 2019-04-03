//
//  HWPingPongGame.h
//  HW_PingPong
//
//  Created by Цырендылыкова Эржена on 01/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HWPingPongGame : NSObject

@property (nonatomic) NSInteger computerScore;
@property (nonatomic) NSInteger myScore;
@property (nonatomic) CGFloat dx;
@property (nonatomic) CGFloat dy;

-(BOOL)isGameOver;
-(void)selectLightDiffuculty;
-(void)selectMediumDiffuculty;
-(void)selectHardDiffuculty;

@end

NS_ASSUME_NONNULL_END
