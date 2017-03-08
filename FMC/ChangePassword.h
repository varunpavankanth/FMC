//
//  ChangePassword.h
//  FMC
//
//  Created by Nennu on 10/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "ACFloatingTextField.h"

@interface ChangePassword : UIViewController<UITextFieldDelegate,NSURLSessionDelegate,UIScrollViewDelegate>
{
    ACFloatingTextField *userid,*userid1;
    UIButton * getpassword;
    NSMutableDictionary *dic;
    NSError *error1;
    float y,h;
}
@property (nonatomic, strong) NSURLSession *urlSession;
@property (nonatomic, strong) UIScrollView *scrollView;
@end



