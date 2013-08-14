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
            else if ([key isEqualToString:@"tintColor"])
            {
                UIColor *color = [theme colorFromStyle:[style objectForKey:key]];
                self.tintColor = color;
            }
            else if ([key isEqualToString:@"clipsToBounds"])
            {
                NSNumber *val = [style objectForKey:key];
                self.clipsToBounds = [val boolValue];
            }
            else if ([key isEqualToString:@"layer"])
            {
                NSDictionary *layerStyle = [style objectForKey:key];
                NSArray *layerKeys = [layerStyle allKeys];
                for (NSString *layerKey in layerKeys)
                {
                    if ([layerKey isEqualToString:@"borderColor"])
                    {
                        UIColor *color = [theme colorFromStyle:[layerStyle objectForKey:layerKey]];
                        self.layer.borderColor = color.CGColor;
                    }
                    else if ([layerKey isEqualToString:@"borderWidth"])
                    {
                        NSNumber *val = [layerStyle objectForKey:layerKey];
                        self.layer.borderWidth = [val doubleValue];
                    }
                    else if ([layerKey isEqualToString:@"shadowColor"])
                    {
                        UIColor *color = [theme colorFromStyle:[layerStyle objectForKey:layerKey]];
                        self.layer.shadowColor = color.CGColor;
                    }
                    else if ([layerKey isEqualToString:@"shadowOpacity"])
                    {
                        NSNumber *val = [layerStyle objectForKey:layerKey];
                        self.layer.shadowOpacity = [val doubleValue];
                    }
                    else if ([layerKey isEqualToString:@"shadowRadius"])
                    {
                        NSNumber *val = [layerStyle objectForKey:layerKey];
                        self.layer.shadowRadius = [val doubleValue];
                    }
                    else if ([layerKey isEqualToString:@"shadowOffset"])
                    {
                        NSDictionary *val = [layerStyle objectForKey:layerKey];
                        double w = [[val objectForKey:@"width"] doubleValue];
                        double h = [[val objectForKey:@"height"] doubleValue];
                        self.layer.shadowOffset = CGSizeMake(w, h);
                    }
                    else if ([layerKey isEqualToString:@"cornerRadius"])
                    {
                        NSNumber *val = [layerStyle objectForKey:layerKey];
                        self.layer.cornerRadius = [val doubleValue];
                    }
                    else if ([layerKey isEqualToString:@"opacity"])
                    {
                        NSNumber *val = [layerStyle objectForKey:layerKey];
                        self.layer.opacity = [val doubleValue];
                    }
                }
            }
        }
    }
    else
    {
        NSLog(@"WARNING: %@ style does not exist or is not a object", styleName);
    }
}

@end
