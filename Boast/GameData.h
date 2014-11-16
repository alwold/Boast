//
//  GameData.h
//  Boast
//
//  Created by Al Wold on 11/15/14.
//  Copyright (c) 2014 FunCast. All rights reserved.
//

#define COLOR_RED 1
#define COLOR_ORANGE 2
#define COLOR_YELLOW 3
#define COLOR_GREEN 4
#define COLOR_BLUE 5
#define COLOR_INDIGO 6
#define COLOR_VIOLET 7
#define COLOR_MAX 7

#import <Foundation/Foundation.h>
#import <GoogleCast.h>
#import "Player.h"

@interface GameData : NSObject

@property (strong, nonatomic) GCKDevice *device;
@property (nonatomic) int winPoints;
@property (strong, nonatomic) NSMutableArray *players;
@property (nonatomic) int nextColor;
@property (nonatomic) int currentBid;
@property (strong, nonatomic) Player *highBidder;
@property (strong, nonatomic) NSMutableArray *challenges;

+ (id)sharedGameData;

+ (UIColor *)uiColorForColor:(int)color;

- (int)getNextColor;

- (void)resetRound;

- (void)reset;

- (void)resetGame;

@end
