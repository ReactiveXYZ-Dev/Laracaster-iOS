//
//  DownloadsFolderViewController.m
//  Laracaster
//
//  Created by Jackie Chung on 14/03/2016.
//  Copyright © 2016 Reactive Studio. All rights reserved.
//

#import "DownloadsFolderViewController.h"

#import "LaracastVideoFileInstance.h"

#import "DownloadedFileSystemTableViewCell.h"

#import "Extensions.h"

@interface DownloadsFolderViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) UITableView* videoTableView;

@end

@implementation DownloadsFolderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _videoTableView = [[UITableView alloc]init];
    
    _videoTableView.delegate = self;
    
    _videoTableView.dataSource = self;
    
    [self.view addSubview:_videoTableView];
    
    UIView* selfView = self.view;
    
    NSDictionary* views = NSDictionaryOfVariableBindings(selfView,_videoTableView);
    
    [selfView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0)-[_videoTableView]-(0)-|" options:0 metrics:nil views:views]];
    
    [selfView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[_videoTableView]" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views ]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView DataSource / Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 75;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _videoData.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* identifier = @"cell";
    
    DownloadedFileSystemTableViewCell* cell = (DownloadedFileSystemTableViewCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        
        cell = [[DownloadedFileSystemTableViewCell alloc]init];
        
    }
    
    cell.isFile = YES;
    
    cell.infoLabel.text = [_videoData objectAtIndex:indexPath.row].fileName;
    
    cell.decoratorView.backgroundColor = [Extensions randomMaterialColor];
    
    return cell;
    
}

// @todo: add selection event to each cell...


@end
