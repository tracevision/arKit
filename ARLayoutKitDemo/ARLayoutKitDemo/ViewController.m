//
//  ViewController.m
//  ARLayoutKitDemo
//
//  Created by Brian Bal on 5/7/13.
//  Copyright (c) 2013 AlpineReplay. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <ARKit/ARKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view applyStyle:@"page_background"];
    
    UILabel *titleLabel = [[UILabel alloc] initWithWithWidth:320 height:44];
    [titleLabel applyStyle:@"page_background"];
    [titleLabel applyStyle:@"title_label"];
    titleLabel.y = 0;
    titleLabel.text = @"A Title Label";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithWithWidth:145 height:140];
    [imageView applyStyle:@"avatar_style"];
    [self.view addSubview:imageView below:titleLabel offsetTop:10 offsetLeft:10];
    
    UIView *aView = [[UIView alloc] initWithWithWidth:145 height:20];
    [aView applyStyle:@"a_view_style"];
    [self.view addSubview:aView rightOf:imageView offsetTop:0 offsetLeft:10];
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithWithWidth:145 height:110];
    [descriptionLabel applyStyle:@"description_label"];
    descriptionLabel.text = @"In ante dolor, molestie at semper nec, venenatis in tellus. Morbi accumsan elementum enim a elementum. Integer malesuada lacinia laoreet. In ultricies tortor id mauris dapibus feugiat. Cras varius molestie ullamcorper. Aliquam porta mattis accumsan. Duis laoreet lectus at leo pharetra pulvinar.";
    [self.view addSubview:descriptionLabel below:aView offsetTop:10 offsetLeft:0];
    
    UIView *bView = [[UIView alloc] initWithWithWidth:145 height:44];
    [bView applyStyle:@"b_view_style"];
    [self.view addSubview:bView below:descriptionLabel offsetTop:10 offsetLeft:0];
    
    UIButton *button = [[UIButton alloc] initWithWithWidth:125 height:44];
    [button setTitle:@"Test Button" forState:UIControlStateNormal];
    [button applyStyle:@"button_style"];
    [self.view addSubview:button leftOf:bView offsetTop:0 offsetRight:20];
}


@end
