//
//  AppDelegate.m
//  Splint
//
//  Created by William Gestrich on 7/22/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    UIView *splashView = [[[NSBundle mainBundle] loadNibNamed:@"SplashView" owner:self options:nil] lastObject];
    splashView.tag = 1001;
    
    UIViewController *initialVc = self.window.rootViewController;
    UIView *greenView = [[UIView alloc] initWithFrame:(CGRect){0,0,100,100}];

    [initialVc.view addSubview:greenView];
    [initialVc.view addSubview:splashView];

    NSDate *fireTime = [NSDate dateWithTimeIntervalSinceNow:3 ];
    NSTimer *timer = [[NSTimer alloc] initWithFireDate:fireTime interval:0.0 target:self selector:@selector(removeSplashView) userInfo:nil repeats:NO];
    

    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    return YES;
}

-(void)removeSplashView{
    UIViewController *initialVc = self.window.rootViewController;
    UIView *splashView = [initialVc.view viewWithTag:1001];
    [UIView transitionFromView:splashView
     toView:splashView.superview
     duration:2.0
     options:UIViewAnimationOptionTransitionFlipFromRight|UIViewAnimationOptionShowHideTransitionViews
     completion:^(BOOL finished){}];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
