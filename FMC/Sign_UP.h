//
//  Sign UP.h
//  FMC
//
//  Created by Nennu on 08/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import <PhotosUI/PhotosUI.h>
#import "ACFloatingTextField.h"
#import "TOCropViewController.h"
//#import "FXBlurView.h"
//#import "ImageCropView.h"

@interface Sign_UP : UIViewController<UINavigationControllerDelegate,UIScrollViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,NSURLSessionDelegate,TOCropViewControllerDelegate>
//ImageCropViewControllerDelegate>
{
    ACFloatingTextField *firastname,*lastname,*companynm,*bussinessE_id,*personalE_id,*contactno,*alterno,*currenloc,*password,*confpassword,*profilepic;
    UILabel * intrestedlocation;
    UILabel * Hyderabad;
    UILabel * Chennai;
    UILabel * Bangalore;
    UILabel * Pune;
    NSString *imagefilepath;
    NSURL *imageurl;
    NSData *imagedata;
    NSString *extension;
    NSString *base64string;
    NSDictionary *dic;
    NSError *error1;
    UIButton* chkBtn,*chkBtn1,*chkBtn2,*chkBtn3,*signupbtn;
    float y,h;
    BOOL camerabool;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSURLSession *urlSession;
@end
