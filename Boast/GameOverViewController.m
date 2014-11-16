//
//  GameOverViewController.m
//  Boast
//
//  Created by Al Wold on 11/16/14.
//  Copyright (c) 2014 FunCast. All rights reserved.
//

#import "GameOverViewController.h"
#import "GameSetupViewController.h"
#import "GameData.h"

@interface GameOverViewController ()

@end

@implementation GameOverViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    GameData *gameData = [GameData sharedGameData];
    if ([segue.destinationViewController isKindOfClass:[GameSetupViewController class]]) {
        // reset players, scores, etc.
        [gameData reset];
    } else {
        // just reset the game
        [gameData resetGame];
    }
}

@end
