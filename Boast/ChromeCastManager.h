//
//  ChromeCastManager.h
//  Boast
//
//  Created by Al Wold on 11/15/14.
//  Copyright (c) 2014 FunCast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleCast.h>
#import "BoastChannel.h"

@interface ChromeCastManager : NSObject

@property (strong, nonatomic) GCKDeviceManager *deviceManager;
@property (strong, nonatomic) BoastChannel *channel;

+ (id)shared;

@end
