//
//  Commentsviewcontroller.m
//  FMC
//
//  Created by Nennu on 22/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import "Commentsviewcontroller.h"
#import "CommentsCell.h"
#import "PostsCell.h"
#import "Reachability.h"
#import "UIView+Toast.h"
#import "APIDataFetcher.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
@interface Commentsviewcontroller ()<UITabBarDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
{
    NSMutableArray *responseArray;
    NSMutableArray *comments;
    NSMutableDictionary *postdic;
    UIView *_transperentview1;
    NSURL *imageUrl;
    UIView *hide;
    UIButton* Post;
}
@end

@implementation Commentsviewcontroller
@synthesize CommentTableview;
- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD setForegroundColor:[UIColor blueColor]];
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD show];

    NSURLSessionConfiguration *sessionConfig=[NSURLSessionConfiguration defaultSessionConfiguration];
    self.urlSession= [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    CommentTableview.estimatedRowHeight=1000;
    CommentTableview.rowHeight=UITableViewAutomaticDimension;
    CommentTableview.separatorColor=[UIColor clearColor];
    self.navigationController.navigationBar.hidden=NO;
    View =[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame)-50,CGRectGetMaxX(self.view.frame), 50)];
    View.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:View];
    textfield =[[UITextField alloc]initWithFrame:CGRectMake(5, 5,CGRectGetMaxX(View.frame)-10,30)];
    textfield.layer.borderWidth=1.0;
    textfield.placeholder=@"Comment";
    [textfield setRightViewMode:UITextFieldViewModeAlways];
    hide=[[UIView alloc]initWithFrame:CGRectMake(textfield.frame.size.width-40,0,40,40)];
    Post= [[UIButton alloc]initWithFrame:CGRectMake(5, 10, 20, 20)];
    UITapGestureRecognizer *tapAction1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentPost)];
    tapAction1.numberOfTapsRequired = 1;
    tapAction1.delegate =self;
    hide.userInteractionEnabled = YES;
   // [hide addGestureRecognizer:tapAction1];
    [Post setBackgroundImage:[UIImage imageNamed:@"comment.png"] forState:UIControlStateNormal];
    Post.tintColor=[UIColor blueColor];
    [Post addTarget:self action:@selector(commentPost) forControlEvents:UIControlEventTouchDown];
    [hide addSubview:Post];
    [textfield setRightView:hide];
    textfield.layer.cornerRadius=5.0;
    textfield.delegate=self;
    textfield.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [View addSubview:textfield];
    NSLog(@"%@",self.dic);
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardOnScreen:) name:UIKeyboardWillShowNotification object:nil];
    [self GetpostServercall];
    
    // Do any additional setup after loading the view.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    View.frame=CGRectMake(0, CGRectGetMaxY(self.view.frame)-50,CGRectGetMaxX(self.view.frame), 50);
    [View setFrame: View.frame];
    [textfield resignFirstResponder];
    return YES;
}
-(void)keyboardOnScreen:(NSNotification *)notification
{
    NSDictionary *info  = notification.userInfo;
    NSValue      *value = info[UIKeyboardFrameEndUserInfoKey];
    // CGRect frame        = textField.frame;
    CGRect rawFrame      = [value CGRectValue];
    CGRect keyboardFrame = [self.view convertRect:rawFrame fromView:nil];
    h=keyboardFrame.origin.y;
    CGRect bframe=View.frame;
    bframe.origin.y=h-50;
    [View setFrame:bframe];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if ([comments count] != 0)
    return comments.count+1;
    else
        return 1;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    //#warning Incomplete implementation, return the number of sections
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

{
    if (indexPath.row==0)
    {
    CommentsCell *customCell=(CommentsCell *)[CommentTableview dequeueReusableCellWithIdentifier:@"Commentcell"];
    if (customCell==nil) {
        customCell=[[CommentsCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Commentcell"];
    }
         customCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (responseArray) {
            self.dic=[responseArray objectAtIndex:0];
            NSString *str1=[self.dic objectForKey:@"first_name"];
            if (str1 == (NSString *)[NSNull null])
                str1=@"NULL";
            else
                [str1  localizedCapitalizedString];

            NSString *str3=[self.dic objectForKey:@"last_name"];
            
            if (str3 == (NSString *)[NSNull null])
                str3=@"NULL";
            else
                [str3  localizedCapitalizedString];
            
            NSString *str2=[self.dic objectForKey:@"company_name"];
            
            if (str2 == (NSString *)[NSNull null])
                str2=@"NULL";
            else
                [str2  localizedCapitalizedString];
       // NSString *str1=[self stringWithSentenceCapitalization:[self.dic objectForKey:@"first_name"]];
      //  NSString *str3=[self stringWithSentenceCapitalization:[self.dic objectForKey:@"last_name"]];
      //  NSString *str2=[self stringWithSentenceCapitalization:[self.dic objectForKey:@"company_name"]];
        NSString *text = [NSString stringWithFormat:@"%@ %@\n%@",str1,str3,str2];
        NSMutableAttributedString *attributedtext=[[NSMutableAttributedString alloc]initWithString:text];
        NSRange  range=[text rangeOfString:str2];
        UIFont *boldFont = [UIFont fontWithName:@"Roboto-Regular" size:12];
        [attributedtext setAttributes:@{NSForegroundColorAttributeName: [UIColor grayColor],
                                        NSFontAttributeName:boldFont} range:range];
        [customCell.profileImageview sd_setImageWithURL:[NSURL URLWithString:[self.dic objectForKey:@"profile_pic"]] placeholderImage:[UIImage imageNamed:@"deafult_icon.png"]];
        customCell.ProfileName.attributedText=attributedtext;
            if (comments.count==1)
    customCell.Comment_lable.text=[NSString stringWithFormat:@"%lu Comment",(unsigned long)comments.count];
        else
            customCell.Comment_lable.text=[NSString stringWithFormat:@"%lu Comments",(unsigned long)comments.count];
            
            [customCell.sharebutton addTarget:self action:@selector(onShareButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            UITapGestureRecognizer *tapAction1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onShareButtonClicked:)];
            tapAction1.numberOfTapsRequired = 1;
            tapAction1.delegate =self;
            customCell.ShareView.userInteractionEnabled = YES;
            [customCell.ShareView addGestureRecognizer:tapAction1];
             [customCell.profileImageview sd_setImageWithURL:[NSURL URLWithString:[self.dic objectForKey:@"profile_pic"]] placeholderImage:[UIImage imageNamed:@"deafult_icon.png"]];
            if([[postdic allKeys]containsObject:@"post_image"])
            {
                imageUrl=[NSURL URLWithString:[self.dic objectForKey:@"post_image"]];
                [customCell.postImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"deafult_icon.png"]];
                customCell.postImageView.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
                customCell.postHeightConstraint.constant=300;
                customCell.postImageView.userInteractionEnabled = NO;
                UITapGestureRecognizer *tapAction2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ImageZoom:)];
                tapAction2.numberOfTapsRequired = 1;
                tapAction2.delegate =self;
                customCell.postImageView.userInteractionEnabled = YES;
                [customCell.postImageView addGestureRecognizer:tapAction2];
                
            }
          else  if ([self.dic valueForKey:@"post_doc"])
            {
                customCell.postImageView.image=[UIImage imageNamed:@"pdf_image.png"];
                customCell.postHeightConstraint.constant=150;
                customCell.postImageView.userInteractionEnabled = NO;
            }
            else
            {
                 customCell.postHeightConstraint.constant=0;
            }
//        customCell.contentlabel.text=[self.dic objectForKey:@"post_text"];
             customCell.txtComment.font=[UIFont fontWithName:@"Roboto-Regular" size:12];
            customCell.txtComment.text=[postdic valueForKey:@"post_text"];
            CGSize sizeThatFitsTextView = [customCell.txtComment sizeThatFits:CGSizeMake(customCell.txtComment.frame.size.width, MAXFLOAT)];
            customCell.constraintTextViewHeight.constant = sizeThatFitsTextView.height;
            
           
                  }
        
    return customCell;
}
    else
    {
        PostsCell *customCell=(PostsCell *)[CommentTableview dequeueReusableCellWithIdentifier:@"Postcell"];
        if (customCell==nil) {
            customCell=[[PostsCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Postcell"];
        }
        if ([comments count]!= 0)
        {
             customCell.selectionStyle = UITableViewCellSelectionStyleNone;
        //comments=(NSMutableArray*)[(NSDictionary*)self.dic valueForKeyPath:@"comments"];
            self.dic=[comments objectAtIndex:indexPath.row-1];
        NSString *str1=[self.dic valueForKey:@"first_name"];
        NSString *str2=[self.dic valueForKey:@"company_name"];
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMMM dd,yyyy hh:mm a"];
            NSString *str3=[self.dic valueForKey:@"datetime"];
        NSString *text = [NSString stringWithFormat:@"%@  %@\n%@",str1 ,str2,str3];
        NSMutableAttributedString *attributedtext=[[NSMutableAttributedString alloc]initWithString:text];
        NSRange  range1=[text rangeOfString:str1];
        NSRange  range2=[text rangeOfString:str2];
        NSRange  range3=[text rangeOfString:str3];
        [attributedtext setAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0],
                                        NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]} range:range1];
        [attributedtext setAttributes:@{NSForegroundColorAttributeName: [UIColor orangeColor],
                                        NSFontAttributeName:[UIFont fontWithName:@"Roboto-Light" size:10]} range:range2];
        [attributedtext setAttributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor],
                                        NSFontAttributeName:[UIFont fontWithName:@"Roboto-Light" size:10]} range:range3];
        
        customCell.postNameLabel.attributedText=attributedtext;
//        customCell.PostmageView.layer.borderWidth=0.05f;
//        customCell.PostmageView.layer.cornerRadius=30.0f;
//        customCell.PostmageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",[self.dic objectForKey:@"Image"]]];
            
[customCell.PostmageView sd_setImageWithURL:[NSURL URLWithString:[self.dic objectForKey:@"profile_pic"]] placeholderImage:[UIImage imageNamed:@"deafult_icon.png"]];
            
        customCell.PostContentLabel.text=[self.dic valueForKey:@"comment"];
        customCell.PostContentLabel.font=[UIFont fontWithName:@"Roboto-Light" size:12];
        customCell.PostContentLabel.textColor=[UIColor darkGrayColor];
        [customCell.PostContentLabel sizeToFit];
        }
        return customCell;
    }

}
/*Server_Call*/
-(void)GetpostServercall

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
        
        
        NSString *URL =[NSString stringWithFormat:@"http://facilitymanagementcouncil.com/admin/service/postdetails/%@",self.post_id];
        
        [APIDataFetcher loadDataFromAPIUsingSession:URL :^(id result)
         {
             
             if ([result isKindOfClass:[NSDictionary class]])
             {
                 responseArray=(NSMutableArray*)[(NSDictionary*)result valueForKeyPath:@"posts_details"];
                 postdic=[responseArray objectAtIndex:0];
                 comments=(NSMutableArray*)[(NSDictionary*)postdic valueForKeyPath:@"comments"];
                 [self.CommentTableview reloadData];
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
- (void)hideTransparentVieww{
    [_transperentview1 removeFromSuperview];
    self.navigationController.navigationBar.hidden=NO;

}

-(void)ImageZoom:(UITapGestureRecognizer *)sender
{
    if(imageUrl!=nil)
    {
    NSLog(@"image zoomed");
    _transperentview1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        self.navigationController.navigationBar.hidden=YES;
    _transperentview1.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _transperentview1.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.9];
    [self.view addSubview:_transperentview1];
   ImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 50,CGRectGetWidth(self.view.frame) , 250)];
        [ImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"deafult_icon.png"]];
        [ImageView setContentMode:UIViewContentModeScaleAspectFit];
        UIButton *back=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 20, 20)];
       // back.backgroundColor=[UIColor redColor];
        [back addTarget:self action:@selector(hideTransparentVieww) forControlEvents:UIControlEventTouchUpInside];
        [back setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        [_transperentview1 addSubview:ImageView];

        
        scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,40, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)+20)];
        [scrollView addSubview:ImageView];
      //  scrollView.contentSize = ImageView.bounds.size;
        [scrollView setContentSize:CGSizeMake(320, CGRectGetHeight(self.view.frame))];
       // scrollView.backgroundColor=[UIColor blueColor];
        scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        scrollView.minimumZoomScale = 0.9f;
        scrollView.maximumZoomScale = 3.0f;
        scrollView.delegate = self;
        [_transperentview1 addSubview:back];

        [_transperentview1 addSubview:scrollView];
    }
}
- (UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView {
    NSLog(@"viewForZoomingInScrollView");
    return ImageView;
}
-(NSString*)stringWithSentenceCapitalization:(NSString*)str
{
    
    NSString *firstCapChar = [[str substringToIndex:1] capitalizedString];
    NSMutableString * temp = [str mutableCopy];
    [temp replaceCharactersInRange:NSMakeRange(0, 1) withString:firstCapChar];
    
    return temp ;
}
/*Post_comment*/
-(void)commentPost
{
    hide.userInteractionEnabled=NO;
    Post.enabled=NO;
    if(![textfield.text isEqualToString:@""])
    {
        
            NSString * mystring =[NSString stringWithFormat:@"user_id=%@&post_id=%@&comment=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],[postdic valueForKey:@"post_id"],textfield.text];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:[NSURL URLWithString:@"http://facilitymanagementcouncil.com/admin/service/postcomment"]];
            [request setHTTPBody:[mystring dataUsingEncoding:NSUTF8StringEncoding]];
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            NSLog(@"%@",request);
            NSURLSessionDataTask *dataTask =[self.urlSession dataTaskWithRequest:request];
            commentdic=nil;
    [dataTask resume];
    }
    else
    {
          [self.view makeToast:@"empty comment can't be send" duration:1.0 position:@"bottom"];
        hide.userInteractionEnabled=YES;
        Post.enabled=YES;
    }
  
    }
- (void)onShareButtonClicked:(id)sender{
    UIActivityViewController *activity = [[UIActivityViewController alloc] initWithActivityItems:[NSArray arrayWithObjects:@"https://itunes.apple.com/us/app/kcr-the-leader/id1113302037?mt=8",nil] applicationActivities:nil];
    [self presentViewController:activity animated:YES completion:nil];
}

    - (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveData:(NSData *)data1
    {
        
        id json = [NSJSONSerialization JSONObjectWithData:data1 options:0 error:nil];
        
        if(commentdic == nil)
        {
            commentdic=json;
            hide.userInteractionEnabled=YES;
            Post.enabled=YES;
        }
        else
        {
            NSLog(@"print");
        }
    }

    - (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error
    {
        
        error1=error;
        dispatch_async(dispatch_get_main_queue(), ^{[self commentedpost];});
        
    }
    -(void)commentedpost
    {
        [self GetpostServercall];
        textfield.text=nil;
        [textfield resignFirstResponder];
        View.frame=CGRectMake(0, CGRectGetMaxY(self.view.frame)-50,CGRectGetMaxX(self.view.frame), 50);
        [View setFrame: View.frame];
//        [self.view makeToast:[commentdic valueForKey:@"message"] duration:1.0 position:@"bottom"];
//        [self.navigationController popViewControllerAnimated:YES];
    }

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
    
}

@end
