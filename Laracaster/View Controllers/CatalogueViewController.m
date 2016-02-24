//
//  CatalogueViewController.m
//  Laracaster
//
//  Created by Jackie Chung on 13/02/2016.
//  Copyright © 2016 Reactive Studio. All rights reserved.
//

#import "CatalogueViewController.h"

@interface CatalogueViewController ()

@end

@implementation CatalogueViewController

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder Url:kLaracastCatalogueUrl]) {
        
    }
    
    return self;
    
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [navBarItem setTitle:@"Catalogues"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
