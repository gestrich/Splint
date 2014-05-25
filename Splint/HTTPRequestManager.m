//
//  HTTPRequestManager.m
//  Splint
//
//  Created by Bill Gestrich on 3/15/14.
//  Copyright (c) 2014 William Gestrich. All rights reserved.
//

#import "HTTPRequestManger.h"
#import "Video.h"
#import <AFNetworking/UIImageView+AFNetworking.h>


@implementation HTTPRequestManager


-(void) fetchVideoItemsOnSucceeded:(ArrayBlock) succeededBlock
                                        onError:(ErrorBlock) errorBlock{

    [self GET:VIDEO_ITEMS_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *videoItemsJson = [responseObject objectForKey:@"videoitems"];
        
        NSMutableArray *videoItems = [NSMutableArray array];
        
        [videoItemsJson enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [videoItems addObject:[[Video alloc] initWithDictionary:obj]];
        }];
        
        succeededBlock(videoItems);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}



-(void) fetchImageItem:(NSString *)path OnSucceeded:(ArrayBlock) succeededBlock
                            onError:(ErrorBlock) errorBlock{
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"image/png"];

    [self GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id object) {
        //TODO: Why is my image not in object param?
        UIImage *returnedImage = [UIImage imageWithData:operation.responseData];
        succeededBlock([ @[returnedImage] mutableCopy]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end


