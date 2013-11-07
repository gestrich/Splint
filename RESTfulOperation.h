//
//  RESTfulOperation.h
//  iHotelApp
//
//  Created by Mugunth on 28/05/11.
//  Copyright 2011 Steinlogic. All rights reserved.
//

#import "RESTError.h"

@interface RESTfulOperation : MKNetworkOperation

@property (nonatomic, strong) RESTError *restError;
@end
