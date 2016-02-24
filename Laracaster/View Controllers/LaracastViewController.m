//
//  LaracastViewController.m
//  Laracaster
//
//  Created by Jackie Chung on 15/02/2016.
//  Copyright © 2016 Reactive Studio. All rights reserved.
//

#import "LaracastViewController.h"

#import "NewUserActionViewController.h"

#import "ViewComposer.h"

#import "UserDefaultsManager.h"

#import "UserDefaultKeys.h"

#import "VCFloatingActionButton.h"

#import "MWKProgressIndicator.h"

@interface LaracastViewController()<floatMenuDelegate,WKNavigationDelegate>{
    
    UIAlertController* alertController;
    
    VCFloatingActionButton* floatingButtons;
    
}

@end

@implementation LaracastViewController

#pragma mark - Initializers
-(instancetype)initWithCoder:(NSCoder *)aDecoder Url:(NSString *)urlString{
    
    if (self = [super initWithCoder:aDecoder Url:urlString]) {
        
        initUrl = urlString;
        
    }
    
    return self;
}

#pragma mark - Public methods
-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    // register observers
    //NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    
    //[center addObserver:self selector:@selector(parentWebViewHasSuccessfullyLoaded) name:kWebViewHasLoadedSuccessFully object:nil];
    
    //[center addObserver:self selector:@selector(parentWebViewHasFailedToLoad) name:kWebViewHasFailedToLoad object:nil];
    
}

-(void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Private methods

// triggered everytime webview finishes loading successfully
-(void)parentWebViewHasSuccessfullyLoaded{
    
    NSLog(@"%@",webView.URL);
    
    // check if signed into laracasts
    [self checkIfSignedInWithCompletionHandler:^(BOOL success){
        
        if (success == NO) {
            
            // user hasn't signed in (without remembered token)
            if ([UserDefaultsManager shouldShowRegisterSigninPrompt]) {
                
                [self showRegisterSigninPrompt];
                
            }
            
        }

        
    }];
    
    // check if contains video
    [self checkIfContainsVideoWithCompletionHandler:^(NSString* videoUrl){
       
        NSLog(@"%@",videoUrl);
        
        if (videoUrl == nil) {
            
            NSLog(@"video not exist");
            
        }else{
            
            NSLog(@"video exists");
            
            // video exist -> show prompt
            
            
        }
        
        
    }];
    
    // add floating buttons
    if (floatingButtons == nil) {
        
        [self addFloatingButtons];
        
    }
    
}

// triggered everytime webview fails to load
-(void)parentWebViewHasFailedToLoad{
    
    //...
    NSLog(@"%@",webView.URL);

    
}

-(void)addFloatingButtons{
    
    // add and config the floating button responsible for search help
    CGRect floatFrame = CGRectMake([UIScreen mainScreen].bounds.size.width - 55 - 13, [UIScreen mainScreen].bounds.size.height - 84 - 20, 55, 55);
    
    floatingButtons = [[VCFloatingActionButton alloc]initWithFrame:floatFrame normalImage:[UIImage imageNamed:@"help"] andPressedImage:[UIImage imageNamed:@"dismiss-help"] withScrollview:webView.scrollView];
    
    floatingButtons.imageArray = @[@"google_search",@"laravel_search"];
    
    floatingButtons.labelArray = @[@"Search on Google",@"Search Laravel Docs"];
    
    floatingButtons.hideWhileScrolling = YES;
    
    floatingButtons.delegate = self;
    
    [self.view addSubview:floatingButtons];
    
}

// @todo: what a fuck?? WHY isn't this shit outputting the correct value??
-(void)checkIfSignedInWithCompletionHandler:(void(^)(BOOL success))handler{
    
    NSString* path = [[NSBundle mainBundle]pathForResource:@"checkSignedin" ofType:@"js"];
    
    [webView evaluateJavaScript:[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil] completionHandler:^(id result, NSError* error){
        
        NSLog(@"%@ + class:%@",result,[result class]);
        
        if ([result isEqualToString:@"yes"]) {
            
            NSLog(@"YES");
            
            handler(YES);
            
        }else{
            
            NSLog(@"NO");
            
            handler(NO);
            
        }
        
    }];
    
}

-(void)checkIfContainsVideoWithCompletionHandler:(void(^)(NSString* videoUrl))handler{
    
    NSString* path = [[NSBundle mainBundle]pathForResource:@"checkIfContainsVideo" ofType:@"js"];
    
    [webView evaluateJavaScript:[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil] completionHandler:^(id result, NSError* error){
        
        if ([result isKindOfClass:[NSNull class]]) {
            
            handler(nil);
            
        }else{
            
            handler(result);
            
        }
        
        
    }];
    
}

-(void)showRegisterSigninPrompt{
    
    // check if user has logged
    __weak typeof(self)weakSelf = self;
    
    alertController = [UIAlertController alertControllerWithTitle:@"You are not signed into Laracast yet" message:@"Do you want to sign in now?" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Sign in" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action){
        
        [weakSelf signInLaracast];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Register / View benefits" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action){
        
        [weakSelf joinLaracast];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Never see this again" style:UIAlertActionStyleDestructive handler:^(UIAlertAction* action){
        
        // set never show in user defaults
        [UserDefaultsManager setUserDefaultWithName:kUserDefaultNeverShowRegisterLoginPromptKey withObject:@"yes"];
        
        // show a toast to indicate where to signin/register again
        [[ViewComposer sharedComposer]showToastWithMessage:@"register/sign by tapping the settings icon" andDuration:3.0];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action){
        
        //[alertController dismissViewControllerAnimated:YES completion:nil];
        
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

-(void)joinLaracast{
    
    NewUserActionViewController* joinVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"NewUserActionViewController"];
    
    joinVC.action = USER_REGISTER;
    
    [self presentViewController:joinVC animated:YES completion:nil];
    
}

-(void)signInLaracast{
    
    NewUserActionViewController* registerVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NewUserActionViewController"];
    
    registerVC.action = USER_SIGNIN;
    
    [self presentViewController:registerVC animated:YES completion:nil];
    
}

-(void)getHelpFrom:(USER_ACTION)source{
    
    NewUserActionViewController* vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NewUserActionViewController"];
    
    switch (source) {
            
        case USER_GOOGLE_HELP:
            
            vc.action = USER_GOOGLE_HELP;
            
            break;
            
        case USER_LARAVEL_HELP:
            
            vc.action = USER_LARAVEL_HELP;
            
            break;
            
        default:
            break;
    }
    
    [self presentViewController:vc animated:YES completion:nil];
    
}

-(void)gotoDownloads{
    
    //@todo: go to the downloads folder view
    
}

// a little trick, trigger search on any laracast page when shaking
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake )
    {
        
        NSString* path = [[NSBundle mainBundle]pathForResource:@"triggerSearch" ofType:@"js"];
        
        [webView evaluateJavaScript:[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil] completionHandler:nil];
        
    }
}



#pragma mark - delegates
// floating button delegate
-(void)didSelectMenuOptionAtIndex:(NSInteger)row{
    
    switch (row) {
            
        case 0:
            
            [self getHelpFrom:USER_GOOGLE_HELP];
            
            break;
            
        case 1:
            
            [self getHelpFrom:USER_LARAVEL_HELP];
            
            break;
            
        default:
            break;
    }
    
}

// WKWebview delegates
-(void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    if ([[navigationResponse.response.URL absoluteString] containsString:@"fpdl.vimeocdn.com"]) {
        
        // cancel the response because we are done and this is what we wanted
        decisionHandler(WKNavigationResponsePolicyCancel);
        
        // hide the loading bar, show success and add the video to downloading queue
        [(MWKProgressIndicator*)[self getProgressIndicator] dismiss];
        
        [(MWKProgressIndicator*)[self getProgressIndicator] showSuccessMessage:@"Start Downloading..."];
        
        // @todo: Adding to the download queue
        
    }
    
    decisionHandler(WKNavigationResponsePolicyAllow);
    
}


-(void)dealloc{
    
    // remove observers
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
    [floatingButtons forceDetachObservers];
    
    // remove AlertController from superview
    [alertController.view removeFromSuperview];
    
}


@end
