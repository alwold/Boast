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

@interface AddPlayerViewController ()

@property (weak, nonatomic) IBOutlet UIView *colorView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (nonatomic) int color;

@end

@implementation AddPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    GameData *gameData = [GameData sharedGameData];
    self.color = [gameData getNextColor];
    switch (self.color) {
        case COLOR_RED:
            self.colorView.backgroundColor = [UIColor redColor];
            break;
        case COLOR_ORANGE:
            self.colorView.backgroundColor = [UIColor orangeColor];
            break;
        case COLOR_YELLOW:
            self.colorView.backgroundColor = [UIColor yellowColor];
            break;
            // TODO finish these
    }
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
}

- (IBAction)startButtonPressed:(id)sender {
}

@end
