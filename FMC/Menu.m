//
//  Menu.m
//  FMC
//
//  Created by Nennu on 09/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import "Menu.h"
#import "UIImageView+WebCache.h"
@interface Menu ()

@end

@implementation Menu

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
   // self.view.backgroundColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    self.view.backgroundColor=[UIColor whiteColor];
    tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
   
    //tableview.autoresizingMask=YES;
    tableview.scrollEnabled=YES;
    tableview.contentSize=CGSizeMake(tableview.frame.size.width,self.view.frame.size.height);
    tableview.bounces = YES;
    tableview.delegate=self;
    tableview.dataSource=self;
    [self.view addSubview:tableview];
    itemslist=[NSArray arrayWithObjects:@"Profile",@"Home",@"Welcome Message",@"History",@"Member Directory",@"Business Enablers",@"Awards",@"CSR",@"Gallery",@"Events",@"Editorials",@"Contact us",@"Change Password",@"Logout" ,nil];
    imageslist=[NSArray arrayWithObjects:@"login_icon.png",@"home_icon.png",@"welcome_icon.png",@"history_icon.png",@"member_icon.png",@"knowledge_icon.png",@"awards_icon.png",@"gallery_icon.png",@"gallery_icon.png",@"events_icon.png",@"editorials_icon.png",@"contactsus_icon.png",@"chhangepassword.png",@"logout_icon.png" ,nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return [itemslist count];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     SWRevealViewController *revealController = self.revealViewController;
     UIViewController *newFrontController = nil;
    if (indexPath.row==0) {
        newFrontController=[[EditViewController alloc]init];
        [(UINavigationController*)revealController.frontViewController pushViewController:newFrontController animated:YES];
        [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
    }
    else if (indexPath.row==1)
    {
    
        [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
           // newFrontController=[[Home alloc]init];

        NSLog(@"Welcome Message");

    }
    else if (indexPath.row==2)
    {
        newFrontController=[[Welcome alloc]init];
        [(UINavigationController*)revealController.frontViewController pushViewController:newFrontController animated:YES];
        [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
    }
    else if (indexPath.row==3)
    {
        newFrontController=[[History alloc]init];
        [(UINavigationController*)revealController.frontViewController pushViewController:newFrontController animated:YES];
        [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
    }
    else if (indexPath.row==4)
    {
        newFrontController=[[MemberDir alloc]init];
        [(UINavigationController*)revealController.frontViewController pushViewController:newFrontController animated:YES];
        [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
    }
    else if (indexPath.row==5)
    {
        newFrontController=[[BusinessEnablers alloc]init];
        [(UINavigationController*)revealController.frontViewController pushViewController:newFrontController animated:YES];
        [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
    }
    else if (indexPath.row==6)
    {
        newFrontController=[[Awards alloc]init];
        [(UINavigationController*)revealController.frontViewController pushViewController:newFrontController animated:YES];
        [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
    }
    
    else if (indexPath.row==7)
    {
        newFrontController=[[CSRViewController alloc]init];
        [(UINavigationController*)revealController.frontViewController pushViewController:newFrontController animated:YES];
        [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
    }

    else if (indexPath.row==8)
    {
        newFrontController=[[Gallery alloc]init];
        [(UINavigationController*)revealController.frontViewController pushViewController:newFrontController animated:YES];
        [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
    }
    else if (indexPath.row==9)
    {
        newFrontController=[[Events alloc]init];
      //  [newFrontController eventServercall:1];
        [(UINavigationController*)revealController.frontViewController pushViewController:newFrontController animated:YES];
        [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
    }
    else if (indexPath.row==10)
    {
        newFrontController=[[Edtorials alloc]init];
        [(UINavigationController*)revealController.frontViewController pushViewController:newFrontController animated:YES];
        [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
    }
    else if (indexPath.row==11)
    {
        newFrontController=[[ContactUs alloc]init];
        [(UINavigationController*)revealController.frontViewController pushViewController:newFrontController animated:YES];
        [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
    }
    else if (indexPath.row==12)
    {
        newFrontController=[[ChangePassword alloc]init];
        [(UINavigationController*)revealController.frontViewController pushViewController:newFrontController animated:YES];
        [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
    }
    else
    {
        NSString * storyboardIdentifier = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardIdentifier bundle: nil];
        ViewController *logout =[storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
         [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"status"];
      [self presentViewController:logout animated:YES completion:nil];
    }
   
    
 
 // [revealController dismissViewControllerAnimated:self completion:nil];
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   // UITableViewCell * cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    static NSString *CellIdentifier = @"cellID";
    customCell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    customCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    customCell.backgroundColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    customCell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (indexPath.row==0)
    {
         tableview.rowHeight=150;
        customCell.backgroundColor=[UIColor whiteColor];
        NSURL *url =[NSURL URLWithString:[[NSUserDefaults standardUserDefaults]
                                          stringForKey:@"profile_pic" ]] ;
       //customCell.frame=CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height/2);
        UIImageView *imgv=[[UIImageView alloc]initWithFrame:CGRectMake(5 , 5, 90,90)];
        
        [imgv sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"deafult_icon.png"]];
        imgv.layer.cornerRadius = 45.0f;
        imgv.clipsToBounds = YES;
        [customCell addSubview:imgv];
        
        
        UIImageView *myImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgv.frame)-30,CGRectGetMaxY(imgv.frame)-30,40,40 )];

        
        myImage.image = [UIImage imageNamed:@"edit.png"];
        myImage.layer.cornerRadius=10;
        [customCell addSubview:myImage];
        
        
        
        
        
        

       UILabel *username=[[UILabel alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(imgv.frame) ,customCell.frame.size.width ,50 )];
        NSString *name=[[NSUserDefaults standardUserDefaults]
                        stringForKey:@"user_name"];
        NSString *Company=[[NSUserDefaults standardUserDefaults]
                           stringForKey:@"company_name"];
        NSString *text = [NSString stringWithFormat:@"%@\n%@",[ self stringWithSentenceCapitalization:name] ,[ self stringWithSentenceCapitalization:Company]];
        NSMutableAttributedString *attributedtext=[[NSMutableAttributedString alloc]initWithString:text];
        NSRange  range=[text rangeOfString:name];
        UIFont *boldFont = [UIFont fontWithName:@"Roboto-Regular" size:14];
        [attributedtext setAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0],
                                        NSFontAttributeName:boldFont} range:range];
        [attributedtext setAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0],
                                        NSFontAttributeName:[UIFont fontWithName:@"Roboto-Light" size:12]} range:[text rangeOfString:Company]];
        username.attributedText=attributedtext;
        username.numberOfLines=0;
        username.textColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
        [customCell addSubview:username];
    }
    else
    {
         tableview.rowHeight=tableview.frame.size.height/12;
    customCell.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/8);
        UIImageView *imgv=[[UIImageView alloc]initWithFrame:CGRectMake(5 , 10, 25, 25)];
        imgv.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",[imageslist objectAtIndex:indexPath.row]]];
    UILabel *dataLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imgv.frame)+20,0,self.view.frame.size.width,50)];
    dataLabel.textColor=[UIColor whiteColor];
    dataLabel.text = [NSString stringWithFormat:@"%@",[itemslist objectAtIndex:indexPath.row]];
        dataLabel.textAlignment=NSTextAlignmentNatural;
    [customCell addSubview:imgv];
        customCell.separatorInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, customCell.frame.size.width+100);
    [customCell addSubview:dataLabel];
   
   }
    return customCell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
