//
//  APIWrapper.m
//  Splint
//
//  Created by William Gestrich on 7/25/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#import "APIWrapper.h"



@implementation APIWrapper

-(id) init{
    self = [super init];
    if(self){
        self.connectionToInfoMapping = [NSMutableDictionary dictionary];
    }
    
    return self;
}

+(APIWrapper*)get{
    
    static APIWrapper *instance = nil; //assigns once
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //block executed once
        instance = [[APIWrapper alloc] init];
    });
    
    return instance;
}

+(void)videoIndexForTarget:(id)target callback:(SEL)action
{
    APIWrapper *wrapper = [APIWrapper get];
    [wrapper sendRequest:@"GET" url:[NSURL URLWithString:@"http://localhost:3000/video_index.json"] withParams:nil target:target callback:action];
}

-(void)sendRequest:(NSString*)actionType url:(NSURL*)url withParams:(NSDictionary*)params
            target:(id)target callback:(SEL)callback{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    if([actionType isEqualToString:@"POST"]){
        [request setHTTPMethod:@"POST"];
        request.URL = url;
        //TODO: Finish making POST request when required
    }else{
        //GET
        [request setHTTPMethod:@"GET"];
       
        NSMutableString *queryParams = [[NSMutableString alloc] initWithString:url.absoluteString];
        if(params != nil){
            int i = 0;
            for(NSString *key in params.allKeys){
                BOOL last = (i == (params.count-1) );
                [queryParams appendFormat:@"%@=%@", key, params[key] ];
                if(!last){
                    [queryParams appendString:@"&"];
                }
                i++;
            }
        }
        request.URL = [NSURL URLWithString: queryParams];
    }
    
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    NSMutableDictionary *connectionInfo = [NSMutableDictionary dictionary];
    if(target){
        [connectionInfo setObject:target forKey:@"target"];
        [connectionInfo setObject:[NSValue valueWithPointer:callback] forKey:@"callback"];
    }
    NSMutableData *responseData = [NSMutableData data];
    [connectionInfo setObject:responseData forKey:@"responseData"];
    [self.connectionToInfoMapping setObject:connectionInfo forKey:[NSString stringWithFormat:@"%@", connection]];

}

#pragma mark NSURLConnection delegate methods


-(void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"response received");
    NSDictionary *dict = [self.connectionToInfoMapping objectForKey:[NSString stringWithFormat:@"%@", connection]];
    NSMutableData *responseData = dict[@"responseData"];
    [responseData setLength:0];
    
}

-(void)connection:(NSURLConnection*)connection didReceiveData:(NSData *)data{
    NSLog(@"Data received");
    NSDictionary *dict = [self.connectionToInfoMapping objectForKey:[NSString stringWithFormat:@"%@", connection]];
    NSMutableData *responseData = dict[@"responseData"];
    [responseData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"Connection Failure");
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

-(void)connectionDidFinishLoading:(NSURLConnection*)connection{
    NSLog(@"Connection finished");
     [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    NSDictionary *dict = [self.connectionToInfoMapping objectForKey:[NSString stringWithFormat:@"%@", connection]];
    //NSString *responseData = [[NSString alloc] initWithData:dict[@"responseData"] encoding:NSUTF8StringEncoding];
    id target = dict[@"target"];
    SEL callback = (SEL)[[dict objectForKey:@"callback" ] pointerValue];
    if(target && [target respondsToSelector:callback]){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [target performSelector:callback withObject:dict[@"responseData"]];
#pragma clang diagnostic pop
    }
}




@end
