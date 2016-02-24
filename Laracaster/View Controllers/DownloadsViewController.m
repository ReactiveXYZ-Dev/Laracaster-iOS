//
//  DownloadsViewController.m
//  Laracaster
//
//  Created by Jackie Chung on 19/02/2016.
//  Copyright © 2016 Reactive Studio. All rights reserved.
//

#import "DownloadsViewController.h"

typedef NS_ENUM(NSInteger,TABLEVIEW_TYPE) {
    
    TABLEVIEW_DOWNLOADING = 0,
    
    TABLEVIEW_DOWNLOADED
    
};

@interface DownloadsViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *downloadStatusControl;

@property (strong,nonatomic) UIBarButtonItem* addFolderBarBtn;

@end

@implementation DownloadsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)downloadStatusChanged:(id)sender {
    
    UISegmentedControl* control = (UISegmentedControl*)sender;
    
    if (control.selectedSegmentIndex == 0) {
        
        // hide the add folder btn if necessary
        if (_addFolderBarBtn != nil) {
            
            _addFolderBarBtn = nil;
            
            [self.navigationItem setRightBarButtonItem:nil];
            
        }

        
        // switch tableview
        [self switchToTableView:TABLEVIEW_DOWNLOADING];
        
    }
    
    if (control.selectedSegmentIndex == 1) {
        
        // show the add folder btn if necessary
        if (_addFolderBarBtn == nil) {
            
            _addFolderBarBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"add-folder"] style:UIBarButtonItemStyleDone target:self action:@selector(showAddFolderPrompt)];
            
            [_addFolderBarBtn setTintColor:[UIColor whiteColor]];
            
            [self.navigationItem setRightBarButtonItem:_addFolderBarBtn];
            
        }
        
        // switch tableview
        [self switchToTableView:TABLEVIEW_DOWNLOADED];
        
    }
    
}

// switch tableview and reloads the data if needed
-(void)switchToTableView:(TABLEVIEW_TYPE)tableview{
    
    switch (tableview) {
            
        case TABLEVIEW_DOWNLOADING:{
            
            // @todo:
            
        }
        
            break;
        
        case TABLEVIEW_DOWNLOADED:{
            
            // @todo:
            
        }
            break;
            
        default:
            break;
    }
    
}

// show an alert with textfield so that user can create a folder for grouping his videos
-(void)showAddFolderPrompt{
    
    // @todo:
    
}

@end
