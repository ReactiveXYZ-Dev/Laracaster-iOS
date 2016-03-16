//
//  DownloadedFileSystemTableViewCell.h
//  Laracaster
//
//  Created by Jackie Zhang on 27/02/2016.
//  Copyright © 2016 Reactive Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadedFileSystemTableViewCell : UITableViewCell

// IBOutlets
// Self config
@property (weak, nonatomic) IBOutlet UIImageView *fileDirIndicatorImageView;

// Manual config
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

// Self config
@property (weak, nonatomic) IBOutlet UIImageView *proceedingIndicatorImageView;

// Manual config
@property (weak, nonatomic) IBOutlet UIView *decoratorView;


// Configuration properties
// File or Folder
@property(assign,nonatomic)BOOL isFile;

@property(assign,nonatomic)BOOL isShortened;

@end
