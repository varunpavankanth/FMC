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

@interface ChangePassword : UIViewController<UITextFieldDelegate,NSURLSessionDelegate>
{
    ACFloatingTextField *userid,*userid1;
    UIButton * getpassword;
    NSMutableDictionary *dic;
    NSError *error1;
}
@property (nonatomic, strong) NSURLSession *urlSession;
@end



