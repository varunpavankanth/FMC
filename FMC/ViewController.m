//
//  ViewController.m
//  FMC
//
//  Created by Nennu on 07/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import "ViewController.h"
#import "Menu.h"
#import <SVProgressHUD.h>
#import "ChangePassword.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize userid,password;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate=self;
    NSURLSessionConfiguration *sessionConfig=[NSURLSessionConfiguration ephemeralSessionConfiguration];
    self.urlSession= [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    float x,y,w,h;
    x=5;
    y=self.view.frame.size.height/2;
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height )];
    [scrollView setScrollEnabled:NO];
    [self.view addSubview:scrollView];
    img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fmc_logo.png"]];
    img.frame=CGRectMake(self.view.frame.size.width/2-100,75, 200, 165);
    [scrollView addSubview:img];
    y=CGRectGetMaxY(img.frame);
    w=self.view.frame.size.width-x;
    h=self.view.frame.size.height/2.7;
    self.navigationController.delegate=self;
    loginbg =[[UIView alloc]initWithFrame:CGRectMake( 5, CGRectGetMaxY(img.frame)+20, w-10,230)];
    UIImageView *bgimage=[[UIImageView alloc]init];
    bgimage.frame=CGRectMake(0, 0, loginbg.frame.size.width, loginbg.frame.size.height);
    bgimage.image=[UIImage imageNamed:@"login_background.png"];
    [loginbg addSubview:bgimage];
    [scrollView addSubview:loginbg];
    
    userid=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(20, 10, CGRectGetWidth([UIScreen mainScreen].bounds)-40, 45)];
    [userid setTextFieldPlaceholderText:@"Username(Personal email Id)"];
    userid.selectedLineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    userid.placeHolderColor = [UIColor grayColor];
    userid.selectedPlaceHolderColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
//    userid.keyboardType=UIKeyboardTypeURL;
//    userid.spellCheckingType=UITextSpellCheckingTypeNo;
     userid.secureTextEntry = YES;
    userid.secureTextEntry=NO;
    userid.lineColor =  [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    userid.delegate=self;
    UIImageView * nameimage= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_icon.png"]];
    [userid setLeftViewMode:UITextFieldViewModeAlways];
    [userid setLeftView:nameimage];
    [loginbg addSubview:userid];
    
    password=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(userid.frame)+15, CGRectGetWidth([UIScreen mainScreen].bounds)-40, 45)];
    [password setTextFieldPlaceholderText:@"Password"];
    password.selectedLineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    password.placeHolderColor = [UIColor grayColor];
    password.selectedPlaceHolderColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    password.secureTextEntry = YES;
    password.delegate=self;
    password.lineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    UIImageView * pass= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password_icon.png"]];
    [password setLeftViewMode:UITextFieldViewModeAlways];
    [password setLeftView:pass];
    [password setRightViewMode:UITextFieldViewModeAlways];
    UIView *hide=[[UIView alloc]initWithFrame:CGRectMake(password.frame.size.width-40,0,40,40)];
    UIButton* show= [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
    [show setBackgroundImage:[UIImage imageNamed:@"showpassword.png"] forState:UIControlStateNormal];
    [show addTarget:self action:@selector(showpasswrd) forControlEvents:UIControlEventTouchDown];
    [hide addSubview:show];
    [password setRightView:hide];
    [loginbg addSubview:password];
    
    forgetprass =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(loginbg.frame)-160, CGRectGetMaxY(password.frame)+5, 150,40)];
    //forgetprass.backgroundColor=[UIColor redColor];
    forgetprass.text=@"Forgot Password?";
    forgetprass.textAlignment=NSTextAlignmentRight;
    forgetprass.textColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    UITapGestureRecognizer *tapAction1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forgotpassword)];
    tapAction1.delegate =self;
    tapAction1.numberOfTapsRequired = 1;
    
    //Enable the lable UserIntraction
    forgetprass.userInteractionEnabled = YES;
    [forgetprass addGestureRecognizer:tapAction1];
    [loginbg addSubview:forgetprass];
    
    login =[[UIButton alloc]initWithFrame:CGRectMake(loginbg.frame.size.width/2-50, CGRectGetMaxY(forgetprass.frame)+5, 100, 30)];
    [login addTarget:self action:@selector(servercall) forControlEvents:UIControlEventTouchDown];
    [login setTitle:@"Login" forState:UIControlStateNormal];
    [login setBackgroundColor:[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0]];
    login.layer.cornerRadius=5.0;
    [loginbg addSubview:login];
    
    sighnuplable =[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(loginbg.frame), self.view.frame.size.width,50)];
    sighnuplable.textColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    NSString *new =@"New user?";
    NSString *sigh=@"Sign up";
    NSString *text=[NSString stringWithFormat:@"%@ %@",new,sigh];
    NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    
    sighnuplable.attributedText=[[NSAttributedString alloc] initWithString:text
                                                                attributes:underlineAttribute];
    sighnuplable.textAlignment=NSTextAlignmentCenter;
    UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sighup)];
    tapAction.delegate =self;
    tapAction.numberOfTapsRequired = 1;
    
    //Enable the lable UserIntraction
    sighnuplable.userInteractionEnabled = YES;
    [sighnuplable addGestureRecognizer:tapAction];
    
    [self.view addSubview:sighnuplable];

}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [scrollView setContentOffset:CGPointMake(0,30) animated:NO];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [scrollView setContentOffset:CGPointMake(0,0) animated:NO];
    [self.userid resignFirstResponder];
    [self.password resignFirstResponder];
    return YES;
}

-(void)forgotpassword
{
    fp=[[Forgotpassword alloc]init];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:fp];
    [self presentViewController:nav animated:YES completion:nil];
}
-(void)showpasswrd
{
    password.secureTextEntry =!password.secureTextEntry;
}
-(void)servercall
{
    login.enabled=NO;
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    UIAlertController *alertController;
    if (networkStatus == NotReachable)
    {
       // [self.view makeToast:@"No internet connection" duration:1.0 position:@"center"];
       // [SVProgressHUD dismiss];
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
        login.enabled=YES;
    }
else
{
    NSLog(@"userID is:%@",userid.text);
    NSLog(@"Password is :%@",password.text);
    if ([userid.text isEqualToString:@""]) {
        alertController = [UIAlertController  alertControllerWithTitle:@"Error"  message:@"Please enter the User name"  preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
            login.enabled=YES;
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    
    }
  else  if ([password.text isEqualToString:@""]) {
        alertController = [UIAlertController  alertControllerWithTitle:@"Error"  message:@"Please enter the password"  preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
            login.enabled=YES;
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
  else {
     [SVProgressHUD show];
    NSString * mystring =[NSString stringWithFormat:@"username=%@&password=%@",userid.text,password.text];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://facilitymanagementcouncil.com/admin/service/login"]];
    [request setHTTPMethod:@"POST"];
    //[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[mystring dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"%@",request);
    NSURLSessionDataTask *dataTask =[self.urlSession dataTaskWithRequest:request];
    dic=nil;
    [dataTask resume];
    }
}
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
        dic = [dic initWithDictionary:json];
    }
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error
{
    
    error1=error;
    dispatch_async(dispatch_get_main_queue(), ^{[self sucesstask];});
    
}
-(void)sucesstask
{
        if (!(dic==nil)) {
            login.enabled=YES;
            NSString * storyboardIdentifier = @"Main";
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardIdentifier bundle: nil];
    
        if ([[dic valueForKey:@"status"]isEqualToString:@"error"]) {
            [SVProgressHUD dismiss];
            UIAlertController *alertController;
            alertController = [UIAlertController  alertControllerWithTitle:@"Error"  message:[dic valueForKey:@"msg"]  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    
    else
    {
         [SVProgressHUD dismiss];
        [[NSUserDefaults standardUserDefaults] setObject:[dic valueForKey:@"alternate_contact_number"] forKey:@"alternate_contact_number"];
        [[NSUserDefaults standardUserDefaults] setObject:[dic valueForKey:@"business_email_id"] forKey:@"business_email_id"];
        [[NSUserDefaults standardUserDefaults] setObject:[dic valueForKey:@"company_name"] forKey:@"company_name"];
         [[NSUserDefaults standardUserDefaults] setObject:[dic valueForKey:@"current_location"] forKey:@"current_location"];
        [[NSUserDefaults standardUserDefaults] setObject:[dic valueForKey:@"first_name"] forKey:@"first_name"];
        [[NSUserDefaults standardUserDefaults] setObject:[dic valueForKey:@"interested_location"] forKey:@"interested_location"];
        [[NSUserDefaults standardUserDefaults] setObject:[dic valueForKey:@"key"] forKey:@"key"];
        [[NSUserDefaults standardUserDefaults] setObject:[dic valueForKey:@"last_name"] forKey:@"last_name"];
         [[NSUserDefaults standardUserDefaults] setObject:[dic valueForKey:@"personal_email_id"] forKey:@"personal_email_id"];
        [[NSUserDefaults standardUserDefaults] setObject:[dic valueForKey:@"profile_pic"] forKey:@"profile_pic"];
        [[NSUserDefaults standardUserDefaults] setObject:[dic valueForKey:@"contact_number"] forKey:@"contact_number"];
        [[NSUserDefaults standardUserDefaults] setObject:[dic valueForKey:@"current_location"] forKey:@"current_location"];
        [[NSUserDefaults standardUserDefaults] setObject:[dic valueForKey:@"user_id"] forKey:@"user_id"];
        [[NSUserDefaults standardUserDefaults] setObject:[dic valueForKey:@"status"] forKey:@"status"];
        [[NSUserDefaults standardUserDefaults] setObject:[dic valueForKey:@"user_name"] forKey:@"user_name"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                                stringForKey:@"status"];
        NSLog(@"%@",savedValue);
        BOOL fg=[[NSUserDefaults standardUserDefaults]boolForKey:@"forgotPassword"];
        if(fg==YES)
        {
            ChangePassword *cv=[[ChangePassword alloc]init];
            [self presentViewController:cv animated:YES completion:nil];
           //[self.navigationController pushViewController:cv animated:YES];
        }
        else
        {
        hm =[storyboard instantiateViewControllerWithIdentifier:@"Home"];
        mn=[[Menu alloc]init];
        UINavigationController *home=[[UINavigationController alloc]initWithRootViewController:hm];
        UINavigationController *menu=[[UINavigationController alloc]initWithRootViewController:mn];
       SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:menu frontViewController:home];
        [self presentViewController:revealController animated:YES completion:nil];
        }
    }
        }
    else
    {
         login.enabled=YES;
         [SVProgressHUD dismiss];
        [self.view makeToast:@"Please check network" duration:1.0 position:@"center"];

//        UIAlertController *alertController;
//        alertController = [UIAlertController  alertControllerWithTitle:@"Error"  message:@"!Opps something went  wrong"  preferredStyle:UIAlertControllerStyleAlert];
//        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//            [alertController dismissViewControllerAnimated:YES completion:nil];
//        }]];
//        [self presentViewController:alertController animated:YES completion:nil];
    }
    

}
- (void)alertView:(UIAlertViewStyle *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}
-(void)sighup
{
    signup=[[Sign_UP alloc]init];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:signup];
//    [self.navigationController pushViewController:nav animated:YES];
    
   [self presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
