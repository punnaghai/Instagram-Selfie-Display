//
//  EnlargeImageViewController.m
//  AudiPhotoDisplay
//
//  Created by Punnaghai Puvi on 7/27/15.
//  Copyright (c) 2015 Punnaghai Puvi. All rights reserved.
//

#import "EnlargeImageViewController.h"
#import "InstaImage.h"

@interface EnlargeImageViewController ()

@end

@implementation EnlargeImageViewController

@synthesize imageView=_imageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Class method
    [InstaImage getPhoto:_selfie size:@"standard_resolution" completion:^(UIImage *image) {
        
        self.imageView.image = image;
    }];
    
    
    // Tap to close
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
    [self.view addGestureRecognizer:tap];
}

-(void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    // View controller's view's size
    CGSize size = self.view.bounds.size;
    
    // Image view's size
    CGSize imageSize = CGSizeMake(size.width, size.width);
    
    // Image view's frame
    self.imageView.frame = CGRectMake(0.0, (size.height - imageSize.height) / 2.0, imageSize.width, imageSize.height);
}


// Dismiss view
-(void) close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
