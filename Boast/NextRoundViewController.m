//
//  NextRoundViewController.m
//  Boast
//
//  Created by Al Wold on 11/15/14.
//  Copyright (c) 2014 FunCast. All rights reserved.
//

#import "NextRoundViewController.h"
#import "GameData.h"
#import "Challenge.h"
#import "ChromeCastManager.h"
#import <UIColor+Expanded.h>

@interface NextRoundViewController ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *goButton;

@end

@implementation NextRoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        NSLog(@"turning on the go button and stuff");
        GameData *gameData = [GameData sharedGameData];
        ChromeCastManager *mgr = [ChromeCastManager shared];
        self.goButton.hidden = NO;
        self.activityIndicator.hidden = YES;
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
        NSLog(@"sending message");
        [mgr.channel sendTextMessage:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    GameData *gameData = [GameData sharedGameData];
    ChromeCastManager *mgr = [ChromeCastManager shared];
    [gameData resetRound];
    // tell chromcast to go to next round
    Challenge *challenge = gameData.challenges[0];
//    Challenge *challenge = gameData.challenges[arc4random_uniform([gameData.challenges count])];
    NSLog(@"sending challenge: %@", challenge.text);
    NSDictionary *jsonData = @{@"command": @"set.question", @"text": challenge.text};
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:jsonData options:0 error:&error];
    if (error) {
        NSLog(@"error: %@", error);
    }
    NSLog(@"sending to screen pick_category");
    [mgr.channel sendTextMessage:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
    
    jsonData = @{@"command": @"nav", @"screen": @"pick_category"};
    
    data = [NSJSONSerialization dataWithJSONObject:jsonData options:0 error:&error];
    if (error) {
        NSLog(@"error: %@", error);
    }
    NSLog(@"sending to screen pick_category");
    [mgr.channel sendTextMessage:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
}

@end
