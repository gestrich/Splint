//
//  NavigationViewController.m
//  Splint
//
//  Created by Bill Gestrich on 2/11/14.
//  Copyright (c) 2014 William Gestrich. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

-(BOOL)shouldAutorotate
{
    return [[self.viewControllers lastObject] shouldAutorotate];
}

-(NSUInteger)supportedInterfaceOrientations
{
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}

@end
