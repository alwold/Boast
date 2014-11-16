//
//  GameSetupViewController.m
//  Boast
//
//  Created by Al Wold on 11/15/14.
//  Copyright (c) 2014 FunCast. All rights reserved.
//

#import <GoogleCast.h>
#import "GameSetupViewController.h"
#import "GameData.h"
#import "ChromeCastManager.h"

@interface GameSetupViewController ()
@property (strong, nonatomic) IBOutlet UILabel *pointsLabel;
@property (strong, nonatomic) GCKDeviceScanner *deviceScanner;
@property (strong, nonatomic) NSMutableArray *devices;
@property (weak, nonatomic) IBOutlet UITableView *devicesTableView;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;
@property (weak, nonatomic) IBOutlet UIButton *gameOnButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@end

@implementation GameSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.devices = [NSMutableArray array];
    self.pointsLabel.text = [NSString stringWithFormat:@"%d", (int) self.stepper.value];
    self.devicesTableView.delegate = self;
    self.devicesTableView.dataSource = self;
    // Do any additional setup after loading the view.
    
    self.deviceScanner = [[GCKDeviceScanner alloc] init];
    
//    GCKFilterCriteria *filterCriteria = [[GCKFilterCriteria alloc] init];
//    filterCriteria = [GCKFilterCriteria criteriaForAvailableApplicationWithID:@"YOUR_APP_ID_HERE"];
//    
//    self.deviceScanner.filterCriteria = filterCriteria;
    
    [self.deviceScanner addListener:self];
    [self.deviceScanner startScan];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pointsValueChanged:(UIStepper *)sender {
    NSLog(@"stepper value: %f", sender.value);
    self.pointsLabel.text = [NSString stringWithFormat:@"%d", (int) sender.value];
}

- (void)deviceDidComeOnline:(GCKDevice *)device
{
    NSLog(@"device online: %@", device);
    [self.devices addObject:device];
    [self.devicesTableView reloadData];
}

- (void)deviceDidGoOffline:(GCKDevice *)device
{
    NSLog(@"device offline: %@", device);
    [self.devices removeObject:device];
    [self.devicesTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.devices count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    GCKDevice *device = self.devices[indexPath.row];
    cell.textLabel.text = device.friendlyName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GameData *gameData = [GameData sharedGameData];
    gameData.device = self.devices[indexPath.row];
    self.gameOnButton.enabled = YES;
}

- (IBAction)gameOnPressed:(id)sender {
    self.activityIndicatorView.hidden = NO;
    
    GameData *gameData = [GameData sharedGameData];
    gameData.winPoints = (int) self.stepper.value;
    ChromeCastManager *manager = [ChromeCastManager shared];
    manager.deviceManager = [[GCKDeviceManager alloc] initWithDevice:gameData.device
                                                   clientPackageName:[[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleIdentifier"]];
    manager.deviceManager.delegate = self;
    [manager.deviceManager connect];
}

- (void)deviceManagerDidConnect:(GCKDeviceManager *)deviceManager
{
    NSLog(@"connected");
    [deviceManager launchApplication:@"083889FB"];
}

- (void)deviceManager:(GCKDeviceManager *)deviceManager didConnectToCastApplication:(GCKApplicationMetadata *)applicationMetadata sessionID:(NSString *)sessionID launchedApplication:(BOOL)launchedApplication
{
    NSLog(@"connected to application");

    ChromeCastManager *manager = [ChromeCastManager shared];
    manager.channel = [[BoastChannel alloc] initWithNamespace:@"urn:x-cast:com.google.cast.funcast.boast"];

    [deviceManager addChannel:manager.channel];
    [self performSegueWithIdentifier:@"showAddPlayer" sender:self];
}
@end
