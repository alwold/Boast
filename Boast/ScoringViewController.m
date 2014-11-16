//
//  ScoringViewController.m
//  Boast
//
//  Created by Al Wold on 11/15/14.
//  Copyright (c) 2014 FunCast. All rights reserved.
//

#import "ScoringViewController.h"
#import "GameData.h"
#import "ChromeCastManager.h"

@interface ScoringViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *timeLeftLabel;
@property (nonatomic) int score;

@end

@implementation ScoringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.score = 0;
    GameData *gameData = [GameData sharedGameData];
    self.nameLabel.text = gameData.highBidder.name;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 30*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self endTurn];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)gotOnePressed:(id)sender {
    self.score++;
    [self updateProgressBar];
}

- (IBAction)oopsPressed:(id)sender {
    self.score--;
    [self updateProgressBar];
}

- (void)updateProgressBar {
    NSLog(@"updateProgressBar: %d", self.score);
    GameData *gameData = [GameData sharedGameData];
    [self.progressView setProgress:(float) self.score / (float) gameData.currentBid animated:YES];
}

- (void)endTurn {
    GameData *gameData = [GameData sharedGameData];
    for (Player *player in gameData.players) {
        player.skipRound = NO;
    }
    if (self.score >= gameData.currentBid) {
        gameData.highBidder.score++;
        [self sendToScreen:@"question_success"];
    } else {
        gameData.highBidder.skipRound = YES;
        [self sendToScreen:@"question_failure"];
    }
    NSLog(@"score: %d", gameData.highBidder.score);
    NSLog(@"win points: %d", gameData.winPoints);
    if (gameData.highBidder.score >= gameData.winPoints) {
        [self performSegueWithIdentifier:@"endGame" sender:self];
    } else {
        [self performSegueWithIdentifier:@"endTurn" sender:self];
    }
}

- (void)sendToScreen:(NSString *)screen
{
    ChromeCastManager *mgr = [ChromeCastManager shared];
    NSDictionary *jsonData = @{@"command": @"nav", @"screen": screen};
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:jsonData options:0 error:&error];
    if (error) {
        NSLog(@"error: %@", error);
    }
    NSLog(@"sending to screen %@", screen);
    [mgr.channel sendTextMessage:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];

}

@end
