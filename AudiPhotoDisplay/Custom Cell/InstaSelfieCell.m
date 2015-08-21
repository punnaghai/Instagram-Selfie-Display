//
//  InstaSelfieCell.m
//  AudiPhotoDisplay
//
//  Created by Punnaghai Puvi on 7/26/15.
//  Copyright (c) 2015 Punnaghai Puvi. All rights reserved.
//

#import "InstaSelfieCell.h"
#import "InstaImage.h"

@implementation InstaSelfieCell

#pragma mark - Set photo in cells

-(void) setSelfie:(NSDictionary *)selfie {
    _selfie = selfie;
    
    
        // Class method
        [InstaImage getPhoto:_selfie size:@"thumbnail" completion:^(UIImage *image) {
        
            self.imageView.image = image;
        }];
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        self.imageView.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.0f];
        
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

#pragma mark - Photo Cell Layout

-(void) layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = self.contentView.bounds;
}

@end
