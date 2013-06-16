//
//  UITextField+ARTheme.m
//  ARKit
//
//  Created by Sasha Sheng on 5/9/13.
//  Copyright (c) 2013 AlpineReplay. All rights reserved.
//

#import "UITextField+ARTheme.h"

@implementation UITextField (ARTheme)
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
            if ([key isEqualToString:@"placeholder"])
            {
                self.placeholder = [style objectForKey:key];
            }
            else if ([key isEqualToString:@"font"])
            {
                UIFont *font = [theme fontFromStyle:[style objectForKey:key]];
                self.font = font;
            }
            else if ([key isEqualToString:@"textAlignment"])
            {
                NSTextAlignment align = [theme textAlignmentFromStyle:[style objectForKey:key]];
                [self setTextAlignment:align];
            }
            else if ([key isEqualToString:@"keyboardType"])
            {
                UIKeyboardType keyboardType = [theme keyboardTypeFromStyle:[style objectForKey:key]];
                [self setKeyboardType:keyboardType];
            }
            else if ([key isEqualToString:@"textColor"])
            {
                UIColor *color = [theme colorFromStyle:[style objectForKey:key]];
                self.textColor = color;
            }
            else if ([key isEqualToString:@"background"])
            {
                UIImage *image = [theme imageFromStyle:[style objectForKey:key]];
                [self setBackground:image];
            }
            else if ([key isEqualToString:@"contentVerticalAlignment"])
            {
                UIControlContentVerticalAlignment alignment = [theme contentVerticalAlignmentFromStyle:[style objectForKey:key]];
                self.contentVerticalAlignment = alignment;
            }
            else if ([key isEqualToString:@"contentHorizontalAlignment"])
            {
                UIControlContentHorizontalAlignment alignment = [theme contentHorizontalAlignmentFromStyle:[style objectForKey:key]];
                self.contentHorizontalAlignment = alignment;
            }
        }
    }
    else
    {
        NSLog(@"WARNING: %@ style does not exist or is not a object", styleName);
    }
}

@end
