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
#import "ChromeCastManager.h"
#import <UIColor+Expanded.h>

@interface GameOverViewController ()

@end

@implementation GameOverViewController

- (void)viewDidAppear:(BOOL)animated
{
    ChromeCastManager *mgr = [ChromeCastManager shared];
    GameData *gameData = [GameData sharedGameData];

    NSMutableArray *scoreData = [NSMutableArray array];
    NSArray *sortedPlayers = [gameData.players sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        Player *p1 = obj1;
        Player *p2 = obj2;
        if (p1.score > p2.score) {
            return NSOrderedAscending;
        } else if (p1.score < p2.score) {
            return NSOrderedDescending;
        } else {
            return NSOrderedSame;
        }
    }];
    for (Player *player in sortedPlayers) {
        UIColor *color = [GameData uiColorForColor:player.color];
        [scoreData addObject:@{@"name": player.name, @"score": @(player.score), @"avatar": @(player.color), @"color": [color hexStringFromColor]}];
    }
    
    NSDictionary *jsonData = @{@"command": @"set.score", @"players": scoreData};
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:jsonData options:0 error:&error];
    if (error) {
        NSLog(@"error: %@", error);
    }
    NSLog(@"game over, sending score");
    [mgr.channel sendTextMessage:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];

}

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
