//
//  DownloadedFileSystemTableViewCell.m
//  Laracaster
//
//  Created by Jackie Zhang on 27/02/2016.
//  Copyright © 2016 Reactive Studio. All rights reserved.
//

#import "DownloadedFileSystemTableViewCell.h"

@implementation DownloadedFileSystemTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
    if (_isFile) {
        
        // set the indicators' images to that matches file
        _fileDirIndicatorImageView.image = [UIImage imageNamed:@"video_file"];
        
        _proceedingIndicatorImageView.image = [UIImage imageNamed:@"play"];
        
    }else{
        
        // set the indicators' images to that matches a folder
        _fileDirIndicatorImageView.image = [UIImage imageNamed:@"folder"];
        
        _proceedingIndicatorImageView.image = [UIImage imageNamed:@"folder_forward"];
        
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
