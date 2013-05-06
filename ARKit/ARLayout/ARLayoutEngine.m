//
//  ARLayoutEngine.m
//  ARKit
//
//  Created by Brian Bal on 4/29/13.
//  Copyright (c) 2013 AlpineReplay. All rights reserved.
//

#import "ARLayoutEngine.h"
#import "UIView+ARTheme.h"


@implementation ARLayoutEngine

@synthesize horizontal;
@synthesize frame;
@synthesize bounds;

@synthesize y;
@synthesize x;

@synthesize topPadding;
@synthesize bottomPadding;
@synthesize leftPadding;
@synthesize rightPadding;

- (id)initWithFrame:(CGRect)aFrame bounds:(CGRect)aBounds
{
    self = [super init];
    if (self)
    {
        self.frame = aFrame;
        self.bounds = aBounds;
        self.y = aBounds.origin.y;
        self.x = aBounds.origin.x;
        self.topPadding = 0;
        self.bottomPadding = 0;
        self.rightPadding = 0;
        self.leftPadding = 0;
        // NSLog(@"x: %f, y: %f", self.x, self.y);
    }
    
    return self;
}

- (void)reset
{
    x = self.bounds.origin.x;
    y = self.bounds.origin.y;
}

- (void)addView:(UIView *)subView to:(UIView *)view marginTop:(CGFloat)mTop marginRight:(CGFloat)mRight
{
    subView.x = self.x + mRight;
    subView.y = self.y + mTop;
    [view addSubview:subView];
    
    x += subView.width + mRight;
    if (x >= bounds.origin.x + bounds.size.width)
    {
        x = self.bounds.origin.x;
        y += subView.height + mTop;
    }
    // NSLog(@"x: %f, y: %f", x, y);
}

- (void)addView:(UIView *)subView to:(UIView *)view
{
    subView.x = x;
    subView.y = y;
    [view addSubview:subView];
    y += subView.y + subView.height + self.bottomPadding;
    x += subView.x + subView.width + self.rightPadding;
    if (x > bounds.origin.x + bounds.size.width)
    {
        x = self.bounds.origin.x;
    }
}

@end
