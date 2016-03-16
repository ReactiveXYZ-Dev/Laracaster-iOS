//
//  DownloadsFolderViewController.h
//  Laracaster
//
//  Created by Jackie Chung on 14/03/2016.
//  Copyright © 2016 Reactive Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LaracastVideoFileInstance;

@interface DownloadsFolderViewController : UIViewController

@property (strong,nonatomic) NSString* folderTitle;

@property (strong,nonatomic) NSArray<LaracastVideoFileInstance*>* videoData;

@end
