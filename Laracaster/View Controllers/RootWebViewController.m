//
//  RootWebViewController.m
//  Laracaster
//
//  Created by Jackie Chung on 14/02/2016.
//  Copyright © 2016 Reactive Studio. All rights reserved.
//

#import "RootWebViewController.h"

#import "MWKProgressIndicator.h"

#import "AAPullToRefresh.h"

#import "Extensions.h"

#import "NotificationConstants.h"

#import "ViewComposer.h"

#import "UserDefaultsManager.h"

#import "UserDefaultKeys.h"

@interface RootWebViewController ()<WKNavigationDelegate>{
    
    WKNavigation* currentLoadingProgress;
    
    NSString* initURL;
    
    MWKProgressIndicator* progressIndicator;
    
}

@end

@implementation RootWebViewController

#pragma mark - Include
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Add the navbar
    navBar = [[UINavigationBar alloc]init];
    
    [navBar setBarTintColor:[Extensions colorFromHex:@"#80cbc4"]];
    
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    navBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:navBar];
    
    // Initialize the web view
    webView = [[WKWebView alloc]init];
    
    webView.navigationDelegate = self;
    
    // ======== OMG ===========
    webView.allowsBackForwardNavigationGestures = YES;
    
    // Add key value observing to track webview loading progress
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    
    // UI configs
    webView.translatesAutoresizingMaskIntoConstraints = NO;
    
    webView.scrollView.alwaysBounceHorizontal = YES;
    
    // Add the view
    [self.view addSubview:webView];
    
    // Add progress indicator
    progressIndicator = [[MWKProgressIndicator alloc]init];
    
    [self.view addSubview:progressIndicator];
    
    // Add contraints
    NSDictionary* views = NSDictionaryOfVariableBindings(navBar,webView);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0)-[navBar]-(0)-|" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0)-[webView]-(0)-|" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[navBar(==64)]-(0)-[webView]-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
    
    // Now configure the nav bar items
    navBarItem = [[UINavigationItem alloc]init];
    
    [navBar setItems:@[navBarItem]];
    
    UIBarButtonItem* settingsBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"settings"] style:UIBarButtonItemStyleDone target:self action:@selector(showSettings)];
    
    [settingsBtn setTintColor:[UIColor whiteColor]];
    
    [navBarItem setLeftBarButtonItem:settingsBtn animated:YES];
    
    // Load my url
    if (initURL) {
        
        [self loadURLWithString:initURL];
        
    }
    
    // Show navigation tutorial if needed
    if ([UserDefaultsManager shouldShowGestureTutorial]) {
        
        // show some notice
        [[[UIAlertView alloc]initWithTitle:@"Some notice" message:@"Swipe left or right for navigation. Swipe down to reload the page! Have fun!" delegate:nil cancelButtonTitle:@"I got it." otherButtonTitles:nil, nil] show];
        
        // set no need for tutorial
        [UserDefaultsManager setUserDefaultWithName:kUserDefaultHasShownGestureTutorialKey withObject:@"yes"];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public initializer
-(instancetype)initWithCoder:(NSCoder *)aDecoder Url:(NSString *)urlString{
    
    if (self = [super initWithCoder:aDecoder]) {
        
        //initializations
        initURL = urlString;
        
    }
    
    return self;
    
}

#pragma mark - Public methods
-(BOOL)goBack{
    
    if ([webView canGoBack]) {
                
        currentLoadingProgress = [webView goBack];
        
        return YES;
        
    }
    
    return NO;

}

-(BOOL)goForward{
    
    if ([webView canGoForward]) {
        
        currentLoadingProgress = [webView goForward];
        
        return YES;
        
    }
    
    return NO;
    
}

-(void)reload{
    
    currentLoadingProgress = [webView reload];
    
}

-(void)loadURLWithString:(NSString *)urlString{

    currentLoadingProgress = [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    
    [progressIndicator show];


}

-(void)sharePage{
    
    //@todo..
    
}

-(id)getProgressIndicator{
    
    return progressIndicator;
    
}


#pragma mark - Private methods
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"estimatedProgress"] && object == webView) {
        
        [progressIndicator show];
        
        [progressIndicator updateProgress:webView.estimatedProgress];
    }
    else {
        // Make sure to call the superclass's implementation in the else block in case it is also implementing KVO
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
    
}

-(void)configurePullToRefreshes{
    
    __weak RootWebViewController* weakSelf = self;
    
    // top
    AAPullToRefresh* top = [webView.scrollView addPullToRefreshPosition:AAPullToRefreshPositionTop actionHandler:^(AAPullToRefresh* control){
        
        [weakSelf reload];
        
        [control stopIndicatorAnimation];
    }];
    
    top.imageIcon = [UIImage imageNamed:@"reload"];
    
    top.borderColor = [UIColor whiteColor];
    
    /* left
    AAPullToRefresh* left = [webView.scrollView addPullToRefreshPosition:AAPullToRefreshPositionLeft actionHandler:^(AAPullToRefresh* control){
       
        [weakSelf goBack];
        
        [control stopIndicatorAnimation];
        
    }];
    
    left.imageIcon = [UIImage imageNamed:@"backward"];
    
    left.borderColor = [UIColor whiteColor];

    // right
    AAPullToRefresh* right = [webView.scrollView addPullToRefreshPosition:AAPullToRefreshPositionRight actionHandler:^(AAPullToRefresh* control){
       
        [weakSelf goForward];
        
        [control stopIndicatorAnimation];
        
    }];
    
    right.imageIcon = [UIImage imageNamed:@"forward"];
    
    right.borderColor = [UIColor whiteColor];*/
    
}

-(void)showSettings{
    
    // @todo: load the settings VC
    
}

#pragma mark - Webview delegates
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    
    NSLog(@"error");
    // now add refresh controls
    [self configurePullToRefreshes];
    
    // post notification
    //[[NSNotificationCenter defaultCenter]postNotificationName:kWebViewHasFailedToLoad object:nil];
    
    if ([self selfHasSubClassesThatRespondToNavigationResults]) {
        
        [self performSelector:@selector(parentWebViewHasFailedToLoad)];
        
    }
    
    // show error message
    [[ViewComposer sharedComposer]showToastWithMessage:@"Failed to loaded !" andDuration:1.0];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [progressIndicator dismiss];
        
    });
    
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    NSLog(@"Success");
    
    // now add refresh controls
    [self configurePullToRefreshes];
    
    // post notification
    //[[NSNotificationCenter defaultCenter]postNotificationName:kWebViewHasLoadedSuccessFully object:nil];
    
    if ([self selfHasSubClassesThatRespondToNavigationResults]) {
        
        [self performSelector:@selector(parentWebViewHasSuccessfullyLoaded)];
        
    }
    
    // show success message
    [[ViewComposer sharedComposer]showToastWithMessage:@"Successfully loaded" andDuration:1.0];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [progressIndicator dismiss];
        
    });
    
}

-(BOOL)selfHasSubClassesThatRespondToNavigationResults{
    
    if ([self respondsToSelector:@selector(parentWebViewHasSuccessfullyLoaded)] && [self respondsToSelector:@selector(parentWebViewHasFailedToLoad)]) {
        
        return YES;
        
    }
    
    return NO;
    
}

-(void)dealloc{
    
    // remove webview observer
    [webView removeObserver:self forKeyPath:@"estimatedProgress"];
    
    [webView setNavigationDelegate:nil];
    
    [webView.scrollView forceDetachObserversForScrollViews];
    
}

@end
