//
//  InstaImageViewController.m
//  AudiPhotoDisplay
//
//  Created by Punnaghai Puvi on 7/24/15.
//  Copyright (c) 2015 Punnaghai Puvi. All rights reserved.
//

#import "InstaImageViewController.h"
#import "EnlargeImageViewController.h"
#import "InstaSelfieCell.h"


@interface InstaImageViewController ()

-(void) requestInstaImages;

@end

@implementation InstaImageViewController

@synthesize imageArray;
@synthesize receivedData;

-(instancetype) init {
    
    // Layout for collection view
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kTileWidth, ktileHeight);
    
    layout.minimumInteritemSpacing = kTileSpacing;
    layout.minimumLineSpacing = kTileSpacing;
    
    return (self = [super initWithCollectionViewLayout:layout]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"Selfie Collection";
    
    self.collectionView.alwaysBounceVertical = YES;
        
    // Register class for cells.
    [self.collectionView registerClass:[InstaSelfieCell class] forCellWithReuseIdentifier:@"selfie"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self requestInstaImages];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) requestInstaImages {
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
   
    NSString *tagMediaURL = [NSString stringWithFormat:kMediaURL, [defaults objectForKey:kUserAccessTokenKey]];
    
    NSString *url = [[InstaHelpers sharedInstance] URLEncodeString:tagMediaURL];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getURLResponse:) name:GET_URL_RESPONSE object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getURLError:) name:GET_URL_ERROR object:nil];
    
    [[InstaURLRequest sharedInstance] processRequest:request];
    
}

#pragma mark - UICollectionView Delegate

// Method from UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  [imageArray count];
}

// Asks the data source delegate for the cell that corresponds to the specified item in the collection view.
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    InstaSelfieCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"selfie" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.selfie = imageArray[indexPath.row];
    return cell;
}

// Tells the delegate that the photo at the specified index path was selected.
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *photo = imageArray[indexPath.row];
    EnlargeImageViewController *enlargeVC = [[EnlargeImageViewController alloc] init];
    enlargeVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    enlargeVC.selfie = photo;
    
    //dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:enlargeVC animated:YES completion:nil];
    //});
}

-(void) getURLError:(NSNotification *)notification{
    NSString *errString = (NSString *)[notification object];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[NSString stringWithFormat:@"%@", errString]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    
    [[InstaHelpers sharedInstance] RemoveObservers:GET_URL_RESPONSE forObject:self];
    [[InstaHelpers sharedInstance] RemoveObservers:GET_URL_ERROR forObject:self];
    [alert show];
}

-(void) getURLResponse:(NSNotification*)notification {
    id jsonData = [notification object];
    
    if(jsonData && [NSJSONSerialization isValidJSONObject:jsonData])
    {
        imageArray = [jsonData objectForKey:@"data"];
        
        [[InstaHelpers sharedInstance] RemoveObservers:GET_URL_RESPONSE forObject:self];
        [[InstaHelpers sharedInstance] RemoveObservers:GET_URL_ERROR forObject:self];
    }
    // Main thread.
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
        
    });
}

@end
