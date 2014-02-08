//
//  Video.m
//  Splint
//
//  Created by William Gestrich on 9/17/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#import "Video.h"
#import <objc/runtime.h>

@implementation Video

//===========================================================
//  Keyed Archiving
//
//===========================================================
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.urlString forKey:@"UrlString"];
    [encoder encodeObject:self.title forKey:@"Title"];
    [encoder encodeObject:self.videoLength forKey:@"VideoLength"];
    [encoder encodeObject:self.imageUrl forKey:@"ImageUrl"];

}

- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super init])) {
        if ([decoder containsValueForKey:@"UrlString"])
            self.urlString = [decoder decodeObjectForKey:@"UrlString"];
        if ([decoder containsValueForKey:@"Title"])
            self.title = [decoder decodeObjectForKey:@"Title"];
        if ([decoder containsValueForKey:@"VideoLength"])
            self.imageUrl = [decoder decodeObjectForKey:@"VideoLength"];
        if ([decoder containsValueForKey:@"ImageUrl"])
            self.imageUrl = [decoder decodeObjectForKey:@"ImageUrl"];
    }
    return self;
}


- (id)copyWithZone:(NSZone *)zone
{
    id theCopy = [[[self class] allocWithZone:zone] init];  // use designated initializer
    
    [theCopy setUrlString:[self.urlString copy]];
    [theCopy setTitle:[self.title copy]];
    [theCopy setVideoLength:[self.videoLength copy]];
    [theCopy setImageUrl:[self.imageUrl copy]];
    
    return theCopy;
}

-(void)printDescription{
    @autoreleasepool {
        unsigned int numberOfProperties = 0;
        
        //Defining a pointer -- a memory address pointing to a objc_property_t type pointer
        //(the objc_property_t IS a pointer as well)
        //It points to the first objc_property_t pointer as there are others in subsequent
        //memory addresses
        objc_property_t *propertyArray = class_copyPropertyList([self class], &numberOfProperties);
        
        for (NSUInteger i = 0; i < numberOfProperties; i++)
        {
            objc_property_t property = propertyArray[i];
            NSString *name = [[NSString alloc] initWithUTF8String:property_getName(property)];
            NSString *attributesString = [[NSString alloc] initWithUTF8String:property_getAttributes(property)];
            NSLog(@"Property %@ attributes: %@", name, attributesString);
        }
        free(propertyArray);
    }
}

@end
