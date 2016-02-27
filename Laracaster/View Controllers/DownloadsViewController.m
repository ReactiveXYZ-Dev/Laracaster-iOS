//
//  DownloadsViewController.m
//  Laracaster
//
//  Created by Jackie Chung on 19/02/2016.
//  Copyright © 2016 Reactive Studio. All rights reserved.
//

#import "DownloadsViewController.h"

#import "Laracaster-Bridging-Header.h"

typedef NS_ENUM(NSInteger,TABLEVIEW_TYPE) {
    
    TABLEVIEW_DOWNLOADING = 0,
    
    TABLEVIEW_DOWNLOADED
    
};

@interface DownloadsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UISegmentedControl *downloadStatusControl;

@property (strong,nonatomic) UIBarButtonItem* addFolderBarBtn;

@property (strong,nonatomic) UITableView* downloadingTableView;

@property (strong,nonatomic) UITableView* downloadedTableView;

@end

@implementation DownloadsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    // Add the tableviews
    _downloadingTableView = [[UITableView alloc]initWithFrame:self.view.frame];
    
    _downloadingTableView.tag = TABLEVIEW_DOWNLOADING;
    
    _downloadingTableView.delegate = self;
    
    _downloadingTableView.dataSource = self;
    
    _downloadingTableView.hidden = YES;
    
    [self.view addSubview:_downloadingTableView];
    
    _downloadedTableView = [[UITableView alloc]initWithFrame:self.view.frame];
    
    _downloadedTableView.tag = TABLEVIEW_DOWNLOADED;
    
    _downloadedTableView.delegate = self;
    
    _downloadedTableView.dataSource = self;
    
    _downloadedTableView.hidden = YES;
    
    [self.view addSubview:_downloadedTableView];
    
    // switch to the default tableview [For testing, now default to the downloaded interface]
    [_downloadStatusControl setSelectedSegmentIndex:1];
    
    [self switchToTableView:TABLEVIEW_DOWNLOADED];
    
    
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
            
            [_downloadingTableView reloadData];
            
            _downloadingTableView.hidden = NO;
        }
        
            break;
        
        case TABLEVIEW_DOWNLOADED:{
            
            [_downloadedTableView reloadData];
            
            _downloadedTableView.hidden = NO;
            
        }
            break;
            
        default:
            break;
    }
    
}

// show an alert with textfield so that user can create a folder for grouping his videos
-(void)showAddFolderPrompt{
    
    // @todo: use BMInputBox after successful compliation
    
}

#pragma mark - TableView Delegates and Data source


@end
