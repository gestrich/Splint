//
//  RESTfulEngine.m
//  iHotelApp
//
//  Created by Mugunth on 25/05/11.
//  Copyright 2011 Steinlogic. All rights reserved.

#import "RESTfulEngine.h"
#import "Video.h"

@implementation RESTfulEngine


#pragma mark -
#pragma mark Custom Methods

// Add your custom methods here



-(RESTfulOperation*) fetchVideoItemsOnSucceeded:(ArrayBlock) succeededBlock
                                       onError:(ErrorBlock) errorBlock{
    RESTfulOperation *op = (RESTfulOperation*) [self operationWithPath:VIDEO_ITEMS_URL];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSMutableDictionary *responseDictionary = [completedOperation responseJSON];
        NSMutableArray *videoItemsJson = [responseDictionary objectForKey:@"videoitems"];
        
        NSMutableArray *videoItems = [NSMutableArray array];
        
        [videoItemsJson enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [videoItems addObject:[[Video alloc] initWithDictionary:obj]];
        }];
        
        succeededBlock(videoItems);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        errorBlock(error);

    }];
    
    [self enqueueOperation:op];
    return op;
}


 
-(RESTfulOperation*) fetchImageItem:(NSString *)path OnSucceeded:(ArrayBlock) succeededBlock
                                       onError:(ErrorBlock) errorBlock{
    RESTfulOperation *op = (RESTfulOperation*) [self operationWithPath:path];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        UIImage *image = [completedOperation responseImage];

        succeededBlock([ @[image] mutableCopy]);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        errorBlock(error);
        
    }];
    
    [self enqueueOperation:op];
    return op;
}

@end


