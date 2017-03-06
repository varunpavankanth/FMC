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
#import "APIDataFetcher.h"
#import "MembersDircell.h"
#import "UIImageView+WebCache.h"
@interface MemberDir ()
{
    int pageNumber;
    NSMutableArray  * responseArray;
    NSMutableDictionary *dic;
     NSArray *searchResults;
    UIImageView *imgv;
     NSMutableArray * resultArray;
    NSArray * resultsArrayfromJSON;
}

@end

@implementation MemberDir
@synthesize tv;
- (void)viewDidLoad {
    [super viewDidLoad];
    pageNumber = 1;

     [SVProgressHUD show];
        // Do any additional setup after loading the view.
//    searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 44)];
//    [self.view addSubview:searchBar];
    self.searchController=[[UISearchController alloc]initWithSearchResultsController:nil];
    self.searchController.searchBar.delegate=self;
    self.searchController.searchResultsUpdater=self;
    self.searchController.dimsBackgroundDuringPresentation=NO;
       tv=[[UITableView alloc]initWithFrame:CGRectMake(0,0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    tv.tableHeaderView=self.searchController.searchBar;
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
                resultsArrayfromJSON=(NSMutableArray*)[(NSDictionary*)result valueForKeyPath:@"member_details"];
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
    if (self.searchController.active == YES && ![self.searchController.searchBar.text isEqualToString:@""])
    {
        return resultArray.count;
    }
    else
    {
   return resultsArrayfromJSON.count;
    }
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
    
    if(resultsArrayfromJSON)
       {
            if (self.searchController.active == YES && ![self.searchController.searchBar.text isEqualToString:@""])
                dic=[resultArray objectAtIndex:indexPath.section];
           else
              dic=[resultsArrayfromJSON objectAtIndex:indexPath.section];
           
           NSString *firstname=[dic valueForKey:@"first_name"];
           NSString *Lastname=[dic valueForKey:@"last_name"];
           NSString *companyname=[dic valueForKey:@"company_name"];
           NSString *apd=[NSString stringWithFormat:@"%@ %@\n%@",[self stringWithSentenceCapitalization:firstname],[self stringWithSentenceCapitalization:Lastname],[self stringWithSentenceCapitalization:companyname]];
           NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:apd attributes:nil];
           cell.cellImageView=[[UIImageView alloc]initWithFrame:CGRectMake(5 ,8, 60,60)];
           cell.cellImageView.layer.cornerRadius = 30.0f;
           cell.cellImageView.clipsToBounds = YES;
           cell.labelDescription=  [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cell.cellImageView.frame)+5,5, cell.frame.size.width,  50)];
           cell.labelDescription.attributedText = attributedText;
           cell.labelDescription.numberOfLines=0;
           // [self.labelDescription sizeToFit];
           NSString *imageUrl = [dic valueForKey:@"profile_pic"];;
           [cell.cellImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"deafult_icon.png"]];
           [cell.contentView addSubview:cell.labelDescription];
           [cell.contentView  addSubview:cell.cellImageView];
       }
    
//    MembersModel * track;
//  
//    if (self.searchController.active == YES && ![self.searchController.searchBar.text isEqualToString:@""])
//    {
//    track = [resultArray objectAtIndex:indexPath.section];
//    }
//    else
//    {
//        track = [responseArray objectAtIndex:indexPath.section];
//    }
//    if (track)
//    {
//        [cell bindDataWithCell:track :indexPath :tableView];
//    }


    
    return cell;
}
-(NSString*)stringWithSentenceCapitalization:(NSString*)str
{
    
    // Get the first character in the string and capitalize it.
    NSString *firstCapChar = [[str substringToIndex:1] capitalizedString];
    
    NSMutableString * temp = [str mutableCopy];
    
    // Replace the first character with the capitalized version.
    [temp replaceCharactersInRange:NSMakeRange(0, 1) withString:firstCapChar];
    
    return temp ;
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSLog(@"result array %@",resultArray);
    NSPredicate * predicatefirst_name=[NSPredicate predicateWithFormat:@"first_name contains[cd] %@",searchController.searchBar.text];
    NSPredicate *predicatelast_name=[NSPredicate predicateWithFormat:@"last_name contains[cd] %@",searchController.searchBar.text];
    NSPredicate *predicatecompany_name=[NSPredicate predicateWithFormat:@"company_name contains[cd] %@",searchController.searchBar.text];
    NSArray *subPredicates = [NSArray arrayWithObjects:predicatefirst_name,predicatelast_name,predicatecompany_name,nil];
    NSPredicate *orPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:subPredicates];
    resultArray = [NSMutableArray arrayWithArray:[resultsArrayfromJSON filteredArrayUsingPredicate:orPredicate]];
//    NSString *searchString = searchController.searchBar.text;
//    [self searchForText:searchString scope:searchController.searchBar.selectedScopeButtonIndex];
    [self.tv reloadData];
}
//- (void)searchBar:(UISearchBar *)SearchBar textDidChange:(NSString *)searchText
//{
//    [searchBar resignFirstResponder];
//    [tv reloadData];
//}
//- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
//{
//    NSPredicate *resultPredicate = [NSPredicate
//                                    predicateWithFormat:@"SELF contains[cd] %@",
//                                    searchText];
//    
//    searchResults = [responseArray filteredArrayUsingPredicate:resultPredicate];
//}

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
