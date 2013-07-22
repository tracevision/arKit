//
//  ARStrings.m
//  ARKit
//
//  Created by Brian Bal on 5/3/13.
//  Copyright (c) 2013 AlpineReplay. All rights reserved.
//

#import "ARStrings.h"
#import "ARTheme.h"

@implementation ARStrings

+ (NSString *)localized:(NSString *)key
{
    ARTheme *theme = [ARTheme sharedTheme];
    NSString *val = [theme.strings objectForKey:key];
    if (val == nil || ! [val isKindOfClass:[NSString class]])
    {
        val = key;
        NSLog(@"\n\n ***** WARNING: ARString string not found for key \"%@\" *****\n\n", key);
    }
    return val;
}

+ (NSArray *)localizedArray:(NSString *)key
{
    ARTheme *theme = [ARTheme sharedTheme];
    NSArray *val = [theme.strings objectForKey:key];
    if (val == nil || ! [val isKindOfClass:[NSArray class]])
    {
        val = @[];
        NSLog(@"\n\n ***** WARNING: ARString array not found for key \"%@\" *****\n\n", key);
    }
    return val;
}

@end
