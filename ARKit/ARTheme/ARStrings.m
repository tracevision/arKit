//
//  ARStrings.m
//  ARKit
//
//  Created by Brian Bal on 5/3/13.
//  Copyright (c) 2013 AlpineReplay. All rights reserved.
//

#import "ARStrings.h"

@implementation ARStrings

+ (NSString *)localizedString:(NSString *)key
{
    NSString *value = [[NSBundle mainBundle] localizedStringForKey:key value:key table:nil];
    if ([value isEqualToString:key])
    {
        NSBundle *defaultBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj" ]];
        value = [defaultBundle localizedStringForKey:key value:nil table:nil];
        NSLog(@"******************* No Translation found for key %@", key);
    }
    return value;
}

+ (NSString *)localized:(NSString *)key
{
    return [self localizedString:key];
}

@end
