//
//  RootWebViewController.h
//  Laracaster
//
//  Created by Jackie Chung on 14/02/2016.
//  Copyright © 2016 Reactive Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <WebKit/WebKit.h>

@interface RootWebViewController : UIViewController {
    
    WKWebView* webView;
    
    UINavigationBar* navBar;
    
    UINavigationItem* navBarItem;
    
}

// WebView manipulations
-(BOOL)goBack;

-(BOOL)goForward;

-(void)reload;

-(void)loadURLWithString:(NSString*)urlString;

-(void)sharePage;

-(id)getProgressIndicator;

// Initializers
-(instancetype)initWithCoder:(NSCoder *)aDecoder Url:(NSString*)urlString;

@end
