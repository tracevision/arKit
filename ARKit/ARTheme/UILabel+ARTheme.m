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
        NSArray *properties = [theme propertyArrayForClass:[self class]];
        for (NSString *key in keys)
        {
            //dynamically set the property
            for (NSString *property in properties)
            {
                if ([property isEqualToString:key])
                {
                    id value = [theme valueForProperty:property forClass:[self class] withStyle:style];
                    if (value != nil) {
                        [self setValue:value forKey:key];
                    }
                }
            }
            
            //explicitly set the property
            if ([key isEqualToString:@"textColor"])
            {
                UIColor *color = [theme colorFromStyle:[style objectForKey:key]];
                self.textColor = color;
            }
            else if ([key isEqualToString:@"textColorHighlighted"])
            {
                UIColor *color = [theme colorFromStyle:[style objectForKey:key]];
                [self setHighlightedTextColor:color];
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
            else if ([key isEqualToString:@"shadowOffset"])
            {
                NSDictionary *val = [style objectForKey:key];
                double w = [[val objectForKey:@"width"] doubleValue];
                double h = [[val objectForKey:@"height"] doubleValue];
                [self setShadowOffset:CGSizeMake(w, h)];
            }
            else if ([key isEqualToString:@"shadowColor"]) {
                UIColor *color = [theme colorFromStyle:[style objectForKey:key]];
                [self setShadowColor:color];
            }
        }
    }
    else
    {
        NSLog(@"WARNING: %@ style does not exist or is not a object", styleName);
    }
}

@end
