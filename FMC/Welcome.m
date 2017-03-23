//
//  Welcome.m
//  FMC
//
//  Created by Nennu on 10/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import "Welcome.h"
#import "Reachability.h"
#import "UIView+Toast.h"
#import "APIDataFetcher.h"
@interface Welcome ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *responseArray;
    NSDictionary *dic;
    int pageNumber;
}
@property(nonatomic,retain)    UITableView*tableview;
@end

@implementation Welcome

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"Welcome Message";
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    //[self historyServercall];
    
    _tableview=[[UITableView alloc]init];
    _tableview.frame=self.view.bounds;
    _tableview.dataSource=self;
    _tableview.delegate=self;
    _tableview.backgroundColor=[UIColor whiteColor];
    _tableview.separatorColor=[UIColor clearColor];
    [self.view addSubview:_tableview];
    
    _tableview.rowHeight = UITableViewAutomaticDimension;
    _tableview.estimatedRowHeight = 44;
    _tableview.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self historyServercall];
   
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


-(void)historyServercall

{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        [self.view makeToast:@"No internet connection" duration:1.0 position:@"center"];
    }
    else {
        
        
        NSString *URL =[NSString stringWithFormat:@"http://facilitymanagementcouncil.com/ws.php"];
        
        [APIDataFetcher loadDataFromAPIUsingSession:URL :^(id result)
         {
             dic=result;
             //             if ([result isKindOfClass:[NSDictionary class]])
             //             {
             //                 responseArray=(NSMutableArray*)[(NSDictionary*)result valueForKeyPath:@"history_text"];
             ////                 for (NSDictionary * resultDict in resultsArrayfromJSON)
             ////                 {
             ////                     responseArray [resultDict ]
             ////                 }
             [_tableview reloadData];
             //
             //             }
             
         }:^(NSError *error)
         
         {
             if (error)
             {
                 NSLog(@"%@", error.localizedDescription);
             }
             
             
         }];
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
    if (dic) {
        cell.textLabel.text=[dic valueForKey:@"welcome_text"];
    }
    cell.textLabel.numberOfLines = 0;
    [cell.textLabel sizeToFit];
    
    return cell;
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
