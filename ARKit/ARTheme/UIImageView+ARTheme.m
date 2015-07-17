//
//  UIImageView+ARTheme.m
//  ARKit
//
//  Created by Brian Bal on 5/7/13.
//  Copyright (c) 2013 AlpineReplay. All rights reserved.
//

#import "UIImageView+ARTheme.h"
#import "ARTheme.h"

@implementation UIImageView (ARTheme)

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
            if ([key isEqualToString:@"image"])
            {
                UIImage *image = [theme imageFromStyle:[style objectForKey:key]];
                self.image = image;
            }
        }
    }
    else
    {
        NSLog(@"WARNING: %@ style does not exist or is not a object", styleName);
    }
}

@end
