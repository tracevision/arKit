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
    // TODO: find a good way to localize these
    ARTheme *theme = [ARTheme sharedTheme];
    NSString *val = [theme.strings objectForKey:key];
    if (val == nil)
    {
        val = key;
        NSLog(@"\n\n ***** WARNING: ARString string not found for key \"%@\" *****\n\n", key);
    }
    return val;
}

@end
