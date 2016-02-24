//
//  ViewComposer.m
//  Laracaster
//
//  Created by Jackie Chung on 18/02/2016.
//  Copyright © 2016 Reactive Studio. All rights reserved.
//

#import "ViewComposer.h"

#import "MBProgressHUD.h"

@implementation ViewComposer

+(instancetype)sharedComposer{
    
    static ViewComposer* composer = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        composer = [[self alloc]init];
        
    });
    
    return composer;
    
}

-(void)showToastWithMessage:(NSString *)message andDuration:(float)duration{
    
    MBProgressHUD* toast = [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication]delegate]window] animated:YES];
    
    toast.mode = MBProgressHUDModeText;
    
    toast.label.text = message;
    
    toast.offset = CGPointMake(0.f, MBProgressMaxOffset);
    
    [toast hideAnimated:YES afterDelay:duration];
    
}

@end
