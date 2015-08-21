//
//  InstaMedia.h
//  AudiPhotoDisplay
//
//  Created by Punnaghai Puvi on 7/26/15.
//  Copyright (c) 2015 Punnaghai Puvi. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kUserAccessTokenKey;
extern NSString * const kUserIdKey;
extern NSString * const kInstagramBaseURLString;
extern NSString * const kClientId;
extern NSString * const kClientSecret;
extern NSString * const kRedirectUrl;

// Endpoints
extern NSString * const kUserMediaRecentEndpoint;
extern NSString * const kAuthenticationEndpoint;
extern NSString * const kTokenUrlEndpoint;
extern NSString * const kMediaURL;

//Collection settings
extern const float kTileWidth;
extern const float ktileHeight;
extern const float kTileSpacing;



@interface InstaMedia : NSObject

+ (InstaMedia *)sharedInstance;

@end
