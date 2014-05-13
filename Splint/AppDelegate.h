//
//  AppDelegate.h
//  Splint
//
//  Created by William Gestrich on 7/22/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#define OVERRIDE_TO_HEROKU 0
#import "HTTPRequestManger.h"

#if (TARGET_IPHONE_SIMULATOR) & !OVERRIDE_TO_HEROKU
    #define BASE_URL @"http://localhost:3000"
#else
    #define BASE_URL @"desolate-island-3918.herokuapp.com/"
#endif


#import <UIKit/UIKit.h>
//#import "RESTfulEngine.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>




@property (strong, nonatomic) UIWindow *window;
//@property (strong, nonatomic) RESTfulEngine *engine;
@property (strong, atomic) HTTPRequestManager *afManager;

@end
