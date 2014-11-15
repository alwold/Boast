//
//  GameSetupViewController.m
//  Boast
//
//  Created by Al Wold on 11/15/14.
//  Copyright (c) 2014 FunCast. All rights reserved.
//

#import "GameSetupViewController.h"

@interface GameSetupViewController ()
@property (strong, nonatomic) IBOutlet UILabel *pointsLabel;

@end

@implementation GameSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pointsLabel.text = @"0";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pointsValueChanged:(UIStepper *)sender {
    NSLog(@"stepper value: %f", sender.value);
    self.pointsLabel.text = [NSString stringWithFormat:@"%d", (int) sender.value];
}

@end
