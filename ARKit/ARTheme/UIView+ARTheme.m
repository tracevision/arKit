//
//  UIView+ARTheme.m
//  ARKit
//
//  Created by Brian Bal on 4/29/13.
//  Copyright (c) 2013 AlpineReplay. All rights reserved.
//

#import "UIView+ARTheme.h"
#import "ARTheme.h"


@implementation UIView (ARTheme)

- (void)applyStyle:(NSString *)styleName
{
    ARTheme *theme = [ARTheme sharedTheme];
    
    NSDictionary *style = [[theme styles] objectForKey:styleName];
    if (style != nil)
    {
        NSArray *keys = [style allKeys];
        for (NSString *key in keys)
        {
            if ([key isEqualToString:@"backgroundColor"])
            {
                UIColor *color = [theme colorFromStyle:[style objectForKey:key]];
                self.backgroundColor = color;
            }
        }
    }
    else
    {
        NSLog(@"WARNING: %@ style does not exist or is not a object", styleName);
    }
}

@end
