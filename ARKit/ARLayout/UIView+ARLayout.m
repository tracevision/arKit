//
//  UIView+ARLayout.m
//  ARKit
//
//  Created by Brian Bal on 5/5/13.
//  Copyright (c) 2013 AlpineReplay. All rights reserved.
//

#import "UIView+ARLayout.h"

@implementation UIView (ARLayout)

#pragma mark - Constructors

- (id)initWithWithX:(CGFloat)xp y:(CGFloat)yp w:(CGFloat)w h:(CGFloat)h
{
    self = [self initWithFrame:CGRectMake(xp, yp, w, h)];
    if (self)
    {
        
    }
    return self;
}


- (id)initWithWidth:(CGFloat)w height:(CGFloat)h
{
    self = [self initWithFrame:CGRectMake(0, 0, w, h)];
    if (self)
    {
        
    }
    return self;
}


#pragma mark - Layout Helpers

- (void)addSubview:(UIView *)view above:(UIView *)relativeView offsetBottom:(double)offsetBottom offsetLeft:(double)offsetLeft
{
    view.x = relativeView.x + offsetLeft;
    view.y = relativeView.y - view.height - offsetBottom;
    [self addSubview:view];
}

- (void)addSubview:(UIView *)view below:(UIView *)relativeView offsetTop:(double)offsetTop offsetLeft:(double)offsetLeft
{
    view.x = relativeView.x + offsetLeft;
    view.y = relativeView.y + relativeView.height + offsetTop;
    [self addSubview:view];
}

- (void)addSubview:(UIView *)view rightOf:(UIView *)relativeView offsetTop:(double)offsetTop offsetLeft:(double)offsetLeft
{
    view.x = relativeView.x + relativeView.width + offsetLeft;
    view.y = relativeView.y + offsetTop;
    [self addSubview:view];
}

- (void)addSubview:(UIView *)view leftOf:(UIView *)relativeView offsetTop:(double)offsetTop offsetRight:(double)offsetRight
{
    view.x = relativeView.x - view.width - offsetRight;
    view.y = relativeView.y + offsetTop;
    [self addSubview:view];
}

- (void)debugFrame
{
    NSLog(@"%@ (x:%f, y:%f, w:%f, h:%f)", NSStringFromClass([self class]), self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}


#pragma mark - Frame Helpers

- (double)x
{
    return self.frame.origin.x;
}

- (void)setX:(double)x
{
    self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (double)y
{
    return self.frame.origin.y;
}

- (void)setY:(double)y
{
    self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
}

- (double)width
{
    return self.frame.size.width;
}

- (void)setWidth:(double)width
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}

- (double)height
{
    return self.frame.size.height;
}

- (void)setHeight:(double)height
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

@end
