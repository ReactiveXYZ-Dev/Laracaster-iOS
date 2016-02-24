//
//  LaracastViewController.h
//  Laracaster
//
//  Created by Jackie Chung on 15/02/2016.
//  Copyright © 2016 Reactive Studio. All rights reserved.
//

#import "RootWebViewController.h"

#import "URLConstants.h"

#import "NotificationConstants.h"

@interface LaracastViewController : RootWebViewController{
    
    NSString* initUrl;
    
    BOOL isSignedIn;
    
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder Url:(NSString *)urlString;

-(void)joinLaracast;

-(void)signInLaracast;


@end
