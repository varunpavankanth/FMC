//
//  History.m
//  FMC
//
//  Created by Nennu on 10/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import "History.h"
#import "APIDataFetcher.h"
#import "Reachability.h"
#import "UIView+Toast.h"

@interface History ()<UITableViewDelegate,UITableViewDataSource>
{
 NSMutableArray *responseArray;
    NSDictionary *dic;
    int pageNumber;
}
@property(nonatomic,retain)    UITableView*tableview;

@end

@implementation History

- (void)viewDidLoad {
    [super viewDidLoad];
    pageNumber =1;
    self.title=@"History";
    [self historyServercall];
    
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
      
        
        NSString *URL =[NSString stringWithFormat:@"http://facilitymanagementcouncil.com/admin/service/history/%d",pageNumber];
        
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
    cell.textLabel.text=[dic valueForKey:@"history_text"];
    }
    cell.textLabel.numberOfLines = 0;
    
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
