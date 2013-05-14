//
//  ARTheme.m
//  ARKit
//
//  Created by Brian Bal on 4/26/13.
//  Copyright (c) 2013 AlpineReplay. All rights reserved.
//

#import "ARKit.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>

@implementation ARTheme

@synthesize styles;
@synthesize colors;
@synthesize fonts;
@synthesize images;
@synthesize strings;

+ (id)sharedTheme
{
    static dispatch_once_t onceQueue;
    static ARTheme *aRTheme = nil;
    
    dispatch_once(&onceQueue, ^{ aRTheme = [[self alloc] init]; });
    return aRTheme;
}

+ (void)setupWithThemePath:(NSString *)path
{
    NSMutableDictionary *styles = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *colors = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *fonts = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *images = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *strings = [[NSMutableDictionary alloc] init];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *dirContents = [fm contentsOfDirectoryAtPath:path error:nil];
    for (NSString *file in dirContents)
    {
        if ([file hasSuffix:@".json"])
        {
            if ([[file lastPathComponent] hasPrefix:@"styles"])
            {
                NSString *filePath = [NSString stringWithFormat:@"%@/%@", path, file];
                NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:NSJSONReadingAllowFragments error:nil];
                [styles addEntriesFromDictionary:dictionary];
            }
            else if ([[file lastPathComponent] hasPrefix:@"colors"])
            {
                NSString *filePath = [NSString stringWithFormat:@"%@/%@", path, file];
                NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:NSJSONReadingAllowFragments error:nil];
                [colors addEntriesFromDictionary:dictionary];
            }
            else if ([[file lastPathComponent] hasPrefix:@"fonts"])
            {
                NSString *filePath = [NSString stringWithFormat:@"%@/%@", path, file];
                NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:NSJSONReadingAllowFragments error:nil];
                [fonts addEntriesFromDictionary:dictionary];
            }
            else if ([[file lastPathComponent] hasPrefix:@"images"])
            {
                NSString *filePath = [NSString stringWithFormat:@"%@/%@", path, file];
                NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:NSJSONReadingAllowFragments error:nil];
                [images addEntriesFromDictionary:dictionary];
            }
            else if ([[file lastPathComponent] hasPrefix:@"strings"])
            {
                NSString *filePath = [NSString stringWithFormat:@"%@/%@", path, file];
                NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:NSJSONReadingAllowFragments error:nil];
                [strings addEntriesFromDictionary:dictionary];
            }
        }
    }
    
    ARTheme *theme = [self sharedTheme];
    
    theme.styles = styles;
    theme.colors = colors;
    theme.fonts = fonts;
    theme.images = images;
    theme.strings = strings;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.styles = @{};
        self.colors = @{};
        self.fonts = @{};
        self.images = @{};
        self.strings = @{};
    }
    return self;
}


#pragma mark - Colors

- (UIColor *)colorFromStyle:(NSObject *)style
{
    UIColor *color;
    
    if ([style isKindOfClass:[NSString class]])
    {
        if ([((NSString *)style) hasPrefix:@"#"])
        {
            color = [((NSString *)style) toColor];
        }
        else
        {
            NSObject *colorStyle = [self.colors objectForKey:style];
            color = [self colorFromStyle:colorStyle];
        }
    }
    else if ([style isKindOfClass:[NSDictionary class]])
    {
        NSString *colorName = [((NSDictionary *)style) objectForKey:@"color"];
        NSString *imageName = [((NSDictionary *)style) objectForKey:@"image"];
        
        if (colorName != nil)
        {
            color = [colorName toColor];
        }
        else if (imageName != nil)
        {
            color = [UIColor colorWithPatternImage:[UIImage imageNamed:imageName]];
        }
    }
    
    return color;
}


#pragma mark - Fonts

- (UIFont *)fontFromStyle:(NSObject *)style
{
    UIFont *font;
    
    if ([style isKindOfClass:[NSDictionary class]])
    {
        font = [UIFont fontWithName:[((NSDictionary *)style) objectForKey:@"name"] size:[[((NSDictionary *)style) objectForKey:@"size"] doubleValue]];
    }
    else if ([style isKindOfClass:[NSString class]])
    {
        NSObject *fontStyle = [self.fonts objectForKey:style];
        font = [self fontFromStyle:fontStyle];
    }
    
    return font;
}


#pragma mark - Text Attributes

- (NSDictionary *)textAttributesFromStyle:(NSDictionary *)attrs
{
    NSMutableDictionary *textAttributes = [[NSMutableDictionary alloc] init];
    
    NSArray *keys = [attrs allKeys];
    for (NSString *key in keys)
    {
        if ([key isEqualToString:@"font"])
        {
            UIFont *font = [self fontFromStyle:[attrs objectForKey:key]];
            [textAttributes setObject:font forKey:UITextAttributeFont];
        }
        else if ([key isEqualToString:@"textColor"])
        {
            UIColor *color = [self colorFromStyle:[attrs objectForKey:key]];
            [textAttributes setObject:color forKey:UITextAttributeTextColor];
        }
        else if ([key isEqualToString:@"shadowColor"])
        {
            UIColor *color = [self colorFromStyle:[attrs objectForKey:key]];
            [textAttributes setObject:color forKey:UITextAttributeTextShadowColor];
        }
    }
    
    return textAttributes;
}

- (NSTextAlignment)textAlignmentFromStyle:(NSString *)style
{
    NSTextAlignment alignment = NSTextAlignmentLeft;
    
    if ([style isEqualToString:@"center"])
    {
        alignment = NSTextAlignmentCenter;
    }
    else if ([style isEqualToString:@"left"])
    {
        alignment = NSTextAlignmentLeft;
    }
    else if ([style isEqualToString:@"right"])
    {
        alignment = NSTextAlignmentRight;
    }
    else if ([style isEqualToString:@"justified"])
    {
        alignment = NSTextAlignmentJustified;
    }
    else if ([style isEqualToString:@"natural"])
    {
        alignment = NSTextAlignmentNatural;
    }
    
    return alignment;
}

- (UIKeyboardType)keyboardTypeFromStyle:(NSString *)style
{
    UIKeyboardType keyboardType = UIKeyboardTypeDefault;
    
    if ([style isEqualToString:@"default"])
    {
        keyboardType = UIKeyboardTypeDefault;
    }
    else if ([style isEqualToString:@"alphabet"])
    {
        keyboardType = UIKeyboardTypeAlphabet;
    }
    else if ([style isEqualToString:@"ascii"])
    {
        keyboardType = UIKeyboardTypeASCIICapable;
    }
    else if ([style isEqualToString:@"decimal"])
    {
        keyboardType = UIKeyboardTypeDecimalPad;
    }
    else if ([style isEqualToString:@"email"])
    {
        keyboardType = UIKeyboardTypeEmailAddress;
    }
    else if ([style isEqualToString:@"name_phone"])
    {
        keyboardType = UIKeyboardTypeNamePhonePad;
    }
    else if ([style isEqualToString:@"number"])
    {
        keyboardType = UIKeyboardTypeNumberPad;
    }
    else if ([style isEqualToString:@"number_punctuation"])
    {
        keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    }
    else if ([style isEqualToString:@"phone"])
    {
        keyboardType = UIKeyboardTypePhonePad;
    }
    else if ([style isEqualToString:@"twitter"])
    {
        keyboardType = UIKeyboardTypeTwitter;
    }
    else if ([style isEqualToString:@"url"])
    {
        keyboardType = UIKeyboardTypeURL;
    }
    return keyboardType;
}

- (UIImage *)imageFromStyle:(NSObject *)style
{
    UIImage *image;
    
    if ([style isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *s = (NSDictionary *)style;
        NSString *c = [s objectForKey:@"color"];
        NSString *i = [s objectForKey:@"image"];
        if (c != nil && i == nil)
        {
            UIColor *color = [self colorFromStyle:c];
            double radius = [[s objectForKey:@"radius"] doubleValue];
            image = [ARTheme imageWithColor:color cornerRadius:radius];
        }
        else if (i != nil && c == nil)
        {
            image = [UIImage imageNamed:i];
            if (image == nil) {
                image = [UIImage imageNamed:[self.images objectForKey:i]];
            }
            
            NSDictionary *insets = [s objectForKey:@"insets"];
            if (insets != nil)
            {
                NSNumber *top = [insets objectForKey:@"top"];
                NSNumber *bottom = [insets objectForKey:@"bottom"];
                NSNumber *left = [insets objectForKey:@"left"];
                NSNumber *right = [insets objectForKey:@"right"];
                image = [image resizableImageWithCapInsets:UIEdgeInsetsMake([top doubleValue], [left doubleValue], [bottom doubleValue], [right doubleValue])];
            } else {
                NSLog(@"WARNING[imageFromStyle in ARTheme]: image not found");
            }
        } else {
            NSLog(@"WARNING[imageFromStyle in ARTheme]: image.json sheet has issues");
        }
    }
    else if ([style isKindOfClass:[NSString class]])
    {
        NSString *imageStyle = [self.images objectForKey:style];
        image = [UIImage imageNamed:imageStyle];
    }
    
    return image;
}

#pragma mark - Images

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color cornerRadius:(CGFloat)radius
{
    CGFloat length = (radius * 2.0f) + 1;
    CGRect rect = CGRectMake(0.0f, 0.0f, length, length);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [color CGColor]);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    [path setFlatness:0.1];
    [path fill];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    image = [image stretchableImageWithLeftCapWidth:radius topCapHeight:radius];
    
    return image;
}

+ (UIImage *)imageWithGradientFrom:(UIColor *)color to:(UIColor *)color2
{
    // TODO: implement this function
    return nil;
}

@end
