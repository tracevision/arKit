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
    NSString *stylesPath = [path stringByAppendingPathComponent:@"styles.json"];
    NSDictionary *styles = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:stylesPath] options:NSJSONReadingAllowFragments error:nil];
    
    NSString *colorsPath = [path stringByAppendingPathComponent:@"colors.json"];
    NSDictionary *colors = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:colorsPath] options:NSJSONReadingAllowFragments error:nil];
    
    NSString *fontsPath = [path stringByAppendingPathComponent:@"fonts.json"];
    NSDictionary *fonts = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:fontsPath] options:NSJSONReadingAllowFragments error:nil];
    
    NSString *imagesPath = [path stringByAppendingPathComponent:@"images.json"];
    NSDictionary *images = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:imagesPath] options:NSJSONReadingAllowFragments error:nil];
    
    NSString *stringsPath = [path stringByAppendingPathComponent:@"strings.json"];
    NSDictionary *strings = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:stringsPath] options:NSJSONReadingAllowFragments error:nil];
    
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
        if (c != nil)
        {
            UIColor *color = [self colorFromStyle:c];
            double radius = [[s objectForKey:@"radius"] doubleValue];
            image = [ARTheme imageWithColor:color cornerRadius:radius];
        }
        else if (i != nil)
        {
            image = [UIImage imageNamed:i];
            NSDictionary *insets = [s objectForKey:@"insets"];
            if (insets != nil)
            {
                NSNumber *top = [insets objectForKey:@"top"];
                NSNumber *bottom = [insets objectForKey:@"bottom"];
                NSNumber *left = [insets objectForKey:@"left"];
                NSNumber *right = [insets objectForKey:@"right"];
                image = [image resizableImageWithCapInsets:UIEdgeInsetsMake([top doubleValue], [left doubleValue], [bottom doubleValue], [right doubleValue])];
            }
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
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // CGContextFillRect(context, rect);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    [path fill];
    CGContextAddPath(context, path.CGPath);
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(radius, radius, radius, radius)];
    
    return image;
}

+ (UIImage *)imageWithGradientFrom:(UIColor *)color to:(UIColor *)color2
{
    // TODO: implement this function
    return nil;
}

@end
