//
//  HTTPRequestManager.h
//  Splint
//
//  Created by Bill Gestrich on 3/15/14.
//  Copyright (c) 2014 William Gestrich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "AFNetworking.h"

#define VIDEO_ITEMS_URL @"video_index.json"

#define kAccessTokenDefaultsKey @"ACCESS_TOKEN"

typedef void (^VoidBlock)(void);
typedef void (^ModelBlock)(JSONModel* aModelBaseObject);
typedef void (^ArrayBlock)(NSMutableArray* listOfModelBaseObjects);
typedef void (^ErrorBlock)(NSError* engineError);

@interface HTTPRequestManager : AFHTTPRequestOperationManager

-(void) fetchVideoItemsOnSucceeded:(ArrayBlock) succeededBlock
                                        onError:(ErrorBlock) errorBlock;

-(void) fetchImageItem:(NSString *)path OnSucceeded:(ArrayBlock) succeededBlock
onError:(ErrorBlock) errorBlock;

@end