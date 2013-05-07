//
//  ARLayoutEngine.h
//  ARKit
//
//  Created by Brian Bal on 4/29/13.
//  Copyright (c) 2013 AlpineReplay. All rights reserved.
//

#import "ARKit.h"

@interface ARLayoutEngine : NSObject

@property (readwrite) BOOL horizontal;
@property (readwrite) CGRect frame;
@property (readwrite) CGRect bounds;

@property (readwrite) CGFloat y;
@property (readwrite) CGFloat x;

@property (readwrite) CGFloat topPadding;
@property (readwrite) CGFloat bottomPadding;
@property (readwrite) CGFloat leftPadding;
@property (readwrite) CGFloat rightPadding;

- (id)initWithFrame:(CGRect)aFrame bounds:(CGRect)aBounds;
- (void)reset;
- (void)addView:(UIView *)subView to:(UIView *)view marginTop:(CGFloat)mTop marginRight:(CGFloat)mRight;
- (void)addView:(UIView *)subView to:(UIView *)view;

@end
