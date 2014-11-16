//
//  GameData.m
//  Boast
//
//  Created by Al Wold on 11/15/14.
//  Copyright (c) 2014 FunCast. All rights reserved.
//

#import "GameData.h"

@implementation GameData

+ (id)sharedGameData {
    static GameData *_sharedGameData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedGameData = [[self alloc] init];
    });
    return _sharedGameData;
}

+ (UIColor *)uiColorForColor:(int)color
{
    switch (color) {
        case COLOR_RED:
            return [UIColor redColor];
        case COLOR_ORANGE:
            return [UIColor orangeColor];
        case COLOR_YELLOW:
            return [UIColor yellowColor];
            // TODO finish these
    }
    return nil;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.nextColor = 1;
        self.players = [NSMutableArray array];
    }
    return self;
}

- (int)getNextColor
{
    return self.nextColor++;
}

- (void)resetRound
{
    self.highBidder = nil;
    self.currentBid = 0;
}

@end
