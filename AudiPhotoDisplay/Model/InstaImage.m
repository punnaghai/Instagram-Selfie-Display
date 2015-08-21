//
//  InstaImage.m
//  AudiPhotoDisplay
//
//  Created by Punnaghai Puvi on 7/26/15.
//  Copyright (c) 2015 Punnaghai Puvi. All rights reserved.
//

#import "InstaImage.h"

static NSCache *imageCache;

@interface InstaImage()

+(void)createCacheInstance;

@end

@implementation InstaImage

+ (void) getPhoto:(NSDictionary*) photo size:(NSString*) size completion:(void(^)(UIImage *image))completion {
    if (photo == nil || size == nil || completion == nil) {
        return;
    }
    
//    if(imageCache == nil)
//        [self createCacheInstance];
//    
//    NSString *key = [[NSString alloc] initWithFormat:@"%@-%@", photo[@"id"], size];
//    UIImage *image = (UIImage *)[imageCache objectForKey:key];
//    if (image)
//    {
//        completion(image);
//        return;
//    }
    
    NSURL *url = [[NSURL alloc] initWithString:photo[@"images"][size][@"url"]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
//        if(data != nil){
            UIImage *image = [[UIImage alloc] initWithData:data];
//            if(image != nil)
//                [imageCache setObject:image forKey:key];
//        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(image);
        });
    }];
    
    [task resume];
    
}

+(void) createCacheInstance{
    imageCache = [[NSCache alloc] init];
    
}

@end
