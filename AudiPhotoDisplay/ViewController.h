//
//  ViewController.h
//  AudiPhotoDisplay
//
//  Created by Punnaghai Puvi on 7/24/15.
//  Copyright (c) 2015 Punnaghai Puvi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InstaMedia.h"
#import "InstaHelpers.h"
#import "InstaURLRequest.h"

@interface ViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

