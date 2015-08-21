//
//  InstaURLRequest.m
//  AudiPhotoDisplay
//
//  Created by Punnaghai Puvi on 7/26/15.
//  Copyright (c) 2015 Punnaghai Puvi. All rights reserved.
//

#import "InstaURLRequest.h"


@interface InstaURLRequest()

@property(nonatomic, strong) NSMutableData *receivedData;

@end

@implementation InstaURLRequest

@synthesize receivedData;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+ (InstaURLRequest *)sharedInstance
{
    static InstaURLRequest * _sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] init];
    });
    
    return _sharedClient;
}

-(void) processRequest :(NSMutableURLRequest *) request{
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    receivedData = [[NSMutableData alloc] init];
    theConnection = nil;
}


#pragma Mark NSURLConnection delegates

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    return cachedResponse;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
   [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    receivedData.length = 0;
    [[NSNotificationCenter defaultCenter] postNotificationName:GET_URL_RESPONSE object:error];
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
//                                                    message:[NSString stringWithFormat:@"%@", error]
//                                                   delegate:nil
//                                          cancelButtonTitle:@"OK"
//                                          otherButtonTitles:nil];
//    [alert show];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *jsonError = nil;
    id jsonData = [NSJSONSerialization JSONObjectWithData:receivedData options:0 error:&jsonError];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:GET_URL_RESPONSE object:jsonData];
    
}

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse
{
    return request;
}


@end
