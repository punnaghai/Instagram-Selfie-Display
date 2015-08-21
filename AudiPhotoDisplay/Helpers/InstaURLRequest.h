//
//  InstaURLRequest.h
//  AudiPhotoDisplay
//
//  Created by Punnaghai Puvi on 7/26/15.
//  Copyright (c) 2015 Punnaghai Puvi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InstaHelpers.h"

@interface InstaURLRequest : NSObject

+ (InstaURLRequest *)sharedInstance;

-(void) processRequest :(NSMutableURLRequest *) request;

@end
