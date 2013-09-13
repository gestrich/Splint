//
//  AppDelegate.m
//  Splint
//
//  Created by William Gestrich on 7/22/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#define SPLASH_VIEW_TAG 1001
#define HAND_IMAGE_TAG 2001
#define SPLASH_VIEW_TIME 3

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    UIView *splashView = [[[NSBundle mainBundle] loadNibNamed:@"SplashView" owner:self options:nil] lastObject];
    splashView.tag = SPLASH_VIEW_TAG;
    
    //Add splash view to main view controller
    UIViewController *initialVc = self.window.rootViewController;
    splashView.frame = (CGRect){0,0, initialVc.view.frame.size.width, initialVc.view.frame.size.height};
    [initialVc.view addSubview:splashView];
    
    //Fade hand image in
    UIView *handImage = [splashView viewWithTag:HAND_IMAGE_TAG];
    handImage.alpha = 0.0;
    [UIView animateWithDuration:1.0 animations:^{
        handImage.alpha = 3.0;
    }];

    //set time to display splash view -- remove view after expiration
    NSDate *fireTime = [NSDate dateWithTimeIntervalSinceNow:SPLASH_VIEW_TIME ];
    NSTimer *timer = [[NSTimer alloc] initWithFireDate:fireTime interval:0.0 target:self selector:@selector(removeSplashView) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    return YES;
}

-(void)removeSplashView{
    UIViewController *initialVc = self.window.rootViewController;
    UIView *splashView = [initialVc.view viewWithTag:SPLASH_VIEW_TAG];
    [UIView transitionFromView:splashView
     toView:splashView.superview
     duration:2.0
     options:UIViewAnimationOptionTransitionFlipFromRight|UIViewAnimationOptionShowHideTransitionViews
     completion:^(BOOL finished){
         [splashView removeFromSuperview];
     }];
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
