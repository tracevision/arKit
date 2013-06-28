//
//  ARTheme.h
//  ARKit
//
//  Created by Brian Bal on 4/26/13.
//  Copyright (c) 2013 AlpineReplay. All rights reserved.
//

#import "ARKit.h"

@interface ARTheme : NSObject

@property (nonatomic, strong) NSString *baseDirectory;
@property (nonatomic, strong) NSDictionary *styles;
@property (nonatomic, strong) NSDictionary *colors;
@property (nonatomic, strong) NSDictionary *fonts;
@property (nonatomic, strong) NSDictionary *images;
@property (nonatomic, strong) NSDictionary *settings;
@property (nonatomic, strong) NSDictionary *strings;
@property (nonatomic, strong) NSNumber *version;
@property (nonatomic, strong) NSString *name;

+ (void)setupWithThemeFile:(NSString *)filePath;
+ (id)sharedTheme;

#pragma mark - Colors
- (UIColor *)colorFromStyle:(NSObject *)style;

#pragma mark - Fonts
- (UIFont *)fontFromStyle:(NSObject *)style;

#pragma mark - Text Attributes
- (NSDictionary *)textAttributesFromStyle:(NSDictionary *)attrs;
- (NSTextAlignment)textAlignmentFromStyle:(NSString *)style;
- (UIControlContentHorizontalAlignment)contentHorizontalAlignmentFromStyle:(NSString *)contentAlignment;
- (UIControlContentVerticalAlignment)contentVerticalAlignmentFromStyle:(NSString *)contentAlignment;
- (UIKeyboardType)keyboardTypeFromStyle:(NSString *)style;

#pragma mark - Images
- (UIImage *)imageFromStyle:(NSObject *)style;
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color cornerRadius:(CGFloat)radius;

#pragma mark - Settings

- (NSNumber *)numberForSetting:(NSString *)key default:(NSNumber *)defaultValue;
- (BOOL)boolForSetting:(NSString *)key;
- (int)intForKey:(NSString *)key;
- (NSString *)stringForSetting:(NSString *)key default:(NSString *)defaultValue;
- (NSDictionary *)dictionaryForSetting:(NSString *)key;

@end
