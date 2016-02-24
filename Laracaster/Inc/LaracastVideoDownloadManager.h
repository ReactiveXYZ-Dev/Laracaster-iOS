//
//  LaracastVideoDownloadManager.h
//  Laracaster
//
//  Created by Jackie Chung on 19/02/2016.
//  Copyright © 2016 Reactive Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TWRDownloadManager.h"

@interface LaracastVideoDownloadManager : NSObject

+(instancetype)sharedManager;

-(void)setBgEnabled:(BOOL)enabled;

// simple download file linked to an url
-(void)downloadVideoForUrl:(NSString*)url;

// download and instantly retrieve the progress block of file linked to an url
-(void)downloadVideoForUrl:(NSString*)url WithProgressBlock:(void(^)(CGFloat progress))progressBlock completionBlock:(void(^)(BOOL completed))completionBlock;

// cancel download of a file linked to an url
-(void)cancelDownloadForUrl:(NSString*)url;

// retrieve a list of urls that are being downloaded currently
-(NSArray*)currentDownloads;

// retrieve the progress for a specific downloading task linked to one specific url

@end
