//
//  ChangePassword.m
//  FMC
//
//  Created by Nennu on 10/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import "ChangePassword.h"
#import "Reachability.h"
#import "UIView+Toast.h"
#import "Home.h"
#import "Menu.h"
#import "SVProgressHUD.h"
@interface ChangePassword ()
{
    UIView *view;
    BOOL forgotpassword;
}

@end

@implementation ChangePassword
@synthesize scrollView;
- (void)viewDidLoad {
    [super viewDidLoad];
    forgotpassword =[[NSUserDefaults standardUserDefaults]boolForKey:@"forgotPassword"];
    scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.delegate = self;
    [scrollView setScrollEnabled:YES];
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.indicatorStyle=UIScrollViewIndicatorStyleWhite;
    scrollView.backgroundColor=[UIColor whiteColor];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    NSURLSessionConfiguration *sessionConfig=[NSURLSessionConfiguration ephemeralSessionConfiguration];
    self.urlSession= [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fmc_logo.png"]];
    img.frame=CGRectMake(self.view.frame.size.width/2-100, 50, 200, 165);
    [scrollView addSubview:img];
    
    view =[[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(img.frame)+5, self.view.frame.size.width-20,195)];
    
    
    
    UIImageView *logbac=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Homeback.png"]];
    logbac.frame=CGRectMake(10, CGRectGetMaxY(img.frame)+5, self.view.frame.size.width-20,195);
    [scrollView addSubview:logbac];
    userid=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10,10, logbac.frame.size.width-20, 50)];
    [userid setTextFieldPlaceholderText:@"Old Password"];
    userid.delegate=self;
    userid.secureTextEntry = YES;
    userid.selectedLineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    userid.placeHolderColor = [UIColor grayColor];
    userid.selectedPlaceHolderColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    userid.lineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    UIImageView * nameimage= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password_icon.png"]];
    [userid setLeftViewMode:UITextFieldViewModeAlways];
    [userid setRightViewMode:UITextFieldViewModeAlways];
    [userid setLeftView:nameimage];
    userid.tag=1;
    UIView *hide=[[UIView alloc]initWithFrame:CGRectMake(userid.frame.size.width-40,0,40,40)];
    UIButton* show= [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
    show.tag=1;
    [show setBackgroundImage:[UIImage imageNamed:@"showpassword.png"] forState:UIControlStateNormal];
    [show addTarget:self action:@selector(showpasswrd:) forControlEvents:UIControlEventTouchDown];
    [hide addSubview:show];
    [userid setRightView:hide];
    [view addSubview:userid];
    
    userid1=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(userid.frame)+5, CGRectGetWidth([UIScreen mainScreen].bounds)-40, 45)];
    [userid1 setTextFieldPlaceholderText:@"New Password"];
    userid1.secureTextEntry = YES;
    userid1.selectedLineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    userid1.placeHolderColor = [UIColor grayColor];
    userid1.selectedPlaceHolderColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    userid1.lineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    userid1.delegate=self;
    userid1.tag=2;
    UIImageView * nameimage1= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password_icon.png"]];
    [userid1 setLeftViewMode:UITextFieldViewModeAlways];
    [userid1 setRightViewMode:UITextFieldViewModeAlways];
    [userid1 setLeftView:nameimage1];
    UIView *hide1=[[UIView alloc]initWithFrame:CGRectMake(userid.frame.size.width-40,0,40,40)];
    UIButton* show1= [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
    show1.tag=2;
    [show1 setBackgroundImage:[UIImage imageNamed:@"showpassword.png"] forState:UIControlStateNormal];
    [show1 addTarget:self action:@selector(showpasswrd:) forControlEvents:UIControlEventTouchDown];
    [hide1 addSubview:show1];
    [userid1 setRightView:hide1];
    [scrollView addSubview:view];
    
    [view addSubview:userid1];
    

    
    
    getpassword =[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame)-100, CGRectGetMaxY(userid1.frame)+10, 180, 30)];
    [getpassword addTarget:self action:@selector(servercall) forControlEvents:UIControlEventTouchDown];
    [getpassword setTitle:@"Change Password" forState:UIControlStateNormal];
    [getpassword setBackgroundColor:[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0]];
    getpassword.layer.cornerRadius=5.0;
    
    [view addSubview:getpassword];
    
    [self.view addSubview:scrollView];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardOnScreen:) name:UIKeyboardWillShowNotification object:nil];
    // Do any additional setup after loading the view.
}
-(void)showpasswrd:(UIButton *)textField
{
    if(textField.tag==1)
    {
    userid.secureTextEntry =!userid.secureTextEntry;
    }
    else if(textField.tag==2)
    {
        userid1.secureTextEntry =!userid1.secureTextEntry;
    }
        
}
-(void)keyboardOnScreen:(NSNotification *)notification
{
    y=0;
    h=0;
    NSDictionary *info  = notification.userInfo;
    NSValue      *value = info[UIKeyboardFrameEndUserInfoKey];
    // CGRect frame        = textField.frame;
    CGRect rawFrame      = [value CGRectValue];
    CGRect keyboardFrame = [self.view convertRect:rawFrame fromView:nil];
    y=keyboardFrame.origin.y;
    h=keyboardFrame.size.height;
    
    
    NSLog(@"keyboardFrame: %@", NSStringFromCGRect(keyboardFrame));
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGPoint contentoffset;
    contentoffset=scrollView.contentOffset;
    float ty=view.frame.origin.y;
    float th=textField.frame.size.height;
    if(y==0)
        y=375;
    if (ty+50<=y)
    {
        [scrollView setContentOffset:CGPointMake(0,(ty-y)+2*th+20) animated:NO];
    }
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [scrollView setContentOffset:CGPointMake(0,-64) animated:NO];
    [userid resignFirstResponder];
    [userid1 resignFirstResponder];
    return YES;
}
-(void)servercall{
    getpassword.enabled=NO;
    [SVProgressHUD show];
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    UIAlertController *alertController;
    if (networkStatus == NotReachable)
    {
        [self.view makeToast:@"No internet connection" duration:1.0 position:@"center"];
    }
    else
    {
        NSLog(@"userID is:%@",userid.text);
        if ([userid.text isEqualToString:@""]) {
            alertController = [UIAlertController  alertControllerWithTitle:@"Error"  message:@"Please enter the User name"  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
                getpassword.enabled=YES;
                [SVProgressHUD dismiss];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else {
            
            NSString * mystring =[NSString stringWithFormat:@"user_id=%@&oldpassword=%@&password=%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"user_id"],userid.text,userid1.text];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:[NSURL URLWithString:@"http://facilitymanagementcouncil.com/admin/service/changepassword"]];
            [request setHTTPMethod:@"POST"];
            // [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:[mystring dataUsingEncoding:NSUTF8StringEncoding]];
            NSLog(@"%@",request);
            NSURLSessionDataTask *dataTask =[self.urlSession dataTaskWithRequest:request];
            dic=nil;
            [dataTask resume];
        }
    }
    
    
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
    
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data1
{
    
    id json = [NSJSONSerialization JSONObjectWithData:data1 options:0 error:nil];
    
    if(dic == nil)
    {
        dic=json;
        
    }
    else
    {
//        dic = [dic initWithDictionary:json];
        
    }
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error
{
    
    error1=error;
    getpassword.enabled=YES;
    [SVProgressHUD dismiss];
    dispatch_async(dispatch_get_main_queue(), ^{[self sucesstask];});
    
}
-(void)sucesstask
{
    if (!(dic==nil)) {
        
        NSString *message=[dic valueForKey:@"msg"];
        if([message isEqualToString:@"Invalid current password"])
        {
        UIAlertController *alertController;
        alertController = [UIAlertController  alertControllerWithTitle:@""  message:[dic valueForKey:@"msg"]  preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
           // [self.navigationController popViewControllerAnimated:YES];
           // [self navigatetohome];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
            UIAlertController *alertController;
            alertController = [UIAlertController  alertControllerWithTitle:@""  message:[dic valueForKey:@"msg"]  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
                if (forgotpassword==YES) {
                    [self navigatetohome];
                   
                }
                else
                {
                [self.navigationController popViewControllerAnimated:YES];
                }
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }

    }
    else
    {
        
        UIAlertController *alertController;
        alertController = [UIAlertController  alertControllerWithTitle:@""  message:@"!Opps something went  wrong"  preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
            // [self.navigationController popViewControllerAnimated:YES];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}
-(void)navigatetohome
{ NSString * storyboardIdentifier = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardIdentifier bundle: nil];
   Home *hm =[storyboard instantiateViewControllerWithIdentifier:@"Home"];
    Menu  *mn=[[Menu alloc]init];
    UINavigationController *home=[[UINavigationController alloc]initWithRootViewController:hm];
    UINavigationController *menu=[[UINavigationController alloc]initWithRootViewController:mn];
    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:menu frontViewController:home];
    [self presentViewController:revealController animated:YES completion:nil];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"forgotPassword"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)back
{
    [self  dismissViewControllerAnimated:YES completion:nil];
    
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
