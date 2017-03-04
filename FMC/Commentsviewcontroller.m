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
@interface Commentsviewcontroller ()<UITabBarDelegate,UITableViewDataSource>
{
    NSMutableArray *responseArray;
    NSMutableArray *comments;
    NSMutableDictionary *postdic;
}
@end

@implementation Commentsviewcontroller
@synthesize CommentTableview;
- (void)viewDidLoad {
    [super viewDidLoad];
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
    UIView *hide=[[UIView alloc]initWithFrame:CGRectMake(textfield.frame.size.width-40,0,40,40)];
    UIButton* Post= [[UIButton alloc]initWithFrame:CGRectMake(5, 10, 20, 20)];
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
        if (responseArray) {
            self.dic=[responseArray objectAtIndex:0];
            
        NSString *str1=[self stringWithSentenceCapitalization:[self.dic objectForKey:@"first_name"]];
        NSString *str3=[self stringWithSentenceCapitalization:[self.dic objectForKey:@"last_name"]];
        NSString *str2=[self stringWithSentenceCapitalization:[self.dic objectForKey:@"company_name"]];
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
             [customCell.postImageView sd_setImageWithURL:[NSURL URLWithString:[self.dic objectForKey:@"profile_pic"]]];
            if ([self.dic valueForKey:@"post_doc"])
            {
                customCell.postImageView.image=[UIImage imageNamed:@"pdf_image.png"];
            }
            else
            {
                             [customCell.postImageView sd_setImageWithURL:[NSURL URLWithString:[self.dic objectForKey:@"post_image"]]];
            }
        customCell.contentlabel.text=[self.dic objectForKey:@"post_text"];
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
        [self.view makeToast:@"No internet connection" duration:1.0 position:@"center"];
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
                 //
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
        }
        else
        {
            commentdic = [commentdic initWithDictionary:json];
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
        [self.view makeToast:[commentdic valueForKey:@"message"] duration:1.0 position:@"bottom"];
        [self.navigationController popViewControllerAnimated:YES];
    }



@end
