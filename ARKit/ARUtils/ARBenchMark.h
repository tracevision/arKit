//
//  BenchMark.h
//  AlpineReplay
//
//  Created by Brian Bal on 4/4/13.
//
//

#import <Foundation/Foundation.h>

@interface ARBenchMark : NSObject

@property (nonatomic, strong) NSMutableDictionary *marks;

+ (void)start:(NSString *)name;
+ (void)report:(NSString *)name report:(NSString *)report;
+ (void)stop:(NSString *)name;

@end
