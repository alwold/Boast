//
//  GameSetupViewController.h
//  Boast
//
//  Created by Al Wold on 11/15/14.
//  Copyright (c) 2014 FunCast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleCast.h>

@interface GameSetupViewController : UIViewController <GCKDeviceScannerListener, UITableViewDelegate, UITableViewDataSource, GCKDeviceManagerDelegate>

@end
