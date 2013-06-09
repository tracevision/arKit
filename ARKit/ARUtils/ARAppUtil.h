//
//  Util.h
//  AlpineReplay
//
//  Created by Brian Bal on 3/20/13.
//
//

#import "ARKit.h"

@interface ARAppUtil : NSObject

+ (BOOL)isSimulator;
+ (NSString *)iosVersion;
+ (BOOL)iosVersionEqualOrGreaterThan:(NSString *)version;

+ (BOOL)isIphone;
+ (BOOL)isIphone5;
+ (BOOL)isIpad;
+ (BOOL)isRetina;

@end
