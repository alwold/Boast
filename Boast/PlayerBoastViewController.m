//
//  PlayerBoastViewController.m
//  Boast
//
//  Created by Al Wold on 11/15/14.
//  Copyright (c) 2014 FunCast. All rights reserved.
//

#import "PlayerBoastViewController.h"
#import "GameData.h"
#import "PlayerCollectionViewCell.h"
#import "Player.h"

@interface PlayerBoastViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) GameData *gameData;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation PlayerBoastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionView.dataSource = self;
    self.gameData = [GameData sharedGameData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"numberOfItems");
    return [self.gameData.players count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PlayerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSLog(@"setting image");
    GameData *gameData = [GameData sharedGameData];
    Player *player = gameData.players[indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    cell.imageView.image = [UIImage imageNamed:@"avatar.jpg"];
    UIColor *color = [GameData uiColorForColor:player.color];
    NSLog(@"setting color to %@", color);
    cell.imageView.customTintColor = color;
    cell.label.text = player.name;
    return cell;
}

@end
