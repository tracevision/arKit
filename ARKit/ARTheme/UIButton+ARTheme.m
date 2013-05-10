//
//  UIButton+ARTheme.m
//  ARKit
//
//  Created by Brian Bal on 5/7/13.
//  Copyright (c) 2013 AlpineReplay. All rights reserved.
//

#import "UIButton+ARTheme.h"
#import "ARKit.h"

@implementation UIButton (ARTheme)

- (void)applyStyle:(NSString *)styleName
{
    [super applyStyle:styleName];
    ARTheme *theme = [ARTheme sharedTheme];
    
    NSDictionary *style = [[theme styles] objectForKey:styleName];
    if (style != nil)
    {
        NSArray *keys = [style allKeys];
        for (NSString *key in keys)
        {
            if ([key isEqualToString:@"backgroundImage"])
            {
                UIImage *image = [theme imageFromStyle:[style objectForKey:key]];
                [self setBackgroundImage:image forState:UIControlStateNormal];
            }
            else if ([key isEqualToString:@"backgroundImageHighlighted"])
            {
                UIImage *image = [theme imageFromStyle:[style objectForKey:key]];
                [self setBackgroundImage:image forState:UIControlStateHighlighted];
            }
            else if ([key isEqualToString:@"image"])
            {
                UIImage *image = [theme imageFromStyle:[style objectForKey:key]];
                [self setImage:image forState:UIControlStateNormal];
            }
            else if ([key isEqualToString:@"imageHighlighted"])
            {
                UIImage *image = [theme imageFromStyle:[style objectForKey:key]];
                [self setImage:image forState:UIControlStateHighlighted];
            }
            else if ([key isEqualToString:@"titleColor"])
            {
                UIColor *color = [theme colorFromStyle:[style objectForKey:key]];
                [self setTitleColor:color forState:UIControlStateNormal];
            }
            else if ([key isEqualToString:@"titleColorHighlighted"])
            {
                UIColor *color = [theme colorFromStyle:[style objectForKey:key]];
                [self setTitleColor:color forState:UIControlStateHighlighted];
            }
            else if ([key isEqualToString:@"titleEdgeInsets"])
            {
                NSDictionary *insets = [style objectForKey:key];
                NSNumber *top = [insets objectForKey:@"top"];
                NSNumber *bottom = [insets objectForKey:@"bottom"];
                NSNumber *left = [insets objectForKey:@"left"];
                NSNumber *right = [insets objectForKey:@"right"];
                self.titleEdgeInsets = UIEdgeInsetsMake([top doubleValue], [left doubleValue], [bottom doubleValue], [right doubleValue]);
            }
        }
    }
    else
    {
        NSLog(@"WARNING: %@ style does not exist or is not a object", styleName);
    }
}

@end
