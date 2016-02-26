//
//  LaracastVideoDownloadManager.h
//  Laracaster
//
//  Created by Jackie Chung on 19/02/2016.
//  Copyright © 2016 Reactive Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>

@class TWRDownloadObject;
@class TWRDownloadManager;

@interface LaracastVideoDownloadManager : NSObject

+(instancetype)sharedManager;

-(void)setBgEnabled:(BOOL)enabled;

// simple download file linked to an url
-(void)downloadVideoForUrl:(NSString*)url;

// download and instantly retrieve the progress block of file linked to an url
-(void)downloadVideoForUrl:(NSString*)url WithProgressBlock:(void(^)(CGFloat progress))progressBlock completionBlock:(void(^)(BOOL completed))completionBlock;

// cancel/resume/pause download of a file linked to an url
-(void)cancelDownloadForUrl:(NSString*)url;

-(void)pauseDownloadForUrl:(NSString*)url;

-(void)resumeDownloadForUrl:(NSString*)url;

// get the download object for a specific downloading url
-(TWRDownloadObject*)downloadingFileFoUrl:(NSString*)url;

// @notice: to retrieve the progress of one specific download, bind the download object to a cell directly

// retrieve a list of urls that are being downloaded currently
-(NSArray*)currentDownloads;



@end
