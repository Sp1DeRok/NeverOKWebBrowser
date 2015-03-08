//
//  NSAffineTransform+MMTabBarViewExtensions.m
//  MMTabBarView
//
//  Created by Michael Monscheuer on 9/26/12.
//  Copyright (c) 2012 Michael Monscheuer. All rights reserved.
//

#import "NSAffineTransform+MMTabBarViewExtensions.h"

@implementation NSAffineTransform (MMTabBarViewExtensions)

    // initialize the NSAffineTransform so it will flip the contents of bounds
- (NSAffineTransform *)mm_flipVertical:(NSRect)bounds {
    NSAffineTransformStruct at;
    at.m11 = 1.0;
    at.m12 = 0.0;
    at.tX = 0;
    at.m21 = 0.0;
    at.m22 = -1.0;
    at.tY = bounds.origin.y+bounds.size.height;
    [self setTransformStruct: at];
    
    [self translateXBy:0.0f yBy:-bounds.origin.y];
    return self;
}

@end
