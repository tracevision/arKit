//
//  Util.m
//  AlpineReplay
//
//  Created by Brian Bal on 3/20/13.
//
//

#import "ARAppUtil.h"

@implementation ARAppUtil

+ (BOOL)isSimulator
{
    BOOL val = false;
    NSString *model = [[UIDevice currentDevice] model];
    if ([model isEqualToString:@"iPhone Simulator"])
    {
        val = true;
    }
    return val;
}

+ (NSString *)iosVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

+ (BOOL)iosVersionEqualOrGreaterThan:(NSString *)version
{
    BOOL val = NO;
    NSComparisonResult result = [[ARAppUtil iosVersion] compare:@"6.0"];
    if (result == NSOrderedDescending || result == NSOrderedSame)
    {
        val = YES;
    }
    return val;
}

+ (BOOL)isIphone
{
    UIUserInterfaceIdiom idiom = [[UIDevice currentDevice] userInterfaceIdiom];
    return idiom == UIUserInterfaceIdiomPhone;
}

+ (BOOL)isIphone5
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    BOOL val = NO;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height > 480.0f)
        {
            val = YES;
        }
    }
    
    return val;
}

+ (BOOL)isIpad
{
    UIUserInterfaceIdiom idiom = [[UIDevice currentDevice] userInterfaceIdiom];
    return idiom == UIUserInterfaceIdiomPad;
}

+ (BOOL)isRetina
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && [[UIScreen mainScreen] scale] == 2.0)
    {
        return true;
    }
    else
    {
        return false;
    }
}

@end
