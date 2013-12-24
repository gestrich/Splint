//
//  APIWrapper.h
//  Splint
//
//  Created by William Gestrich on 7/25/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//



#import <Foundation/Foundation.h>

@interface APIWrapper : NSObject<NSURLConnectionDelegate>

@property (nonatomic, strong) NSMutableDictionary *connectionToInfoMapping;

+(APIWrapper*)get;

//Calls
+(void)videoIndexForTarget:(id)target callback:(SEL)action;

-(void)sendRequest:(NSString*)actionType url:(NSURL*)url withParams:(NSDictionary*)params
            target:(id)target callback:(SEL)callback;





@end
