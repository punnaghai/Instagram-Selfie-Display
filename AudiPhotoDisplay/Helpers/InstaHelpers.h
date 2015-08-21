//
//  InstaHelpers.h
//  AudiPhotoDisplay
//
//  Created by Punnaghai Puvi on 7/26/15.
//  Copyright (c) 2015 Punnaghai Puvi. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const GET_URL_RESPONSE;
extern NSString * const GET_URL_ERROR;
extern NSString * const GET_IMAGE;

@interface InstaHelpers : NSObject

+ (InstaHelpers *)sharedInstance;

-(NSString *) URLEncodeString:(NSString *) str;

-(void) RemoveObservers:(NSString *) observerName forObject:(id) observerObject;

@end
