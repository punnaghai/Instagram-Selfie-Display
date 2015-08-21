//
//  InstaHelpers.m
//  AudiPhotoDisplay
//
//  Created by Punnaghai Puvi on 7/26/15.
//  Copyright (c) 2015 Punnaghai Puvi. All rights reserved.
//

#import "InstaHelpers.h"

NSString * const GET_URL_RESPONSE = @"getURLResponse";
NSString * const GET_URL_ERROR = @"getURLError";
NSString * const GET_IMAGE = @"getImage";
@implementation InstaHelpers

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+ (InstaHelpers *)sharedInstance
{
    static InstaHelpers * _sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] init];
    });
    
    return _sharedClient;
}

-(NSString *) URLEncodeString:(NSString *) str
{
    
    NSMutableString *tempStr = [NSMutableString stringWithString:str];
    [tempStr replaceOccurrencesOfString:@" " withString:@"+" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [tempStr length])];
    
    
    return [[NSString stringWithFormat:@"%@",tempStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

-(void) RemoveObservers:(NSString *)observerName forObject:(id) observerObject{
    [[NSNotificationCenter defaultCenter] removeObserver:observerObject name:observerName object:nil];
}

@end
