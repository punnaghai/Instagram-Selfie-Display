//
//  InstaMedia.m
//  AudiPhotoDisplay
//
//  Created by Punnaghai Puvi on 7/26/15.
//  Copyright (c) 2015 Punnaghai Puvi. All rights reserved.
//

#import "InstaMedia.h"

NSString * const kUserAccessTokenKey = @"kUserAccessTokenKey";
NSString * const kUserIdKey = @"kUserIdKey";

NSString * const kClientId = @"253fbf6b6ef54483a3f24db15a10e1f2";
NSString * const kClientSecret = @"0a6cbedf2637410d8f99014a40b221b0";

NSString * const kInstagramBaseURLString = @"https://api.instagram.com/v1/";
NSString * const kRedirectUrl = @"http://www.google.com";
NSString * const kAuthenticationEndpoint = @"https://api.instagram.com/oauth/authorize/";
NSString * const kTokenUrlEndpoint = @"https://api.instagram.com/oauth/access_token/";

NSString * const kUserMediaRecentEndpoint = @"users/%@/media/recent/";
NSString * const kMediaURL = @"https://api.instagram.com/v1/tags/selfies/media/recent?access_token=%@&max_tag_id=20&count=200";

float const kTileWidth = 106.0f;
const float ktileHeight = 106.0f;
const float kTileSpacing = 1.0f;

@implementation InstaMedia

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+ (InstaMedia *)sharedInstance
{
    static InstaMedia * _sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] init];
    });
    
    return _sharedClient;
}

@end
