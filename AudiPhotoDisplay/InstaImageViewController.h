//
//  InstaImageViewController.h
//  AudiPhotoDisplay
//
//  Created by Punnaghai Puvi on 7/24/15.
//  Copyright (c) 2015 Punnaghai Puvi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InstaMedia.h"
#import "InstaHelpers.h"
#import "InstaImage.h"
#import "InstaURLRequest.h"

@interface InstaImageViewController : UICollectionViewController<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray* imageArray;
@property (nonatomic, strong) NSMutableData* receivedData;


@end
