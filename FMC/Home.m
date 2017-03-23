//
//  Home.m
//  FMC
//
//  Created by Nennu on 09/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import "Home.h"
#import "shareViewController.h"
#import "Commentsviewcontroller.h"
#import "Reachability.h"
#import "UIView+Toast.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"

@interface Home ()
{
    NSMutableDictionary *dic;
    NSMutableDictionary *postdic;
    NSMutableDictionary *likedic;
    NSError *error1;
    NSMutableArray *postdetailsarray;
    NSInteger Sectionpath;
    int lastpage;
    int pageno;
    int post_like;
    NSUInteger myCount;
    NSInteger imagepath;
    
}
@property  NSURLSession *urlSession;

@end

@implementation Home
@synthesize Statustextfield,tableview;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
       [SVProgressHUD setForegroundColor:[UIColor blueColor]];
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
     [SVProgressHUD show];
    self.documentInteractionController.delegate=self;
    NSURLSessionConfiguration *sessionConfig=[NSURLSessionConfiguration defaultSessionConfiguration];
    self.urlSession= [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title=@"Home";
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    UIBarButtonItem *slide = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"side_menu_icon.png"]  style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem = slide;
    
    array=[NSArray arrayWithObjects:@"one",@"two",@"three",@"four", nil];
    tableview.delegate=self;
    tableview.dataSource=self;
    tableview.clipsToBounds=YES;
    tableview.separatorColor=[UIColor clearColor];
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    pageno=1;
    post_like=0;
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init]; [refreshControl addTarget:self action:@selector(Refreshtableview) forControlEvents:UIControlEventValueChanged];
    tableview.refreshControl = refreshControl;
  //  self.refr
    if (networkStatus == NotReachable)
    {
        [self.view makeToast:@"No internet connection" duration:1.0 position:@"center"];
    }
    else
    {
    [self servercall];
    }
}
-(void)Refreshtableview
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        [self.view makeToast:@"No internet connection" duration:1.0 position:@"center"];
         [tableview.refreshControl endRefreshing];
    }
    else {
    postdetailsarray=nil;
    lastpage=0x00;
    pageno=1;
    [self servercall];
    [[[SDWebImageManager sharedManager] imageCache] clearDisk];
    [tableview.refreshControl endRefreshing];
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([dic objectForKey:@"posts_details"])
    {
        if (!lastpage)
        {
    if (indexPath.section ==  postdetailsarray.count-2) {
        NSLog(@"load more");
        pageno++;
        NSLog(@"page no:%d",pageno);
        [self servercall];
    }
    }
    else if(indexPath.section==myCount)
        {
            [self.view makeToast:@"No more data" duration:1.0 position:@"bottom"];
            
        }
    }
//    if(tableView.contentOffset.y<=-20)
//    {
//         postdetailsarray =nil;
//        [self servercall];
//       
//    }
}

-(void)servercall
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
          [SVProgressHUD dismiss];
       // [self.view makeToast:@"No internet connection" duration:1.0 position:@"center"];
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
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
         NSString *URL =[NSString stringWithFormat:@"http://facilitymanagementcouncil.com/admin/service/posts/%d/%@",pageno,[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"]];
    [request setURL:[NSURL URLWithString:URL]];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:self delegateQueue: [NSOperationQueue mainQueue]];
    // NSDictionary *dic;
    NSURLSessionDataTask *dataTask =[defaultSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                     {
                                         if(data!=nil)
                                         {
                                         id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                        // NSLog(@"%@",json);
                                         if ([json objectForKey:@"posts_details"])
                                         {
                                         dic=json;
                                         [self sucesstask];
                                         }
                                         else
                                         {
                                             NSLog(@"nolonger data present ");
                                             NSLog(@"last page no:%d",pageno);
                                             lastpage=pageno;
                                             pageno=1;
                                             myCount = [postdetailsarray count];
                                         }
                                         }
                                         else{
                                             NSLog(@"data got nil");
                                              [SVProgressHUD dismiss];
                            [self.view makeToast:@"Please check network" duration:1.0 position:@"center"];
//                                            UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"Sorry"  message:@"Some thing went worng please refresh after some time"  preferredStyle:UIAlertControllerStyleAlert];
//                                             [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                                                 [alertController dismissViewControllerAnimated:YES completion:nil];
//                                             }]];
//                                             [self presentViewController:alertController animated:YES completion:nil];
                                         }
                                         
                                                                }];
                                         
    [dataTask resume];
    }
                                     
}
-(void)sucesstask
{
     [SVProgressHUD dismiss];
    if(!postdetailsarray)
    {
    postdetailsarray=[[dic objectForKey:@"posts_details"] mutableCopy];
    }
    else{
        if ([dic objectForKey:@"posts_details"]) {
            
        NSMutableArray *arry=[[NSMutableArray alloc]init];
        arry=[[dic objectForKey:@"posts_details"] mutableCopy];
         [(NSMutableArray *)postdetailsarray addObjectsFromArray:arry]  ;
        }
    }
   [tableview reloadData];
    
   // NSLog(@"%@",postdetailsarray);
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // customCell.textLabel.text=[self.dataSource objectAtIndex:indexPath.row];
    if (indexPath.section==0)
        return 40;
    else
        return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 1000;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    //#warning Incomplete implementation, return the number of sections
    if (postdetailsarray)
        return postdetailsarray.count+1;
    else
      return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"FDFeedCell";
    if (indexPath.section==0)
    {
      //  customCell=(TableViewCell *)[tableview dequeueReusableCellWithIdentifier:@"cell"];
//        if (customCell==nil) {
            customCell=[[TableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        customCell.selectionStyle = UITableViewCellSelectionStyleNone;
//        }
        if (indexPath.row==0)
        {
            Statustextfield=[[UITextField alloc]initWithFrame:CGRectMake(0,5, self.view.frame.size.width,30)];
            tableview.backgroundColor=[UIColor whiteColor];
            Statustextfield.layer.cornerRadius=0.5f;
            Statustextfield.delegate=self;
            Statustextfield.layer.borderColor=[[UIColor lightGrayColor] CGColor];
            Statustextfield.placeholder=@"Share an artical,Photo or idea";
            Statustextfield.textColor=[UIColor lightGrayColor];
            NSURL *ImageUrl =[NSURL URLWithString:[[NSUserDefaults standardUserDefaults]
                                                              stringForKey:@"profile_pic" ]] ;;
        
           
            UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0,0,40,40)];
            UIImageView * nameimage= [[UIImageView alloc] initWithFrame:CGRectMake(5,5,30,30)];
            nameimage.layer.cornerRadius=15;
            nameimage.clipsToBounds = YES;
            nameimage.image=profielimage;
        [nameimage sd_setImageWithURL:ImageUrl placeholderImage:[UIImage imageNamed:@"deafult_icon.png"]];
            [view addSubview:nameimage];
             UIView *camview=[[UIView alloc]initWithFrame:CGRectMake(Statustextfield.frame.size.width-40,0,40,40)];
            camerbut= [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
            [camerbut setBackgroundImage:[UIImage imageNamed:@"home_camera.png"] forState:UIControlStateNormal];
            [camerbut addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchDown];
             [camview addSubview:camerbut];
            [Statustextfield setLeftViewMode:UITextFieldViewModeAlways];
            [Statustextfield setLeftView:view];
            [Statustextfield setRightViewMode:UITextFieldViewModeAlways];
            [Statustextfield setRightView:camview];
            [customCell addSubview:Statustextfield];
            
        }
        return customCell;
    }
    else
    {
        if (postdetailsarray) {
              postdic=nil;
        customCell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
            customCell.selectionStyle = UITableViewCellSelectionStyleNone;
            postdic=[[NSMutableDictionary alloc]init];
        postdic=[postdetailsarray objectAtIndex:indexPath.section-1];
            customCell.profileName_label.text=nil;
        NSString *first_name=[postdic valueForKey:@"first_name"];
//           NSString *first_name1=[self stringWithSentenceCapitalization:first_name];
            if (first_name == (NSString *)[NSNull null])
                first_name=@"Your name";

            NSString *last_name=[postdic valueForKey:@"last_name"];
            NSString *last_name1=[NSString stringWithFormat:@" %@",last_name];
            if (last_name1 == (NSString *)[NSNull null])
                last_name1=@"last name";

            
        NSString *company=[postdic valueForKey:@"company_name"];
            
            if (company == (NSString *)[NSNull null])
                company=@"I";

        
        NSString *text = [NSString stringWithFormat:@"%@%@\n%@",first_name,last_name1,company];
        NSMutableAttributedString *attributedtext=[[NSMutableAttributedString alloc]initWithString:text];
        NSRange  range=[text rangeOfString:first_name];
        NSRange  range1=[text rangeOfString:last_name1];
        NSRange  range2=[text rangeOfString:company];
                [attributedtext setAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor],
                                        NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:12]} range:range];
            [attributedtext setAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor],
                                            NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:12]} range:range1];
            UIFont *boldFont = [UIFont fontWithName:@"Roboto-Regular" size:11];
            [attributedtext setAttributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor],
                                            NSFontAttributeName:boldFont} range:range2];

             customCell.profileName_label.attributedText=attributedtext;
[customCell.profile_imageView sd_setImageWithURL:[NSURL URLWithString:[postdic valueForKey:@"profile_pic"]] placeholderImage:[UIImage imageNamed:@"deafult_icon.png"]];
            if([[postdic allKeys]containsObject:@"post_image"])
            {
//                UIImage *imag=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[postdic valueForKey:@"post_image"]]]];
    [customCell.post_imageView sd_setImageWithURL:[NSURL URLWithString:[postdic valueForKey:@"post_image"]] ];
                customCell.post_imageView.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
               customCell.ImageHeightConstrait.constant=300;
                customCell.post_imageView.userInteractionEnabled = NO;
                
               
                //[customCell.contentView addSubview:view];
            }
           else if ([[postdic allKeys]containsObject:@"post_doc"])
            {
                customCell.post_imageView.image=[UIImage imageNamed:@"pdf_image.png"];
                UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openDocument:)];
                tapAction.delegate =self;
                customCell.post_imageView.tag=indexPath.section;
                tapAction.numberOfTapsRequired = 1;
                customCell.post_imageView.tag=indexPath.section;
                imagepath=indexPath.section;
                //Enable the lable UserIntraction
                 customCell.post_imageView.backgroundColor=[UIColor whiteColor];
                customCell.post_imageView.userInteractionEnabled = YES;
                [customCell.post_imageView addGestureRecognizer:tapAction];
                 customCell.ImageHeightConstrait.constant=128;
              //  [customCell.post_imageView setContentMode:UIViewContentModeScaleAspectFit];
                
            }
            else
            {
                customCell.post_imageView.image=nil;
                customCell.ImageHeightConstrait.constant=0;
                customCell.post_imageView.userInteractionEnabled = NO;
            }
         
            if ([postdic valueForKey:@"recently_liked"])
            {
                 customCell.linesuparator.hidden=NO;
                NSString * likeThisString = @"likes this";
                NSString *recentlylike=[postdic valueForKey:@"recently_liked"];
                NSString *RecentString = [NSString stringWithFormat:@"%@ %@",recentlylike, likeThisString];
                
                NSMutableAttributedString *attributedString=[[NSMutableAttributedString alloc]initWithString:RecentString];
                NSRange  Likerange=[RecentString rangeOfString:likeThisString];
               // NSRange  RecentStrrange=[RecentString rangeOfString:recentlylike];
                [attributedString setAttributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]} range:Likerange];
//                [attributedtext setAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor],
//                                                NSFontAttributeName:[UIFont fontWithName:@"Roboto-Bold" size:11]} range:RecentStrrange];
                customCell.recentLike_label.attributedText = attributedString;
                customCell.recentLike_label.font=[UIFont fontWithName:@"Roboto-Regular" size:12];
    
//                customCell.recentLike_label.layer.borderWidth=1.0;
//                customCell.recentLike_label.layer.borderColor=[UIColor lightGrayColor].CGColor;
                CALayer *border=[CALayer layer];
                border.borderWidth=1.0f;
                border.borderColor=[UIColor lightGrayColor].CGColor;
                border.frame=CGRectMake(0,customCell.profile_imageView.frame.origin.y-2,self.view.frame.size.width,1);
             // [customCell.layer addSublayer:border];
                
                
            }
            else
            {
                customCell.recentLike_label.attributedText=nil;
                customCell.linesuparator.hidden=YES;
                
            }
            customCell.comentCount_label.text=@"";
//            [customCell.like addTarget:self action:@selector(like:) forControlEvents:UIControlEventTouchUpInside];
//            UITapGestureRecognizer *likeAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(like:)];
//            likeAction.numberOfTapsRequired = 1;
//            likeAction.delegate =self;
//            customCell.likebuttonlable.userInteractionEnabled = YES;
//            [customCell.likebuttonlable addGestureRecognizer:likeAction];
            
            [customCell.sharebutton addTarget:self action:@selector(onShareButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            UITapGestureRecognizer *tapAction1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onShareButtonClicked:)];
            tapAction1.numberOfTapsRequired = 1;
            tapAction1.delegate =self;
             customCell.sharebuttonlable.userInteractionEnabled = YES;
            [customCell.sharebuttonlable addGestureRecognizer:tapAction1];
           
            customCell.LikeView.tag=indexPath.section-1;
            UITapGestureRecognizer *tapAction2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(like:)];
            tapAction2.numberOfTapsRequired = 1;
            tapAction2.delegate =self;
            customCell.LikeView.userInteractionEnabled = YES;
            [customCell.LikeView addGestureRecognizer:tapAction2];
            customCell.like.tag=indexPath.section-1;
            customCell.content_textview.font=[UIFont fontWithName:@"Roboto-Regular" size:12];
            customCell.content_textview.textColor=[UIColor blackColor];
             customCell.content_textview.text=[postdic valueForKey:@"post_text"];
        CGSize sizeThatFitsTextView = [customCell.content_textview sizeThatFits:CGSizeMake(customCell.content_textview.frame.size.width, MAXFLOAT)];
            customCell.constraintTextViewHeight.constant = sizeThatFitsTextView.height;
        customCell.content_label.systemURLStyle = YES;
        customCell.comentCount_label.text=[NSString stringWithFormat:@"%@ likes . %@ Comments",[postdic valueForKey:@"likes_count"],[postdic valueForKey:@"comments_count"]];
        customCell.content_label.font=[UIFont fontWithName:@"Roboto-Regular" size:12];
        customCell.content_label.textColor=[UIColor blackColor];
        customCell.layer.borderWidth=1.0f;
        customCell.layer.borderColor=[UIColor lightGrayColor].CGColor;
          
        }
//        customCell.layer.cornerRadius=5.0f;
      //  [labelText sizeToFit];
        return customCell;
    }
   
    
}


-(NSString*)stringWithSentenceCapitalization:(NSString*)str
{
  
    NSString *firstCapChar = [[str substringToIndex:1] capitalizedString];
    NSMutableString * temp = [str mutableCopy];
    [temp replaceCharactersInRange:NSMakeRange(0, 1) withString:firstCapChar];
    
    return temp ;
}
- (void)onShareButtonClicked:(id)sender{
    UIActivityViewController *activity = [[UIActivityViewController alloc] initWithActivityItems:[NSArray arrayWithObjects:@"https://itunes.apple.com/us/app/kcr-the-leader/id1113302037?mt=8",nil] applicationActivities:nil];
    [self presentViewController:activity animated:YES completion:nil];
}
- (UIViewController *) documentInteractionControllerViewControllerForPreview: (UIDocumentInteractionController *) controller {
    return [self navigationController];
}
- (void)openDocument:(UIImageView *)imageview {
   if (postdetailsarray)
   {
        [SVProgressHUD show];
       postdic =[postdetailsarray objectAtIndex:imagepath-1];
    NSURL *URL = [NSURL URLWithString:[postdic valueForKey:@"post_doc"]];
   NSString *extensionType = [URL lastPathComponent];
    NSData *urlData = [NSData dataWithContentsOfURL:URL];
    
    if (urlData) {
        // Initialize Document Interaction Controller
        NSArray       *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString  *documentsDirectory = [paths objectAtIndex:0];
        NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,extensionType];
        NSURL *url=[NSURL fileURLWithPath:filePath];
            [urlData writeToFile:filePath atomically:YES];
            NSLog(@"File Saved !");
      
        self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:url];
        [self.documentInteractionController setDelegate:self];
        [self.documentInteractionController presentPreviewAnimated:YES];
        [SVProgressHUD dismiss];

    }
   }
}

- (NSString *)capitalizeFirstLetterOnlyOfString:(NSString *)string{
    NSMutableString *result = [string lowercaseString].mutableCopy;
    [result replaceCharactersInRange:NSMakeRange(0, 1) withString:[[result substringToIndex:1] capitalizedString]];
    
    return result;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.section!=0))
    {
        if(postdetailsarray)
        {
            postdic=[postdetailsarray objectAtIndex:indexPath.section-1];
        NSString * storyboardIdentifier = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardIdentifier bundle: nil];
        Commentsviewcontroller *CommentsVc =[storyboard instantiateViewControllerWithIdentifier:@"commentVc"];
            CommentsVc.post_id=[postdic valueForKey:@"post_id"];
        [self.navigationController pushViewController:CommentsVc animated:YES];
        }
    }
    else
    {
        [self share];
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [Statustextfield resignFirstResponder];
    [self share];
}

-(void)share
{
    NSLog(@"button");
    shareViewController *sh=[[shareViewController alloc]init];
     sh.title=@"Share";
   // UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:sh];
    [self.navigationController pushViewController:sh animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [tableview reloadData];
}

/*LikePost_Method*/
-(void)like:(UITapGestureRecognizer*)sender
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
    else{
     UIView *view = sender.view;
    if (postdetailsarray)
    {
        
       postdic=[postdetailsarray objectAtIndex:view.tag];
        Sectionpath=view.tag;
        NSInteger i=[[postdic valueForKey:@"already_liked"] integerValue];
        if(i==0)
        {
            NSString * mystring =[NSString stringWithFormat:@"user_id=%@&post_id=%@&post_like=1",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],[postdic valueForKey:@"post_id"]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:[NSURL URLWithString:@"http://facilitymanagementcouncil.com/admin/service/postlike"]];
            [request setHTTPBody:[mystring dataUsingEncoding:NSUTF8StringEncoding]];
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            NSLog(@"%@",request);
            NSURLSessionDataTask *dataTask =[self.urlSession dataTaskWithRequest:request];
           // dic=nil;
            [dataTask resume];
            
        }
        else
        {
             [self.view makeToast:@"You Alredy like this post" duration:1.0 position:@"bottom"];
        }
    }
    }
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data1
{
    
    id json = [NSJSONSerialization JSONObjectWithData:data1 options:0 error:nil];
    if(likedic == nil)
    {
        likedic=json;
    }
    else
    {
        likedic=nil;
        likedic = json;
    }
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error
{
    
    error1=error;
    dispatch_async(dispatch_get_main_queue(), ^{[self likePost];});
    
}
-(void)likePost
{
    if (postdetailsarray)
    {
        NSLog(@"%ld",Sectionpath);
        
    postdic=[postdetailsarray objectAtIndex:Sectionpath];
    NSInteger i=[[postdic valueForKey:@"likes_count"] integerValue];
    NSMutableDictionary *update=[[NSMutableDictionary alloc]initWithDictionary:postdic];
    [update setValue:@"1" forKey:@"already_liked"];
     i++;
        NSString *likes_count=[NSString stringWithFormat:@"%ld",i];
            [update setValue:likes_count forKey:@"likes_count"];
      [postdetailsarray replaceObjectAtIndex:Sectionpath withObject:update];
//        [tableview beginUpdates];
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableview reloadSections:[[NSIndexSet alloc] initWithIndex:Sectionpath+1] withRowAnimation:UITableViewRowAnimationNone];
           
        });
     
       // [tableview reloadData];
       
//        [tableview endUpdates];
  
     [self.view makeToast:[likedic valueForKey:@"message"] duration:1.0 position:@"bottom"];
    }
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
