//
//  UISegmentedControl+ARTheme.m
//  ARKit
//
//  Created by Brian Bal on 4/30/13.
//  Copyright (c) 2013 AlpineReplay. All rights reserved.
//

#import "UISegmentedControl+ARTheme.h"
#import "UIView+ARTheme.h"
#import "ARTheme.h"

@implementation UISegmentedControl (ARTheme)

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
            if ([key isEqualToString:@"titleTextAttributes"])
            {
                NSDictionary *attrs = [theme textAttributesFromStyle:[style objectForKey:key]];
                [self setTitleTextAttributes:attrs forState:UIControlStateNormal];
            }
            else if ([key isEqualToString:@"titleTextAttributesSelected"])
            {
                NSDictionary *attrs = [theme textAttributesFromStyle:[style objectForKey:key]];
                [self setTitleTextAttributes:attrs forState:UIControlStateSelected];
            }
            else if ([key isEqualToString:@"backgroundImage"])
            {
                UIImage *image = [theme imageFromStyle:[style objectForKey:key]];
                [self setBackgroundImage:image forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
            }
            else if ([key isEqualToString:@"backgroundImageSelected"])
            {
                UIImage *image = [theme imageFromStyle:[style objectForKey:key]];
                [self setBackgroundImage:image forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
            }
            else if ([key isEqualToString:@"dividerImage"])
            {
                UIImage *image = [theme imageFromStyle:[style objectForKey:key]];
                [self setDividerImage:image forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
            }
        }
    }
    else
    {
        NSLog(@"WARNING: %@ style does not exist or is not a object", styleName);
    }
}

@end
