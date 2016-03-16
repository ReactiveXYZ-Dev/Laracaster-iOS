//
//  NewUserActionViewController.m
//  Laracaster
//
//  Created by Jackie Chung on 17/02/2016.
//  Copyright © 2016 Reactive Studio. All rights reserved.
//

#import "NewUserActionViewController.h"

#import "URLConstants.h"

@interface NewUserActionViewController()

@end

@implementation NewUserActionViewController

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder Url:@"https://www.laracasts.com"]) {
        
        //... more initialization
        
    }
    
    return self;
    
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    // check user action property
    switch (_action) {
            
        case USER_REGISTER:{
            
            [self loadURLWithString:kLaracastRegisterUrl];
            
        }
            break;
        
        case USER_SIGNIN:{
            
            [self loadURLWithString:kLaracastLoginUrl];
            
        }
            
            break;
        
        case USER_GOOGLE_HELP:{
            
            [self loadURLWithString:kSearchForHelpOnGoogleUrl];
            
        }
            break;
            
        case USER_LARAVEL_HELP:{
            
            [self loadURLWithString:kSearchForHelpOnLaravelDocsUrl];
            
        }
            break;
            
        default:
            break;
    }
}

-(void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
    
}

-(void)addNavTitle{
    
    // check user action property
    switch (_action) {
            
        case USER_REGISTER:{
            
            [navBarItem setTitle:@"Join Laracasts"];
            
        }
            break;
            
        case USER_SIGNIN:{
            
            [navBarItem setTitle:@"Sign in laracasts"];
            
        }
            
            break;
            
        case USER_GOOGLE_HELP:{
            
            [navBarItem setTitle:@"Get help from Google"];
            
        }
            break;
            
        case USER_LARAVEL_HELP:{
            
            [navBarItem setTitle:@"Get help from laravel Docs"];
            
        }
            break;
            
        default:
            break;
    }

    [self addDismissBtn];
    
}

-(void)addDismissBtn{
    
    // add the dismiss button
    UIBarButtonItem* dismissButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"dismiss-vc"] style:UIBarButtonItemStyleDone target:self action:@selector(dismissVC)];
    
    [dismissButton setTintColor:[UIColor whiteColor]];
    
    [navBarItem setRightBarButtonItem:dismissButton];

    
}

-(void)dismissVC{
        
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}


@end
