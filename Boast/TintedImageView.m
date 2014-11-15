//
//  TintedImageView.m
//  Boast
//
//  Created by Al Wold on 11/15/14.
//  Copyright (c) 2014 FunCast. All rights reserved.
//

#import "TintedImageView.h"

@implementation TintedImageView

- (void) drawRect:(CGRect)area
{
    NSLog(@"drawRect");
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    // Draw picture first
    //
    CGContextDrawImage(context, self.frame, self.image.CGImage);
    
    // Blend mode could be any of CGBlendMode values. Now draw filled rectangle
    // over top of image.
    //
    CGContextSetBlendMode (context, kCGBlendModeMultiply);
    CGContextSetFillColor(context, CGColorGetComponents(self.customTintColor.CGColor));
    NSLog(@"filling");
    CGContextFillRect (context, self.bounds);
    CGContextRestoreGState(context);
}

@end
