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

@interface ChangePassword ()

@end

@implementation ChangePassword

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    NSURLSessionConfiguration *sessionConfig=[NSURLSessionConfiguration ephemeralSessionConfiguration];
    self.urlSession= [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fmc_logo.png"]];
    img.frame=CGRectMake(self.view.frame.size.width/2-100, self.view.frame.size.height/4, 200, 165);
    [self.view addSubview:img];
    
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(img.frame)+5, self.view.frame.size.width-20,195)];
    
    UIImageView *logbac=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Homeback.png"]];
    logbac.frame=CGRectMake(10, CGRectGetMaxY(img.frame)+5, self.view.frame.size.width-20,195);
    [self.view addSubview:logbac];
    userid=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10,10, logbac.frame.size.width-20, 50)];
    [userid setTextFieldPlaceholderText:@"Old Password"];
    userid.delegate=self;
    userid.selectedLineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    userid.placeHolderColor = [UIColor grayColor];
    userid.selectedPlaceHolderColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    userid.lineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    UIImageView * nameimage= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_icon.png"]];
    [userid setLeftViewMode:UITextFieldViewModeAlways];
    [userid setLeftView:nameimage];
    [self.view addSubview:view];
    
    [view addSubview:userid];
    
    userid1=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(userid.frame)+5, CGRectGetWidth([UIScreen mainScreen].bounds)-40, 45)];
    [userid1 setTextFieldPlaceholderText:@"New Password"];
    userid1.selectedLineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    userid1.placeHolderColor = [UIColor grayColor];
    userid1.selectedPlaceHolderColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    userid1.lineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    userid1.delegate=self;
    UIImageView * nameimage1= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_icon.png"]];
    [userid1 setLeftViewMode:UITextFieldViewModeAlways];
    [userid1 setLeftView:nameimage1];
    [self.view addSubview:view];
    
    [view addSubview:userid1];
    

    
    
    getpassword =[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-90, CGRectGetMaxY(userid.frame)+410, 180, 30)];
    [getpassword addTarget:self action:@selector(servercall) forControlEvents:UIControlEventTouchDown];
    [getpassword setTitle:@"Change Password" forState:UIControlStateNormal];
    [getpassword setBackgroundColor:[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0]];
    getpassword.layer.cornerRadius=5.0;
    
    [self.view addSubview:getpassword];
    
    
    // Do any additional setup after loading the view.
}
-(void)servercall{
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
        [self.view makeToast:[dic valueForKey:@"msg"]  duration:2.0 position:@"bottom"];
//        [NSTimer scheduledTimerWithTimeInterval:1.0f
//                                         target:self
//                                       selector:@selector(dissmiss)
//                                       userInfo:nil
//                                        repeats:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)back
{
    [self  dismissViewControllerAnimated:YES completion:nil];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [userid resignFirstResponder];
    [userid1 resignFirstResponder];
    
    
    return YES;
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
