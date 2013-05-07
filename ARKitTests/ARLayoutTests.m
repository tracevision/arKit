//
//  ARLayoutTests.m
//  ARKit
//
//  Created by Brian Bal on 5/7/13.
//  Copyright (c) 2013 AlpineReplay. All rights reserved.
//

#import "ARLayoutTests.h"
#import "ARKit.h"

@implementation ARLayoutTests


#pragma mark - Init Tests

- (void)testInitWithWidthHeight
{
    UIView *v = [[UIView alloc] initWithWithWidth:50 height:100];
    
    double expectedX = 0;
    double expectedY = 0;
    double expectedW = 50;
    double expectedH = 100;
    STAssertEquals(expectedX, v.x, @"should have the correct x value");
    STAssertEquals(expectedY, v.y, @"should have the correct y value");
    STAssertEquals(expectedW, v.width, @"should have the correct width value");
    STAssertEquals(expectedH, v.height, @"should have the correct height value");
}


#pragma mark - Layout Helper Tests

- (void)testAddSubviewAbove
{
    UIView *v = [[UIView alloc] initWithWithWidth:320 height:320];
    v.x = 100;
    v.y = 100;
    
    UIView *sv1 = [[UIView alloc] initWithWithWidth:10 height:10];
    sv1.x = 50;
    sv1.y = 50;
    [v addSubview:sv1];
    
    UIView *sv2 = [[UIView alloc] initWithWithWidth:10 height:10];
    [v addSubview:sv2 above:sv1 offsetBottom:3 offsetLeft:5];
    
    double expectedX = 55;
    double expectedY = 37;
    STAssertEquals(sv2.x, expectedX, @"should have the correct x value");
    STAssertEquals(sv2.y, expectedY, @"should have the correct y value");
}

- (void)testAddSubviewBelow
{
    UIView *v = [[UIView alloc] initWithWithWidth:320 height:320];
    v.x = 100;
    v.y = 100;
    
    UIView *sv1 = [[UIView alloc] initWithWithWidth:10 height:10];
    sv1.x = 50;
    sv1.y = 50;
    [v addSubview:sv1];
    
    UIView *sv2 = [[UIView alloc] initWithWithWidth:10 height:10];
    [v addSubview:sv2 below:sv1 offsetTop:5 offsetLeft:3];
    
    double expectedX = 53;
    double expectedY = 65;
    STAssertEquals(sv2.x, expectedX, @"should have the correct x value");
    STAssertEquals(sv2.y, expectedY, @"should have the correct y value");
}

- (void)testAddSubviewRight
{
    UIView *v = [[UIView alloc] initWithWithWidth:320 height:320];
    v.x = 100;
    v.y = 100;
    
    UIView *sv1 = [[UIView alloc] initWithWithWidth:10 height:10];
    sv1.x = 50;
    sv1.y = 50;
    [v addSubview:sv1];
    
    UIView *sv2 = [[UIView alloc] initWithWithWidth:10 height:10];
    [v addSubview:sv2 rightOf:sv1 offsetTop:5 offsetLeft:3];
    
    double expectedX = 63;
    double expectedY = 55;
    STAssertEquals(sv2.x, expectedX, @"should have the correct x value");
    STAssertEquals(sv2.y, expectedY, @"should have the correct y value");
}

- (void)testAddSubviewLeft
{
    UIView *v = [[UIView alloc] initWithWithWidth:320 height:320];
    v.x = 100;
    v.y = 100;
    
    UIView *sv1 = [[UIView alloc] initWithWithWidth:10 height:10];
    sv1.x = 50;
    sv1.y = 50;
    [v addSubview:sv1];
    
    UIView *sv2 = [[UIView alloc] initWithWithWidth:10 height:10];
    [v addSubview:sv2 leftOf:sv1 offsetTop:3 offsetRight:5];
    
    double expectedX = 35;
    double expectedY = 53;
    STAssertEquals(sv2.x, expectedX, @"should have the correct x value");
    STAssertEquals(sv2.y, expectedY, @"should have the correct y value");
}

#pragma mark - Frame Helper Tests

- (void)testXGetter
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(123, 124, 125, 126)];
    
    double expected = 123;
    STAssertEquals(expected, v.x, @"should have the correct x value");
}

- (void)testXSetter
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(123, 124, 125, 126)];
    v.x = 321;
    
    double expected = 321;
    STAssertEquals(expected, v.x, @"should have set the correct x value");
}

- (void)testYGetter
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(123, 124, 125, 126)];
    
    double expected = 124;
    STAssertEquals(expected, v.y, @"should have the correct y value");
}

- (void)testYSetter
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(123, 124, 125, 126)];
    v.y = 421;
    
    double expected = 421;
    STAssertEquals(expected, v.y, @"should have set the correct y value");
}

- (void)testWidthGetter
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(123, 124, 125, 126)];
    
    double expected = 125;
    STAssertEquals(expected, v.width, @"should have the correct width value");
}

- (void)testWidthSetter
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(123, 124, 125, 126)];
    v.width = 521;
    
    double expected = 521;
    STAssertEquals(expected, v.width, @"should have set the correct width value");
}

- (void)testHeightGetter
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(123, 124, 125, 126)];
    
    double expected = 126;
    STAssertEquals(expected, v.height, @"should have the correct height value");
}

- (void)testHeightSetter
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(123, 124, 125, 126)];
    v.height = 621;
    
    double expected = 621;
    STAssertEquals(expected, v.height, @"should have set the correct height value");
}

@end
