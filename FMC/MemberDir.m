//
//  MemberDir.m
//  FMC
//
//  Created by Nennu on 10/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import "MemberDir.h"
#import "Reachability.h"
#import "UIView+Toast.h"
#import "SVProgressHUD.h"
#import <QuartzCore/QuartzCore.h>
#import "APIDataFetcher.h"
#import "MembersDircell.h"
@interface MemberDir ()
{
    int pageNumber;
    NSMutableArray  * responseArray;
    NSMutableDictionary *dic;
     NSArray *searchResults;
    UIImageView *imgv;
     NSMutableArray * resultArray;
}

@end

@implementation MemberDir
@synthesize tv;
- (void)viewDidLoad {
    [super viewDidLoad];
    pageNumber = 1;

     [SVProgressHUD show];
        // Do any additional setup after loading the view.
    searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 44)];
    [self.view addSubview:searchBar];
   tv=[[UITableView alloc]initWithFrame:CGRectMake(0, 110, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    tv.backgroundColor=[UIColor whiteColor];
    tv.separatorColor=[UIColor clearColor];
    tv.delegate=self;
    tv.dataSource=self;
    [self.view addSubview:tv];
    [self eventServercall];
    
    
}
-(void)eventServercall

{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        [self.view makeToast:@"No internet connection" duration:1.0 position:@"center"];
    }
    else {
        if (!responseArray)
        {
            responseArray = [[NSMutableArray alloc] init];
        }
        else
        {
            [responseArray removeAllObjects];
        }
        
        NSString *URL =[NSString stringWithFormat:@"http://facilitymanagementcouncil.com/admin/service/members/%d",pageNumber];
        
        [APIDataFetcher loadDataFromAPIUsingSession:URL :^(id result)
         {
             if ([result isKindOfClass:[NSDictionary class]])
             {
                 NSArray * resultsArrayfromJSON=(NSMutableArray*)[(NSDictionary*)result valueForKeyPath:@"member_details"];
                 for (NSDictionary * resultDict in resultsArrayfromJSON)
                 {
                     MembersModel * track = [[MembersModel alloc] initWithDictionary:resultDict];
                     [responseArray addObject:track];
                 }
                 [tv reloadData];
                 [SVProgressHUD dismiss];

             }
             
         }:^(NSError *error)
         
         {
             if (error)
             {
                 NSLog(@"%@", error.localizedDescription);
             }

             
         }];
        
    }
}


-(void)sucesstask
{
    [tv reloadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   return responseArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor clearColor];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     MembersDircell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[MembersDircell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
  [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    MembersModel * track = [responseArray objectAtIndex:indexPath.section];
    
    if (track)
    {
//        cell.cellImageView.frame=CGRectMake(5 , 5, 50,50);
//        cell.labelDescription.frame=  CGRectMake(CGRectGetMaxX(cell.cellImageView.frame)+5,5, cell.cellImageView.frame.size.width,  50);
        [cell bindDataWithCell:track :indexPath :tableView];
    }

//    dic=[responseArray objectAtIndex:indexPath.section];
//    [cell.layer setCornerRadius:5.0f];
//    [cell.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
//    cell.layer.cornerRadius=7.0f;
//    cell.layer.borderWidth=1.0f;
//    cell.selectionStyle=UITableViewCellSelectionStyleNone;
//   // cell.layer.backgroundColor=[UIColor grayColor].CGColor;
//    
//    imgv=[[UIImageView alloc]initWithFrame:CGRectMake(5 , 5, 50,50)];
//    
//    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imgv.frame)+5,5, cell.frame.size.width,  50)];
//    lable.numberOfLines=0;
//   NSString *url =[dic valueForKey:@"profile_pic"] ;
//    NSData *imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
//    
//    UIImage *image = [UIImage imageWithData:imageData];
//    imgv.image=image;
//    imgv.layer.cornerRadius = 25.0f;
//    imgv.clipsToBounds = YES;
//    [cell.contentView addSubview:imgv];
//    
//
//    [WebImageOperations processImageDataWithURLString:url andBlock:^(NSData *imageData) {
//        if (self.view.window) {
//                    }
//        
//    }];
//        
//    
////        NSData *data = [NSData dataWithContentsOfURL:url];
////        UIImage *image = [[UIImage alloc] initWithData:data];
//    
//    
//    
// 
//    [cell.contentView addSubview:lable];
    
    
    
    return cell;
}
//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
//{
//    
//    [tableData removeAllObjects];
//    
//    if(searchText != nil && ![searchText isEqualToString:@""]){
//        
//        for(NSDictionary * book in dataSource){
//            NSString * title = [book objectForKey:@"TITLE"];
//            NSString * author = [book objectForKey:@"AUTHOR"];
//            
//            NSRange titleRange = [[title lowercaseString] rangeOfString:[searchText lowercaseString]];
//            NSRange authorRange = [[author lowercaseString] rangeOfString:[searchText lowercaseString]];
//            
//            if(titleRange.location != NSNotFound || authorRange.location != NSNotFound)
//                [tableData addObject:book];
//        }
//        
//    }
//    
//    [tableView reloadData];
//}
- (void)searchBar:(UISearchBar *)SearchBar textDidChange:(NSString *)searchText
{
    [searchBar resignFirstResponder];
    [tv reloadData];
}
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    searchText];
    
    searchResults = [responseArray filteredArrayUsingPredicate:resultPredicate];
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
