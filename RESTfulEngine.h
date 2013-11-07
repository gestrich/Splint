//
//  RESTfulEngine.h
//  iHotelApp
//
//  Created by Mugunth on 25/05/11.
//  Copyright 2011 Steinlogic. All rights reserved.

#import <Foundation/Foundation.h>

#import "RESTfulOperation.h"
#import "JSONModel.h"

#define LOGIN_URL @"loginwaiter"
#define MENU_ITEMS_URL @"menuitem"
#define VIDEO_ITEMS_URL @"video_index.json"

#define kAccessTokenDefaultsKey @"ACCESS_TOKEN"

typedef void (^VoidBlock)(void);
typedef void (^ModelBlock)(JSONModel* aModelBaseObject);
typedef void (^ArrayBlock)(NSMutableArray* listOfModelBaseObjects);
typedef void (^ErrorBlock)(NSError* engineError);

@interface RESTfulEngine : MKNetworkEngine 

-(RESTfulOperation*) fetchVideoItemsOnSucceeded:(ArrayBlock) succeededBlock
                                       onError:(ErrorBlock) errorBlock;

@end