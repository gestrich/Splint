//
//  AppDelegate.h
//  Splint
//
//  Created by William Gestrich on 7/22/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESTfulEngine.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

#if TARGET_IPHONE_SIMULATOR
#define BASE_URL @"localhost:3000/"
#else
#define BASE_URL @"desolate-island-3918.herokuapp.com/"
#endif


@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RESTfulEngine *engine;

@end
