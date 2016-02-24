//
//  LaracastVideoDownloadManager.m
//  Laracaster
//
//  Created by Jackie Chung on 19/02/2016.
//  Copyright © 2016 Reactive Studio. All rights reserved.
//

#import "LaracastVideoDownloadManager.h"

static NSString* videoDir = @"video";

@interface LaracastVideoDownloadManager(){
    
    
}

@property (assign,nonatomic)BOOL bgDownloadEnabled;

@end

@implementation LaracastVideoDownloadManager

+(instancetype)sharedManager{
    
    static LaracastVideoDownloadManager* manager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
       
        manager = [[self alloc]init];
        
    });
    
    return manager;
    
}

-(instancetype)init{
    
    if (self = [super init]) {
        
        _bgDownloadEnabled = YES;
        
    }
    
    return self;
}

-(void)setBgEnabled:(BOOL)enabled{
    
    _bgDownloadEnabled = enabled;
    
}

-(void)downloadVideoForUrl:(NSString *)url{
    
    // ...
    
}

-(void)downloadVideoForUrl:(NSString *)url WithProgressBlock:(void (^)(CGFloat))progressBlock completionBlock:(void (^)(BOOL))completionBlock{
    
    //...
    
}

@end
