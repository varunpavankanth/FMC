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
     return cell.contentView.frame.size.height+50;
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
       
        UIImageView *Small_Image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 100, 75)];
        [Small_Image sd_setImageWithURL:[NSURL URLWithString:[dic valueForKey:@"Small_Image"]]placeholderImage:[UIImage imageNamed:@"deafult_icon.png"]];
        [cell.contentView addSubview:Small_Image];
        UILabel *Lable=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(Small_Image.frame)+5, 0,CGRectGetWidth(self.view.frame)-120,0)];
        Lable.attributedText=attributedString;
        Lable.numberOfLines=0;
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
        border.frame = CGRectMake(CGRectGetMaxX(Small_Image.frame)+2, 5, 1, CGRectGetHeight(cell.contentView.frame)+45);
        [cell.contentView.layer addSublayer:border];
        
        //cell.imageView.image=[UIImage imageNamed:[img objectAtIndex:indexPath.row]];
        
    }
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(responseArray)
    {
        dic=[responseArray objectAtIndex:indexPath.section];
        UIWebView *view = [[UIWebView alloc] initWithFrame:CGRectMake(0,50, self.view.frame.size.width,self.view.frame.size.height-40)];
        NSString *url=[NSString stringWithFormat:@"https://docs.google.com/viewerng/viewer?url=%@",[dic valueForKey:@"book_path"]];
        NSURL *nsurl=[NSURL URLWithString:url];
        NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
        [view loadRequest:nsrequest];
        [self.view addSubview:view];
        
    }
}
-(void)EditorialsServercall

{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        [self.view makeToast:@"No internet connection" duration:1.0 position:@"center"];
    }
    else {
        
        
        NSString *URL =[NSString stringWithFormat:@"http://facilitymanagementcouncil.com/admin/service/editorials/%d",pageNumber];
        
        [APIDataFetcher loadDataFromAPIUsingSession:URL :^(id result)
         {
             
             if ([result isKindOfClass:[NSDictionary class]])
             {
                 responseArray=(NSMutableArray*)[(NSDictionary*)result valueForKeyPath:@"books_details"];
                 
                 [tv reloadData];
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




@end
