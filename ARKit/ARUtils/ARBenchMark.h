//
//  BenchMark.h
//  AlpineReplay
//
//  Created by Brian Bal on 4/4/13.
//
//

#import "ARKit.h"

@interface ARBenchMark : NSObject

@property (nonatomic, strong) NSMutableDictionary *marks;

+ (void)start:(NSString *)name;
+ (void)report:(NSString *)name report:(NSString *)report;
+ (void)stop:(NSString *)name;
+ (void)warn:(NSString *)name maxSeconds:(double)maxSeconds;
+ (void)warn:(NSString *)name;

@end
