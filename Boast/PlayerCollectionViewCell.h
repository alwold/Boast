//
//  PlayerCollectionViewCell.h
//  Boast
//
//  Created by Al Wold on 11/15/14.
//  Copyright (c) 2014 FunCast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TintedImageView.h"

@interface PlayerCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet TintedImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *jailImageView;
@property (weak, nonatomic) IBOutlet UIView *imageHolderView;

- (void)setColor:(UIColor *)color;

@end
