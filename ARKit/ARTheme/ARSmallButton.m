//
//  ARSmallButton.m
//  ARKit
//
//  Created by Brian Bal on 5/17/13.
//  Copyright (c) 2013 AlpineReplay. All rights reserved.
//

#import "ARSmallButton.h"

@implementation ARSmallButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGFloat widthDelta = 0;
    if (self.bounds.size.width < 44)
    {
        widthDelta = -((44 - self.bounds.size.width) / 2);
    }
    
    CGFloat heightDelta = 0;
    if (self.bounds.size.height < 44)
    {
        heightDelta = -((44 - self.bounds.size.height) / 2);
    }
    
    CGRect largerBounds = CGRectInset(self.bounds, widthDelta, heightDelta);
    return CGRectContainsPoint(largerBounds, point);
}

@end
