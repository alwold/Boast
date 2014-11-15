//
//  Player.h
//  Boast
//
//  Created by Al Wold on 11/15/14.
//  Copyright (c) 2014 FunCast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (strong, nonatomic) NSString *name;
@property (nonatomic) int color;
@property (nonatomic) int score;
@property (nonatomic) BOOL skipRound;

@end
