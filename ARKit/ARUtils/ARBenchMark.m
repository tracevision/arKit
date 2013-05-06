//
//  BenchMark.m
//  AlpineReplay
//
//  Created by Brian Bal on 4/4/13.
//
//

#import "ARBenchMark.h"

@implementation ARBenchMark

@synthesize marks;

+ (id)sharedBenchMark
{
    static dispatch_once_t onceQueue;
    static ARBenchMark *benchMark = nil;
    
    dispatch_once(&onceQueue, ^{ benchMark = [[self alloc] init]; });
    return benchMark;
}

+ (void)start:(NSString *)name
{
    [[ARBenchMark sharedBenchMark] start:name];
}

+ (void)report:(NSString *)name report:(NSString *)report
{
    [[ARBenchMark sharedBenchMark] report:name report:report];
}

+ (void)stop:(NSString *)name
{
    [[ARBenchMark sharedBenchMark] stop:name];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.marks = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)start:(NSString *)name
{
    [self.marks setObject:[NSNumber numberWithDouble:CFAbsoluteTimeGetCurrent()] forKey:name];
}

- (void)report:(NSString *)name report:(NSString *)report
{
    NSNumber *start = [self.marks objectForKey:report];
    double total = CFAbsoluteTimeGetCurrent() - [start doubleValue];
    NSLog(@"bench: %@ %@ %f", name, report, total);
}

- (void)stop:(NSString *)name
{
    NSNumber *start = [self.marks objectForKey:name];
    double total = CFAbsoluteTimeGetCurrent() - [start doubleValue];
    NSLog(@"bench: %@ %f", name, total);
}
@end
