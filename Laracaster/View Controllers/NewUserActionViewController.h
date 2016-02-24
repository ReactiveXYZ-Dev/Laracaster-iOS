//
//  NewUserActionViewController.h
//  Laracaster
//
//  Created by Jackie Chung on 17/02/2016.
//  Copyright © 2016 Reactive Studio. All rights reserved.
//

#import "RootWebViewController.h"

typedef NS_ENUM(NSInteger,USER_ACTION) {
    
    USER_SIGNIN = 0,
    
    USER_REGISTER,
        
    USER_GOOGLE_HELP,
    
    USER_LARAVEL_HELP
    
};

@interface NewUserActionViewController : RootWebViewController

@property (nonatomic,assign) USER_ACTION action;

@end
