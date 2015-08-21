//
//  InstaImage.h
//  AudiPhotoDisplay
//
//  Created by Punnaghai Puvi on 7/26/15.
//  Copyright (c) 2015 Punnaghai Puvi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InstaImage : NSObject

+ (void) getPhoto:(NSDictionary*) photo size:(NSString*) size completion:(void(^)(UIImage *image))completion ;

@end
