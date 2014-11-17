//
//  AddPlayerViewController.m
//  Boast
//
//  Created by Al Wold on 11/15/14.
//  Copyright (c) 2014 FunCast. All rights reserved.
//

#import "AddPlayerViewController.h"
#import "GameData.h"
#import "Player.h"
#import "ChromeCastManager.h"
#import "Challenge.h"
#import <UIColor+Expanded.h>

@interface AddPlayerViewController ()

@property (weak, nonatomic) IBOutlet UIView *colorView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (nonatomic) int color;

@end

@implementation AddPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNextColor];

//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//        ChromeCastManager *mgr = [ChromeCastManager shared];
//        NSDictionary *jsonData = @{@"command": @"nav", @"screen": @"add_players"};
//        NSError *error;
//        NSData *data = [NSJSONSerialization dataWithJSONObject:jsonData options:0 error:&error];
//        if (error) {
//            NSLog(@"error: %@", error);
//        }
//        NSLog(@"sending message");
//        [mgr.channel sendTextMessage:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
//    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addPlayerPressed:(id)sender {
    GameData *gameData = [GameData sharedGameData];
    Player *player = [[Player alloc] init];
    player.name = self.nameTextField.text;
    player.score = 0;
    player.skipRound = NO;
    player.color = self.color;
    
    [gameData.players addObject:player];
    ChromeCastManager *mgr = [ChromeCastManager shared];
    UIColor *color = [GameData uiColorForColor:self.color];
    NSDictionary *jsonData = @{@"command": @"add.player", @"name": player.name, @"avatar": @(player.color), @"color": [color hexStringFromColor]};
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:jsonData options:0 error:&error];
    if (error) {
        NSLog(@"error: %@", error);
    }
    NSLog(@"sending message");
    [mgr.channel sendTextMessage:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
    
//    [[[UIAlertView alloc] initWithTitle:@"Added" message:@"Added" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    
    self.nameTextField.text = @"";
    [self setNextColor];
}

- (void)setNextColor {
    GameData *gameData = [GameData sharedGameData];
    self.color = [gameData getNextColor];
    self.colorView.backgroundColor = [GameData uiColorForColor:self.color];
}

- (IBAction)startButtonPressed:(id)sender {
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ChromeCastManager *mgr = [ChromeCastManager shared];
    GameData *gameData = [GameData sharedGameData];
    Challenge *challenge = gameData.challenges[1];
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
