//
//  Edtorials.m
//  FMC
//
//  Created by Nennu on 10/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import "Edtorials.h"
#import "Reachability.h"
#import "UIView+Toast.h"
#import "APIDataFetcher.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "WebViewController.h"

@interface Edtorials ()

{
    UITableView*tv;
    NSMutableArray*img;
    NSMutableArray* name;
    int pageNumber;
    NSMutableArray *responseArray;
    NSMutableDictionary *dic;
    
}




@end

@implementation Edtorials

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"Editorials";
    
    tv=[[UITableView alloc]init];
    tv.frame=self.view.bounds;
    tv.dataSource=self;
    tv.delegate=self;
    tv.backgroundColor=[UIColor whiteColor];
    tv.separatorColor=[UIColor clearColor];
    [self.view addSubview:tv];
    
    name=[[NSMutableArray alloc]initWithObjects:@"Diwali",@"Holi",@"Ugadi",@"Sankranthi",@"Shivarathri",@"Dusshera", nil];
    
    img=[[NSMutableArray alloc]initWithObjects:@"2.jpeg",@"2.jpeg",@"2.jpeg",@"2.jpeg",@"2.jpeg",@"2.jpeg", nil];
    pageNumber=1;
    // Do any additional setup after loading the view, typically from a nib.
    [self EditorialsServercall];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  [responseArray count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (responseArray)
     return cell.contentView.frame.size.height;
    else
        return 150;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 1000;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
   
 [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (responseArray) {
        
        dic=[responseArray objectAtIndex:indexPath.section];
        
    NSString *labletext = [NSString stringWithFormat:@"%@ \n\n%@",[self stringWithSentenceCapitalization:[dic valueForKey:@"book_name"]],[dic valueForKey:@"book_description"]];
        NSMutableAttributedString *attributedString=[[NSMutableAttributedString alloc]initWithString:labletext];
        
       
        UIImageView *Small_Image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 75)];
        [Small_Image sd_setImageWithURL:[NSURL URLWithString:[dic valueForKey:@"Small_Image"]]placeholderImage:[UIImage imageNamed:@"deafult_icon.png"]];
        [cell.contentView addSubview:Small_Image];
        
       
        
        
        UILabel *Lable=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(Small_Image.frame)+5, 0,CGRectGetWidth(self.view.frame)-120,0)];
        Lable.attributedText=attributedString;
        Lable.numberOfLines=0;
        Lable.font=[UIFont fontWithName:@"Roboto-Regular" size:16];
        Lable.textColor=[UIColor blackColor];
        [Lable sizeToFit];
        [cell.contentView addSubview:Lable];
        cell.layer.borderWidth=1.0f;
        cell.layer.borderColor=[UIColor lightGrayColor].CGColor;
        
       CALayer *border = [CALayer layer];
        CGFloat borderWidth = 1.0f;
        border.borderWidth = borderWidth;
        border.borderColor = [UIColor grayColor].CGColor;
       
        
        CGRect frame=cell.contentView.frame;
        frame.size.height=CGRectGetMaxY(Lable.frame)+10;
        [cell.contentView setFrame:frame];
        border.frame = CGRectMake(CGRectGetMaxX(Small_Image.frame)+2, 5, 1, CGRectGetHeight(cell.contentView.frame)-5);
        [cell.contentView.layer addSublayer:border];
         [Small_Image setCenter:CGPointMake(Small_Image.center.x, cell.contentView.frame.size.height/2)];
    
        
        //cell.imageView.image=[UIImage imageNamed:[img objectAtIndex:indexPath.row]];
        
    }
    return cell;
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
    
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(responseArray)
    {
        dic=[responseArray objectAtIndex:indexPath.section];
        WebViewController *VC=[[WebViewController alloc]init];
        if (responseArray) {
            dic=[responseArray objectAtIndex:indexPath.row];
            VC.strg=[dic valueForKey:@"book_path"];
        }
        
        [self.navigationController pushViewController:VC animated:YES];
//        [SVProgressHUD show];
//        dic=[responseArray objectAtIndex:indexPath.section];
//        UIWebView *view = [[UIWebView alloc] initWithFrame:CGRectMake(0,50, self.view.frame.size.width,self.view.frame.size.height-40)];
//        view.delegate=self;
//        NSString *url=[NSString stringWithFormat:@"https://docs.google.com/viewerng/viewer?url=%@",[dic valueForKey:@"book_path"]];
//        NSURL *nsurl=[NSURL URLWithString:url];
//        NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
//        [view loadRequest:nsrequest];
//        [self.view addSubview:view];
        
    }
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}
-(void)EditorialsServercall

{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        [SVProgressHUD dismiss];
        [self.view makeToast:@"No internet connection" duration:1.0 position:@"center"];
        UIAlertController *alertController;
        alertController = [UIAlertController  alertControllerWithTitle:@"No internet"  message:@"This feature requires internet connection.please check your internet settings and try again"  preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            //            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:url];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else {
        
        
        NSString *URL =[NSString stringWithFormat:@"http://facilitymanagementcouncil.com/admin/service/editorials/%d",pageNumber];
        
        [APIDataFetcher loadDataFromAPIUsingSession:URL :^(id result)
         {
             
             if ([result isKindOfClass:[NSDictionary class]])
             {
                 [SVProgressHUD dismiss];

                 responseArray=(NSMutableArray*)[(NSDictionary*)result valueForKeyPath:@"books_details"];
                 
                 [tv reloadData];
                 
             }
             else
             { [SVProgressHUD dismiss];

                 [self.view makeToast:@"Please check network" duration:1.0 position:@"center"];
             }
         }:^(NSError *error)
         
         {
             if (error)
             {
                 [SVProgressHUD dismiss];
                 
                 [self.view makeToast:@"Please check network" duration:1.0 position:@"center"];
                 NSLog(@"%@", error.localizedDescription);
             }
             
             
         }];
        
    }
}




@end
