//
//  ViewController.m
//  AudiPhotoDisplay
//
//  Created by Punnaghai Puvi on 7/24/15.
//  Copyright (c) 2015 Punnaghai Puvi. All rights reserved.
//

#import "ViewController.h"
#import "InstaImageViewController.h"

@interface ViewController ()

@property (nonatomic) NSMutableData *receivedData;

@end


@implementation ViewController

@synthesize receivedData;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[[InstaMedia sharedClient] kClientId];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *fullAuthUrlString = [[NSString alloc]
                                   initWithFormat:@"%@?client_id=%@&redirect_uri=%@&response_type=code",
                                   kAuthenticationEndpoint,
                                   kClientId,
                                   kRedirectUrl
                                   ];

    NSURL *authUrl = [NSURL URLWithString:[[InstaHelpers sharedInstance] URLEncodeString:fullAuthUrlString]];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:authUrl];
    
    [_webView setDelegate:self];
    [_webView loadRequest:request];
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *hostString = [[request URL] host];
    
    if ([hostString isEqualToString:@"www.google.com"]) {
        
        // Extract oauth_verifier from URL query
        NSString* verifier = nil;
        NSArray* urlParams = [[[request URL] query] componentsSeparatedByString:@"&"];
        for (NSString* param in urlParams) {
            NSArray* keyValue = [param componentsSeparatedByString:@"="];
            NSString* key = [keyValue objectAtIndex:0];
            if ([key isEqualToString:@"code"]) {
                verifier = [keyValue objectAtIndex:1];
                break;
            }
        }
        
        if (verifier) {
            
            NSString *data = [NSString stringWithFormat:@"client_id=%@&client_secret=%@&grant_type=authorization_code&redirect_uri=%@&code=%@",kClientId,kClientSecret,kRedirectUrl,verifier];
            
            NSString *url = [[InstaHelpers sharedInstance] URLEncodeString:kTokenUrlEndpoint];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getURLResponse:) name:GET_URL_RESPONSE object:nil];
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getURLError:) name:GET_URL_ERROR object:nil];

            [[InstaURLRequest sharedInstance] processRequest:request];
        } else {
            // ERROR!
        }
        
        [webView removeFromSuperview];
        
        return NO;
    }
    
    return TRUE;
}



- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if([error code] == -1009)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Cannot open the page because it is not connected to the Internet." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        NSString *accesstoken = [jsonData objectForKey:@"access_token"];
        
        NSDictionary *userArray = [jsonData objectForKey:@"user"];
        
        NSString *userId = [userArray objectForKey:@"id"];
        
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:accesstoken forKey:kUserAccessTokenKey];
        [defaults setObject:userId forKey:kUserIdKey];
        [defaults synchronize];
        
        [[InstaHelpers sharedInstance] RemoveObservers:GET_URL_RESPONSE forObject:self];
        [[InstaHelpers sharedInstance] RemoveObservers:GET_URL_ERROR forObject:self];

        if(accesstoken)
        {
            UIStoryboard *imageBoard = [UIStoryboard storyboardWithName:@"InstaImage" bundle:nil];
            UIViewController *controller = [imageBoard instantiateViewControllerWithIdentifier:@"instaImageBoard"];
            [self presentViewController:controller animated:YES completion:nil];
        }
    }
    
}

@end
