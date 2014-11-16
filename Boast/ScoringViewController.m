//
//  ScoringViewController.m
//  Boast
//
//  Created by Al Wold on 11/15/14.
//  Copyright (c) 2014 FunCast. All rights reserved.
//

#import "ScoringViewController.h"
#import "GameData.h"

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
    self.score++;
    [self updateProgressBar];
}

- (void)updateProgressBar {
    NSLog(@"updateProgressBar: %d", self.score);
    GameData *gameData = [GameData sharedGameData];
    [self.progressView setProgress:(float) self.score / (float) gameData.currentBid animated:YES];
}

@end
