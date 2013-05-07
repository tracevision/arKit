//
//  UIView+ARLayout.h
//  ARKit
//
//  Created by Brian Bal on 5/5/13.
//  Copyright (c) 2013 AlpineReplay. All rights reserved.
//

#import "ARKit.h"

@interface UIView (ARLayout)

@property (readwrite) double x;
@property (readwrite) double y;
@property (readwrite) double width;
@property (readwrite) double height;

- (id)initWithWithX:(CGFloat)xp y:(CGFloat)yp w:(CGFloat)w h:(CGFloat)h __attribute__((deprecated));
- (id)initWithWidth:(CGFloat)w height:(CGFloat)h;

- (void)addSubview:(UIView *)view above:(UIView *)relativeView offsetBottom:(double)offsetBottom offsetLeft:(double)offsetLeft;
- (void)addSubview:(UIView *)view below:(UIView *)relativeView offsetTop:(double)offsetTop offsetLeft:(double)offsetLeft;
- (void)addSubview:(UIView *)view rightOf:(UIView *)relativeView offsetTop:(double)offsetTop offsetLeft:(double)offsetLeft;
- (void)addSubview:(UIView *)view leftOf:(UIView *)relativeView offsetTop:(double)offsetTop offsetRight:(double)offsetRight;
- (void)debugFrame;

@end
