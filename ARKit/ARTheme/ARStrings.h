//
//  ARStrings.h
//  ARKit
//
//  Created by Brian Bal on 5/3/13.
//  Copyright (c) 2013 AlpineReplay. All rights reserved.
//

#import "ARKit.h"

@interface ARStrings : NSObject

+ (NSString *)localized:(NSString *)key;
+ (NSArray *)localizedArray:(NSString *)key;

@end
