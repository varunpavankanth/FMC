//
//  Forgotpassword.m
//  FMC
//
//  Created by Nennu on 09/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import "Forgotpassword.h"
#import "SVProgressHUD.h"
@interface Forgotpassword ()
{
    UIView *view ;
    CGPoint scroloffset;
}

@end

@implementation Forgotpassword

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURLSessionConfiguration *sessionConfig=[NSURLSessionConfiguration ephemeralSessionConfiguration];
    self.urlSession= [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height )];
    [scrollView setScrollEnabled:NO];
    scrollView.contentOffset=scroloffset;
    [self.view addSubview:scrollView];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    self.title=@"Forgotpassword";
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = back;
    
    
    UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fmc_logo.png"]];
    img.frame=CGRectMake(self.view.frame.size.width/2-100, self.view.frame.size.height/13.33, 200, 165);
    [scrollView addSubview:img];
    
    view =[[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(img.frame)+20, self.view.frame.size.width-20,165)];
    
    UIImageView *logbac=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Homeback.png"]];
    logbac.frame=CGRectMake(0, 0, CGRectGetMaxX(view.frame)-10,165);
    [view addSubview:logbac];
    userid=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10,30, logbac.frame.size.width-20, 50)];
    [userid setTextFieldPlaceholderText:@"Username(Personal email Id)"];
    
    userid.selectedLineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    userid.placeHolderColor = [UIColor grayColor];
    userid.selectedPlaceHolderColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    userid.lineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    userid.delegate=self;
    UIImageView * nameimage= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_icon.png"]];
    [userid setLeftViewMode:UITextFieldViewModeAlways];
    [userid setLeftView:nameimage];
    [view addSubview:userid];
    
    
    getpassword =[[UIButton alloc]initWithFrame:CGRectMake(view.frame.size.width/2-90,CGRectGetMaxY(userid.frame)+20, 180, 40)];
    [getpassword addTarget:self action:@selector(servercall) forControlEvents:UIControlEventTouchDown];
    [getpassword setTitle:@"Get Password" forState:UIControlStateNormal];
    [getpassword setBackgroundColor:[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0]];
    getpassword.layer.cornerRadius=5.0;
    [view addSubview:getpassword];

    [scrollView addSubview:view];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardOnScreen:) name:UIKeyboardWillShowNotification object:nil];
    // Do any additional setup after loading the view.
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
    float ty=view.frame.origin.y+30;
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
    [userid resignFirstResponder];
    [scrollView setContentOffset:CGPointMake(0, -49) animated:NO];
    return YES;
}


-(void)servercall{
    [SVProgressHUD show];
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    UIAlertController *alertController;
    if (networkStatus == NotReachable)
    {
//[self.view makeToast:@"No internet connection" duration:1.0 position:@"center"];
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
            
            NSString * mystring =[NSString stringWithFormat:@"username=%@",userid.text];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:[NSURL URLWithString:@"http://facilitymanagementcouncil.com/admin/service/forgotpassword"]];
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
         [SVProgressHUD dismiss];
//         [self.view makeToast:[dic valueForKey:@"msg"]  duration:1.0 position:@"bottom"];
//        [NSTimer scheduledTimerWithTimeInterval:1.0f
//                                         target:self
//                                       selector:@selector(dissmiss)
//                                       userInfo:nil
//                                        repeats:YES];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"forgotPassword"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        UIAlertController *alertController;
        alertController = [UIAlertController  alertControllerWithTitle:@""  message:[dic valueForKey:@"msg"]  preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];

    }
    else
    {
         [SVProgressHUD dismiss];
        [self.view makeToast:@"Please check network" duration:1.0 position:@"center"];
    }
    
}
-(void)dissmiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
