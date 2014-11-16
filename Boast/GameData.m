//
//  GameData.m
//  Boast
//
//  Created by Al Wold on 11/15/14.
//  Copyright (c) 2014 FunCast. All rights reserved.
//

#import "GameData.h"
#import "Challenge.h"

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
        case COLOR_GREEN:
            return [UIColor greenColor];
        case COLOR_BLUE:
            return [UIColor blueColor];
        case COLOR_INDIGO:
            return [UIColor colorWithRed:75 green:0 blue:130 alpha:1];
        case COLOR_VIOLET:
            return [UIColor purpleColor];
    }
    return nil;
}

- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"game data init");
        self.nextColor = 1;
        self.players = [NSMutableArray array];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"challenges" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSError *error;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (error) {
            NSLog(@"error: %@", error);
        }
        self.challenges = [NSMutableArray array];
        NSArray *challenges = json[@"challenges"];
        for (NSDictionary *challengeDict in challenges) {
            Challenge *challenge = [[Challenge alloc] init];
            challenge.text = challengeDict[@"text"];
            challenge.category = challengeDict[@"category"];
            NSLog(@"adding challenge with text %@, and category %@", challenge.text, challenge.category);
            [self.challenges addObject:challenge];
        }
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

- (void)resetGame
{
    [self resetRound];
    for (Player *player in self.players) {
        player.score = 0;
        player.skipRound = NO;
    }
}

- (void)reset
{
    [self resetGame];
    [self.players removeAllObjects];
    self.device = nil;
    self.nextColor = 1;
}

@end
