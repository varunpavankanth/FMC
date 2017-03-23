//
//  Forgotpassword.h
//  FMC
//
//  Created by Nennu on 09/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACFloatingTextField.h"
#import "Reachability.h"
#import "UIView+Toast.h"

@interface Forgotpassword : UIViewController<UITextFieldDelegate,NSURLSessionDelegate>
{
    ACFloatingTextField *userid;
    UIButton * getpassword;
    NSDictionary* dic;
    NSError *error1;
    UIScrollView * scrollView;
    float y,h;
}
@property (nonatomic, strong) NSURLSession *urlSession;
@end
