//
//  AwardsinforViewController.m
//  FMC
//
//  Created by Vinod Kumar on 17/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import "AwardsinforViewController.h"
#import "Reachability.h"
#import "UIView+Toast.h"
#import "APIDataFetcher.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "WebViewController.h"


@interface AwardsinforViewController ()
{
    UITableView*tv;
    BOOL selected;
    NSInteger selectedButtonTag;
    NSMutableArray *responseArray;
    NSMutableDictionary *dic;
    int pageNumber;
}
@end

@implementation AwardsinforViewController
@synthesize tv;
- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    selected=NO;
    self.images=[[NSMutableArray alloc]initWithObjects:@"cric.jpeg",@"login_icon.png",@"login_icon.png",@"login_icon.png",@"login_icon.png",@"login_icon.png", nil];
    self.label1=[[NSMutableArray alloc]initWithObjects:@"Name",@"Name",@"Name",@"Name",@"Name",@"Name", nil];
    self.label2=[[NSMutableArray alloc]initWithObjects:@"CateogryName",@"CateogryName",@"CateogryName",@"CateogryName",@"CateogryName",@"CateogryName", nil];
    // Do any additional setup after loading the view.
    tv=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    tv.backgroundColor=[UIColor whiteColor];
    tv.delegate=self;
    tv.dataSource=self;
    tv.separatorColor=[UIColor clearColor];
    pageNumber=1;
    [self AwardsServercall];
    [self.view addSubview:tv];
    
   
    

    // Do any additional setup after loading the view.
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
    if((selected) && (selectedButtonTag == indexPath.section))
    {
        
        return cell1.contentView.frame.size.height;
    }
    else
        return 80;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor clearColor];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     cell1=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell1==nil) {
        cell1=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    [cell1.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if(responseArray)
    {
        dic=[responseArray objectAtIndex:indexPath.section];
    [cell1.layer setCornerRadius:5.0f];
    [cell1.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
    NSString *first_name=[dic valueForKey:@"first_name"];
    NSString *last_name=[dic valueForKey:@"last_name"];
        NSString *company_name=[dic valueForKey:@"company_name"];
    NSString *apd=[NSString stringWithFormat:@"%@ %@\n%@",first_name,last_name,company_name];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:apd attributes:nil];
    cell1.layer.cornerRadius=7.0f;
    cell1.layer.borderWidth=1.0f;
    cell1.selectionStyle=UITableViewCellSelectionStyleNone;
    UIImageView *imgv=[[UIImageView alloc]initWithFrame:CGRectMake(5 , 5, 50,50)];
         [imgv sd_setImageWithURL:[NSURL URLWithString:[dic valueForKey:@"profile_pic"]] placeholderImage:[UIImage imageNamed:@"deafult_icon.png"]];
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imgv.frame)+5,5, cell1.frame.size.width,  50)];
    lable.attributedText=attributedText;
    lable.numberOfLines=0;
    imgv.clipsToBounds = YES;
    UIView * additionalSeparator = [[UIView alloc] initWithFrame:CGRectMake(0,cell1.frame.size.height,cell1.frame.size.width,3)];
    additionalSeparator.backgroundColor = [UIColor grayColor];
    [cell1 addSubview:lable];
    [cell1 addSubview:imgv];

    UIButton*arrow=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.view.frame)-50, 40, 40, 40)];
    arrow.tag=indexPath.section;
    [arrow addTarget:self action:@selector(getinformation:) forControlEvents:UIControlEventTouchUpInside];
    UIImage *aboutbtn = [UIImage imageNamed:@"arrow1.png"];
     
    if((selected) && (selectedButtonTag == indexPath.section))
    {
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0,90, cell1.frame.size.width,  50)];
        CALayer *border=[CALayer layer];
        border.borderWidth=1.0f;
        border.borderColor=[UIColor lightGrayColor].CGColor;
        border.frame=CGRectMake(0,0,CGRectGetMaxX(cell1.frame),1);
        [view.layer addSublayer:border];
        [cell1.contentView addSubview:view];
        UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(10,120, cell1.frame.size.width,  0)];
        lable.attributedText=attributedText;
        // lable.backgroundColor=[UIColor blueColor];
        lable.numberOfLines=0;
        lable.text = [dic valueForKey:@"award_description"];
        lable.textColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
        [lable sizeToFit];
        [cell1.contentView addSubview:lable];
        aboutbtn = [UIImage imageNamed:@"sidearrow.png"];
        CGRect frame=cell1.contentView.frame;
        frame.size.height=CGRectGetMaxY(lable.frame)+10;
        [cell1.contentView setFrame:frame];
    }
     [arrow setImage:aboutbtn forState:UIControlStateNormal];
     [cell1.contentView addSubview:arrow];
    }
    return cell1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(responseArray)
    {

        dic=[responseArray objectAtIndex:indexPath.section];
        WebViewController *VC=[[WebViewController alloc]init];
        if (responseArray) {
            dic=[responseArray objectAtIndex:indexPath.row];
            VC.strg=[dic valueForKey:@"award_doc"];
        }
        
        [self.navigationController pushViewController:VC animated:YES];
//        [SVProgressHUD show];
//        dic=[responseArray objectAtIndex:indexPath.section];
//        UIWebView *view = [[UIWebView alloc] initWithFrame:CGRectMake(0,50, self.view.frame.size.width,self.view.frame.size.height-40)];
//        NSString *url=[NSString stringWithFormat:@"https://docs.google.com/viewerng/viewer?url=%@",[dic valueForKey:@"award_doc"]];
//        view.delegate=self;
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
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
    
}
-(void)AwardsServercall

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
      //  [self.view makeToast:@"No internet connection" duration:1.0 position:@"center"];
    }
    else {
        
        
        NSString *URL =[NSString stringWithFormat:@"http://facilitymanagementcouncil.com/admin/service/awards/%@/%d",self.Year,pageNumber];
        
        [APIDataFetcher loadDataFromAPIUsingSession:URL :^(id result)
         {
             
             if ([result isKindOfClass:[NSDictionary class]])
             {
                 [SVProgressHUD dismiss];
                 responseArray=(NSMutableArray*)[(NSDictionary*)result valueForKeyPath:@"award_details"];
                 
                 [tv reloadData];
             }
             else
             {
                 [SVProgressHUD dismiss];
                 [self.view makeToast:@"Please check network" duration:1.0 position:@"center"];
                 

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
-(void)getinformation:(UIButton*)button
{
    selectedButtonTag = button.tag;
    dic = [responseArray objectAtIndex:button.tag];
    selected=!selected;
    [tv reloadData];

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
