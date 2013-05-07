//
//  UILabel+ARTheme.m
//  ARKit
//
//  Created by Brian Bal on 4/29/13.
//  Copyright (c) 2013 AlpineReplay. All rights reserved.
//

#import "UILabel+ARTheme.h"
#import "UIView+ARTheme.h"
#import "ARTheme.h"

@implementation UILabel (ARTheme)

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
            if ([key isEqualToString:@"textColor"])
            {
                UIColor *color = [theme colorFromStyle:[style objectForKey:key]];
                self.textColor = color;
            }
            else if ([key isEqualToString:@"font"])
            {
                UIFont *font = [theme fontFromStyle:[style objectForKey:key]];
                self.font = font;
            }
            else if ([key isEqualToString:@"textAlignment"])
            {
                NSTextAlignment alignment = [theme textAlignmentFromStyle:[style objectForKey:key]];
                self.textAlignment = alignment;
            }
            else if ([key isEqualToString:@"minimumScaleFactor"])
            {
                self.minimumScaleFactor = [[style objectForKey:key] doubleValue];
            }
            else if ([key isEqualToString:@"adjustsFontSizeToFitWidth"])
            {
                self.adjustsFontSizeToFitWidth = [[style objectForKey:key] boolValue];
            }
            else if ([key isEqualToString:@"numberOfLines"])
            {
                self.numberOfLines = [[style objectForKey:key] integerValue];
            }
        }
    }
    else
    {
        NSLog(@"WARNING: %@ style does not exist or is not a object", styleName);
    }
}

@end
