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
@synthesize settings;

+ (id)sharedTheme
{
    static dispatch_once_t onceQueue;
    static ARTheme *aRTheme = nil;
    
    dispatch_once(&onceQueue, ^{ aRTheme = [[self alloc] init]; });
    return aRTheme;
}

+ (void)setupWithThemeFile:(NSString *)filePath
{
    NSMutableDictionary *styles = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *colors = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *fonts = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *images = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *strings = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *settings = [[NSMutableDictionary alloc] init];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    // NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // NSString *documentDirectory = [paths objectAtIndex:0];
    NSDictionary *themeDictionary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:NSJSONReadingAllowFragments error:nil];
    NSString *baseDir = [filePath stringByReplacingOccurrencesOfString:[filePath lastPathComponent] withString:@""];
    
    NSArray *stylesFiles = [themeDictionary objectForKey:@"styles"];
    if (stylesFiles != nil)
    {
        for (NSString *file in stylesFiles)
        {
            NSString *path = [NSString stringWithFormat:@"%@%@", baseDir, file];
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingAllowFragments error:nil];
            [styles addEntriesFromDictionary:dictionary];
        }
    }
    
    NSArray *colorFiles = [themeDictionary objectForKey:@"colors"];
    if (colorFiles != nil)
    {
        for (NSString *file in colorFiles)
        {
            NSString *path = [NSString stringWithFormat:@"%@%@", baseDir, file];
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingAllowFragments error:nil];
            [colors addEntriesFromDictionary:dictionary];
        }
    }
    
    NSArray *fontFiles = [themeDictionary objectForKey:@"fonts"];
    if (fontFiles != nil)
    {
        for (NSString *file in fontFiles)
        {
            NSString *path = [NSString stringWithFormat:@"%@%@", baseDir, file];
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingAllowFragments error:nil];
            [fonts addEntriesFromDictionary:dictionary];
        }
    }
    
    NSArray *imageFiles = [themeDictionary objectForKey:@"images"];
    if (imageFiles != nil)
    {
        for (NSString *file in imageFiles)
        {
            NSString *path = [NSString stringWithFormat:@"%@%@", baseDir, file];
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingAllowFragments error:nil];
            [images addEntriesFromDictionary:dictionary];
        }
    }
    
    // Load Localized String File
    NSString *localIdentifier = [[NSLocale currentLocale] localeIdentifier];
    NSString *currentLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSMutableArray *stringFiles = [[NSMutableArray alloc] init];
    [stringFiles addObject:[NSString stringWithFormat:@"%@strings.json", baseDir]];
    [stringFiles addObject:[NSString stringWithFormat:@"%@strings_%@.json", baseDir, currentLanguage]];
    [stringFiles addObject:[NSString stringWithFormat:@"%@strings_%@.json", baseDir, localIdentifier]];
    for (NSString *file in stringFiles)
    {
        if ([fm fileExistsAtPath:file])
        {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:file] options:NSJSONReadingAllowFragments error:nil];
            [strings addEntriesFromDictionary:dictionary];
        }
    }
    
    NSString *settingsFile = [NSString stringWithFormat:@"%@settings.json", baseDir];
    if ([fm fileExistsAtPath:settingsFile])
    {
        settings = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:settingsFile] options:NSJSONReadingAllowFragments error:nil];
    }
    
    
    ARTheme *theme = [self sharedTheme];
    theme.baseDirectory = baseDir;
    theme.styles = styles;
    theme.colors = colors;
    theme.fonts = fonts;
    theme.images = images;
    theme.strings = strings;
    theme.settings = settings;
    theme.version = [themeDictionary objectForKey:@"version"];
    theme.name = [themeDictionary objectForKey:@"name"];
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
        self.settings = @{};
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
            UIImage *image = [self imageFromStyle:imageName];
            if (image == nil) {
                image = [UIImage imageNamed:imageName];
            }
            color = [UIColor colorWithPatternImage:image];
            if (color == nil)
            {
                color = [UIColor colorWithPatternImage:[self.colors objectForKey:imageName]];
            }
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

- (UIControlContentVerticalAlignment)contentVerticalAlignmentFromStyle:(NSString *)contentAlignment
{
    UIControlContentVerticalAlignment alignment = UIControlContentVerticalAlignmentCenter;
    if ([contentAlignment isEqualToString:@"bottom"])
    {
        alignment = UIControlContentVerticalAlignmentBottom;
    }
    else if ([contentAlignment isEqualToString:@"center"])
    {
        alignment = UIControlContentVerticalAlignmentCenter;
    }
    else if ([contentAlignment isEqualToString:@"fill"])
    {
        alignment = UIControlContentVerticalAlignmentFill;
    }
    else if ([contentAlignment isEqualToString:@"top"])
    {
        alignment = UIControlContentVerticalAlignmentTop;
    }
    
    return alignment;
}

- (UIControlContentHorizontalAlignment)contentHorizontalAlignmentFromStyle:(NSString *)contentAlignment
{
    UIControlContentHorizontalAlignment alignment = UIControlContentHorizontalAlignmentCenter;
    if ([contentAlignment isEqualToString:@"left"])
    {
        alignment = UIControlContentHorizontalAlignmentLeft;
    }
    else if ([contentAlignment isEqualToString:@"center"])
    {
        alignment = UIControlContentHorizontalAlignmentCenter;
    }
    else if ([contentAlignment isEqualToString:@"fill"])
    {
        alignment = UIControlContentHorizontalAlignmentFill;
    }
    else if ([contentAlignment isEqualToString:@"right"])
    {
        alignment = UIControlContentHorizontalAlignmentRight;
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




#pragma mark - Images


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
            NSString *imageStyle = [self.images objectForKey:i];
            if (imageStyle != nil && [imageStyle isKindOfClass:[NSString class]])
            {
                image = [self imageWithName:imageStyle];
            }
            else if (imageStyle != nil && [imageStyle isKindOfClass:[NSDictionary class]])
            {
                image = [self imageFromStyle:imageStyle];
            }
            
            if (image == nil)
            {
                image = [self imageWithName:i];
            }
            
            if (image == nil)
            {
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
            }
        }
        else
        {
            NSLog(@"WARNING[imageFromStyle in ARTheme]: image.json sheet has issues");
        }
    }
    else if ([style isKindOfClass:[NSString class]])
    {
        NSString *imageStyle = [self.images objectForKey:style];
        if ([imageStyle isKindOfClass:[NSString class]])
        {
            image = [self imageWithName:imageStyle];
        }
        else
        {
            image = [self imageFromStyle:imageStyle];
        }
    }
    
    return image;
}

- (UIImage *)imageWithName:(NSString *)imageName
{
    UIImage *image;
    
    if ([imageName hasPrefix:@"@theme/"])
    {
        NSString *imageFile = [imageName stringByReplacingOccurrencesOfString:@"@theme/" withString:self.baseDirectory];
        NSString *imageFile2x = [imageFile stringByAppendingString:@"@2x.png"];
        imageFile = [imageFile stringByAppendingString:@".png"];
        
        NSFileManager *fm = [NSFileManager defaultManager];
        if ([ARAppUtil isRetina] && [fm fileExistsAtPath:imageFile2x])
        {
            image = [UIImage imageWithContentsOfFile:imageFile2x];
        }
        else if ([fm fileExistsAtPath:imageFile])
        {
            image = [UIImage imageWithContentsOfFile:imageFile];
        }
    }
    else
    {
        image = [UIImage imageNamed:imageName];
    }
    
    return image;
}

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



#pragma mark - Settings

- (NSNumber *)numberForSetting:(NSString *)key default:(NSNumber *)defaultValue
{
    NSNumber *val = [self.settings objectForKey:key];
    if (val == nil || ![val isKindOfClass:[NSNumber class]])
    {
        val = defaultValue;
    }
    
    return val;
}

- (BOOL)boolForSetting:(NSString *)key
{
    NSNumber *val = [self numberForSetting:key default:@NO];
    return [val boolValue];
}

- (int)intForKey:(NSString *)key
{
    NSNumber *val = [self numberForSetting:key default:@0];
    return [val integerValue];
}

- (NSString *)stringForSetting:(NSString *)key default:(NSString *)defaultValue
{
    NSString *val = [self.settings objectForKey:key];
    if (val == nil || ![val isKindOfClass:[NSString class]])
    {
        val = defaultValue;
    }
    
    return val;
}

- (NSDictionary *)dictionaryForSetting:(NSString *)key
{
    NSDictionary *val = [self.settings objectForKey:key];
    if (val == nil || ![val isKindOfClass:[NSDictionary class]])
    {
        val = nil;
    }
    
    return val;
}



#pragma mark - Properties & Methods

-(id)valueForProperty:(NSObject *)key forClass:(Class)class withStyle:(NSDictionary *)style
{
    id value;
    
    if ([[style objectForKey:key] isKindOfClass:[NSString class]])
    {
        objc_property_t property = class_getProperty(class, [(NSString *)key UTF8String]);
        const char * propertyAttributes = property_getAttributes(property);
        NSString *propertyString = [NSString stringWithUTF8String:propertyAttributes];
        NSArray * attributesArray = [propertyString componentsSeparatedByString:@","];
        NSString * typeAttribute = [attributesArray objectAtIndex:0];
        NSString * typeClassName = [typeAttribute substringWithRange:NSMakeRange(3, [typeAttribute length]-4)];
    
        if ([typeClassName isEqualToString:@"c"]) {
            //it's a bool
            value = [style objectForKey:key];
        }
        else if ([typeClassName isEqualToString:@"i"]) {
            //it's an int
            NSValue *number = [style objectForKey:key];
            value = number;
        }
        else if ([typeClassName isEqualToString:@"UIColor"]) {
            //it's a color
            UIColor *color = [self colorFromStyle:[style objectForKey:key]];
            value = color;
        }
        else if ([typeClassName isEqualToString:@"UIImage"]) {
            //its an image
            UIImage *image = [self imageFromStyle:[style objectForKey:key]];
            value = image;
        }
        else if ([typeClassName isEqualToString:@"UIFont"]) {
            //its a font
            UIFont *font = [self fontFromStyle:[style objectForKey:key]];
            value = font;
        }
        else if ([typeClassName isEqualToString:@"NSString"]) {
            //its a font
            NSString *string = [style objectForKey:key];
            value = string;
        }
        // handle additional possible types here
        else {
            NSLog(@"Type not recognized for: %@", key);
            value = nil;
        }
    }
    
    return value;
}

-(NSMutableArray *)propertyArrayForClass:(Class)class
{
    unsigned count;
    objc_property_t* properties = class_copyPropertyList(class, &count);
    NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count ; i++)
    {   const char* propertyName = property_getName(properties[i]);
        [propertyArray addObject:[NSString  stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
    }
    free(properties);
    
    return propertyArray;
}

-(NSMutableArray *)methodArrayForClass:(Class)class
{
    unsigned count;
    Method *methods = class_copyMethodList(class, &count);
    NSMutableArray* methodArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++)
    {   if ([NSStringFromSelector(method_getName(methods[i])) rangeOfString:@"_"].location == NSNotFound) {
            [methodArray addObject:NSStringFromSelector(method_getName(methods[i]))];
        }
    }
    free(methods);
    
    return methodArray;
}

@end
