//
//  ViewController.h
//  FMC
//
//  Created by Nennu on 07/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACFloatingTextField.h"
#import "Sign_UP.h"
#import "Severconnection.h"
#import "Forgotpassword.h"
#import "Home.h"
#import "SWRevealViewController.h"
#import "Home.h"
#import "Reachability.h"
#import "UIView+Toast.h"
@class Menu;
@interface ViewController : UIViewController<UITextFieldDelegate,UIGestureRecognizerDelegate,NSURLSessionDelegate,UINavigationControllerDelegate>
{
    IBOutlet UIImageView *FMC;
    UIButton *login;
    UITextField *field;
    UIImageView * img;
    UIView *loginbg;
    UILabel *sighnuplable;
    Sign_UP *signup;
    Severconnection *con;
    UILabel * forgetprass;
    Forgotpassword *fp;
    Home *hm;
    Menu *mn;
    UIScrollView * scrollView;
    NSDictionary *dic;
    NSError *error1;
}
@property (nonatomic, strong) NSURLSession *urlSession;
@property (nonatomic, strong) ACFloatingTextField *userid,*password;
@end

