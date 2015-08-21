//
//  EnlargeImageViewController.h
//  AudiPhotoDisplay
//
//  Created by Punnaghai Puvi on 7/27/15.
//  Copyright (c) 2015 Punnaghai Puvi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EnlargeImageViewController : UIViewController

@property (weak) IBOutlet UIImageView *imageView;
@property (nonatomic, strong, readwrite) NSDictionary *selfie;

@end
