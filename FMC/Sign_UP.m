//
//  Sign UP.m
//  FMC
//
//  Created by Nennu on 08/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import "Sign_UP.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "Reachability.h"
#import "UIView+Toast.h"
#import "SVProgressHUD.h"
@interface Sign_UP ()
{
    UIImagePickerController *imagePicker;
}
@end

@implementation Sign_UP
@synthesize scrollView;
- (void)viewDidLoad {
    [super viewDidLoad];
   

    [SVProgressHUD setForegroundColor:[UIColor blueColor]];
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
     self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    self.title=@"Sign Up";
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
//   UIButton *back=[[UIButton alloc]initWithFrame:CGRectMake(15, 10,25,25)];
//    //[back setTitle:@"<-Back" forState:UIControlStateNormal];
// [back setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
//   
//    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];
//    //[self.view addSubview:navbar];
//    [self.navigationController.navigationBar addSubview:back];
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = back;
    NSURLSessionConfiguration *sessionConfig=[NSURLSessionConfiguration ephemeralSessionConfiguration];
   self.urlSession= [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 51, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.delegate = self;
    [scrollView setScrollEnabled:YES];
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.indicatorStyle=UIScrollViewIndicatorStyleWhite;
    scrollView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:scrollView];
    
    
    firastname =[[ACFloatingTextField alloc]init];
    [firastname setTextFieldPlaceholderText:@"First Name"];
    firastname.delegate=self;
    firastname.tag=1;
    firastname.selectedLineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    firastname.placeHolderColor = [UIColor grayColor];
    firastname.selectedPlaceHolderColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    firastname.lineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    UIImageView * img1= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_icon.png"]];
    [firastname setLeftViewMode:UITextFieldViewModeAlways];
    [firastname setLeftView:img1];
    [scrollView addSubview:firastname];
    
    lastname =[[ACFloatingTextField alloc]init];
    [lastname setTextFieldPlaceholderText:@"Last Name"];
    lastname.delegate=self;
    lastname.tag=2;
    lastname.selectedLineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    lastname.placeHolderColor = [UIColor grayColor];
    lastname.selectedPlaceHolderColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    lastname.lineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    [lastname setLeftViewMode:UITextFieldViewModeAlways];
    UIImageView * img2= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_icon.png"]];
    [lastname setLeftView:img2];
    [scrollView addSubview:lastname];

    companynm =[[ACFloatingTextField alloc]init];
    [companynm setTextFieldPlaceholderText:@"Company Name"];
    companynm.delegate=self;
    companynm.tag=3;
    companynm.selectedLineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    companynm.placeHolderColor = [UIColor grayColor];
    companynm.selectedPlaceHolderColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    companynm.lineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    [companynm setLeftViewMode:UITextFieldViewModeAlways];
    UIImageView * img3= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"company_name.png"]];
    [companynm setLeftView:img3];
    [scrollView addSubview:companynm];
    
    bussinessE_id=[[ACFloatingTextField alloc]init];
    [bussinessE_id setTextFieldPlaceholderText:@"Business e-Mail Id"];
    bussinessE_id.selectedLineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    bussinessE_id.placeHolderColor = [UIColor grayColor];
    bussinessE_id.delegate=self;
    bussinessE_id.keyboardType=UIKeyboardTypeEmailAddress;
    bussinessE_id.tag=4;
    bussinessE_id.selectedPlaceHolderColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    bussinessE_id.lineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    [bussinessE_id setLeftViewMode:UITextFieldViewModeAlways];
    UIImageView * img4= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mail_icon.png"]];
    [bussinessE_id setLeftView:img4];
    [scrollView addSubview:bussinessE_id];
    
    personalE_id=[[ACFloatingTextField alloc]init];
    [personalE_id setTextFieldPlaceholderText:@"Personal e-Mail Id(User name)"];
    personalE_id.selectedLineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    personalE_id.placeHolderColor = [UIColor grayColor];
    personalE_id.delegate=self;
    personalE_id.keyboardType=UIKeyboardTypeEmailAddress;
    personalE_id.tag=5;
    personalE_id.selectedPlaceHolderColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    personalE_id.lineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    [personalE_id setLeftViewMode:UITextFieldViewModeAlways];
    UIImageView * img5= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mail_icon.png"]];
    [personalE_id setLeftView:img5];
    [scrollView addSubview:personalE_id];
    
    contactno=[[ACFloatingTextField alloc]init];
    [contactno setTextFieldPlaceholderText:@"Contact Number"];
    contactno.delegate=self;
    contactno.tag=6;
    contactno.selectedLineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    contactno.placeHolderColor = [UIColor grayColor];
    contactno.selectedPlaceHolderColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    contactno.lineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    [contactno setLeftViewMode:UITextFieldViewModeAlways];
    UIImageView * img6= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mobile_icon.png"]];
    [contactno setLeftView:img6];
    [scrollView addSubview:contactno];
    
    alterno=[[ACFloatingTextField alloc]init];
    [alterno setTextFieldPlaceholderText:@"Alternate Contact Number"];
    alterno.delegate=self;
    alterno.tag=7;
    alterno.selectedLineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    alterno.placeHolderColor = [UIColor grayColor];
    alterno.selectedPlaceHolderColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    alterno.lineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    [alterno setLeftViewMode:UITextFieldViewModeAlways];
    UIImageView * img7= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mobile_icon.png"]];
    [alterno setLeftView:img7];
    [scrollView addSubview:alterno];
    
    currenloc=[[ACFloatingTextField alloc]init];
    [currenloc setTextFieldPlaceholderText:@"Current Location"];
    currenloc.delegate=self;
    currenloc.tag=8;
    currenloc.selectedLineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    currenloc.placeHolderColor = [UIColor grayColor];
    currenloc.selectedPlaceHolderColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    currenloc.lineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    [currenloc setLeftViewMode:UITextFieldViewModeAlways];
    UIImageView * img8= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"location_icon.png"]];
    [currenloc setLeftView:img8];
    [scrollView addSubview:currenloc];
    
    password=[[ACFloatingTextField alloc]init];
    [password setTextFieldPlaceholderText:@"Password"];
    password.delegate=self;
    password.tag=9;
    password.selectedLineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    password.placeHolderColor = [UIColor grayColor];
    password.selectedPlaceHolderColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    password.secureTextEntry = YES;
    password.lineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    UIImageView * img9= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password_icon.png"]];
    [password setLeftViewMode:UITextFieldViewModeAlways];
    [password setLeftView:img9];
    [scrollView addSubview:password];
    
    confpassword=[[ACFloatingTextField alloc]init];
    [confpassword setTextFieldPlaceholderText:@"Confirm Password"];
    confpassword.selectedLineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    confpassword.delegate=self;
    confpassword.tag=10;
    confpassword.placeHolderColor = [UIColor grayColor];
    confpassword.selectedPlaceHolderColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    confpassword.secureTextEntry = YES;
    confpassword.lineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    [confpassword setLeftViewMode:UITextFieldViewModeAlways];
    UIImageView * img10= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password_icon.png"]];
    [confpassword setLeftView:img10];
    [scrollView addSubview:confpassword];
    
    profilepic=[[ACFloatingTextField alloc]init];
    [profilepic setTextFieldPlaceholderText:@"Profile Picture"];
    profilepic.delegate=self;
    profilepic.selectedLineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    profilepic.placeHolderColor = [UIColor grayColor];
    profilepic.delegate=self;
    profilepic.tag=11;
    profilepic.selectedPlaceHolderColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    profilepic.lineColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    [profilepic setLeftViewMode:UITextFieldViewModeAlways];
    UIImageView * img11= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"camera.png"]];
    [profilepic setLeftView:img11];
    [profilepic setRightViewMode:UITextFieldViewModeAlways];
    UIImageView * img12= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"upload.png"]];
    [profilepic setRightView:img12];

    [scrollView addSubview:profilepic];
    
    

    
    intrestedlocation=[[UILabel alloc]init];
    intrestedlocation.text=@"please select interested Location";
    intrestedlocation.textColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    [scrollView addSubview:intrestedlocation];
    
    Hyderabad=[[UILabel alloc]init];
    Hyderabad.text=@"Hyderabad";
        Hyderabad.textColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    
    [scrollView addSubview:Hyderabad];
    
    Bangalore=[[UILabel alloc]init];
    Bangalore.text=@"Bangalore";
    Bangalore.textColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
        [scrollView addSubview:Bangalore];
    
    
    Chennai=[[UILabel alloc]init];
    Chennai.text=@"Chennai";
    Chennai.textColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    
    [scrollView addSubview:Chennai];
    
    Pune=[[UILabel alloc]init];
    Pune.text=@"Pune";
    Pune.textColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    
    [scrollView addSubview:Pune];
    
    if(self.view.frame.size.width==320)
    {
        Hyderabad.font=[UIFont systemFontOfSize:12];
        Pune.font=[UIFont systemFontOfSize:12];
        Chennai.font=[UIFont systemFontOfSize:12];
        Bangalore.font=[UIFont systemFontOfSize:12];

    }
    else
    {
        Hyderabad.font=[UIFont systemFontOfSize:14];
        Pune.font=[UIFont systemFontOfSize:14];
        Chennai.font=[UIFont systemFontOfSize:14];
        Bangalore.font=[UIFont systemFontOfSize:14];
    }
    
    
    chkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
 
    chkBtn.tag=1;
    
    [chkBtn setImage:[UIImage imageNamed:@"unchk.png"]
            forState:UIControlStateNormal];
    [chkBtn setImage:[UIImage imageNamed:@"chk.png"]
            forState:UIControlStateSelected];
    
    [chkBtn addTarget:self
               action:@selector(chkBtnHandler:)
     forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:chkBtn];
    
    
    
    
    
    chkBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
   
    chkBtn1.tag=2;
    
    [chkBtn1 setImage:[UIImage imageNamed:@"unchk.png"]
            forState:UIControlStateNormal];
    [chkBtn1 setImage:[UIImage imageNamed:@"chk.png"]
            forState:UIControlStateSelected];
    
    [chkBtn1 addTarget:self
               action:@selector(chkBtnHandler:)
     forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:chkBtn1];
  
    
    
    
    chkBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    chkBtn2.tag=3;

    
    [chkBtn2 setImage:[UIImage imageNamed:@"unchk.png"]
            forState:UIControlStateNormal];
    [chkBtn2 setImage:[UIImage imageNamed:@"chk.png"]
            forState:UIControlStateSelected];
    
    [chkBtn2 addTarget:self
               action:@selector(chkBtnHandler:)
     forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:chkBtn2];
    

    chkBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
   
    
    chkBtn3.tag=4;
    
    [chkBtn3 setImage:[UIImage imageNamed:@"unchk.png"]
            forState:UIControlStateNormal];
    [chkBtn3 setImage:[UIImage imageNamed:@"chk.png"]
            forState:UIControlStateSelected];
    
    [chkBtn3 addTarget:self
               action:@selector(chkBtnHandler:)
     forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:chkBtn3];
   
 
     signupbtn=[[UIButton alloc]init];
   [signupbtn addTarget:self action:@selector(signupdetails:) forControlEvents:UIControlEventTouchUpInside];
    [signupbtn setTitle:@"sign Up" forState:UIControlStateNormal];
    [signupbtn setBackgroundColor:[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0]];
    signupbtn.layer.cornerRadius=5.0;
    
    [scrollView addSubview:signupbtn];
    

    
    [self frames];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width,CGRectGetMaxY(signupbtn.frame)+60);
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardOnScreen:) name:UIKeyboardWillShowNotification object:nil];
    // Do any additional setup after loading the view.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [scrollView setContentOffset:CGPointMake(0,51) animated:NO];
    [firastname resignFirstResponder];
    [lastname resignFirstResponder];
    [companynm resignFirstResponder];
    [bussinessE_id resignFirstResponder];
    [personalE_id resignFirstResponder];
    [contactno resignFirstResponder];
    [alterno resignFirstResponder];
    [currenloc resignFirstResponder];
    [password resignFirstResponder];
    [confpassword resignFirstResponder];
    [profilepic resignFirstResponder];
//    if(textField!=confpassword)
//    {
//    NSInteger nextTag = textField.tag + 1;
//    // Try to find next responder
//    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
//    if (nextResponder) {
//        // Found next responder, so set it.
//        [nextResponder becomeFirstResponder];
//    } else {
//        // Not found, so remove keyboard.
//        [textField resignFirstResponder];
//    }
//    return NO;
//    }
//    else
//    {
//        // [textField becomeFirstResponder];
//         [textField resignFirstResponder];
//        return NO;
//    }

    return YES;
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
    float ty=textField.frame.origin.y;
    float th=textField.frame.size.height;
    if(y==0)
        y=375;
    if (ty+50>=y&&textField.tag!=11)
    {
     [scrollView setContentOffset:CGPointMake(0,(ty-y)+2*th+20) animated:NO];
    }
    if (textField.tag==11) {
        [profilepic resignFirstResponder];
        // profilepic.text=@"image uploaded successfully";
        [self takePic:nil];
       }
}


- (void)takePic:(id)sender {
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:27/255.0 green:35/255.0 blue:66/255.0 alpha:1.0]];
    
    
    UIAlertController * alertview=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:nil
                                      preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction* online = [UIAlertAction
                             actionWithTitle:@"Camera"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [self TakePhotoWithCamera];
                             }];
    UIAlertAction* offline = [UIAlertAction
                              actionWithTitle:@"Photo"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  [self TakePhotoWithGallery];
                              }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleCancel
                             handler:^(UIAlertAction * action)
                             {
                                 [alertview dismissViewControllerAnimated:YES completion:nil];
                             }];
    
    //        [online setValue:[[UIImage imageNamed:@"ic_camera"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forKey:@"image"];
    //        [offline setValue:[[UIImage imageNamed:@"ic_di_manual"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forKey:@"image"];
    
    [alertview addAction:online];
    [alertview addAction:offline];
    
    [alertview addAction:cancel];
    [self presentViewController:alertview animated:YES completion:nil];
    
    
}
-(void)TakePhotoWithCamera
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertController *alertController;
        alertController = [UIAlertController  alertControllerWithTitle:@"Error"  message:@"Device No Camera"  preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }else{
        imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
         imagePicker.delegate=self;
        [imagePicker setAllowsEditing:YES];
        [self presentViewController:imagePicker animated:YES completion:nil];
        camerabool=YES;
    }
}
-(void)TakePhotoWithGallery
{
    imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePicker.delegate = self;
    [imagePicker setAllowsEditing:YES];
    [self presentViewController:imagePicker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"%@",info);
    [self dismissViewControllerAnimated:false completion:^
     {
         UIImage *imgSelected = info[UIImagePickerControllerOriginalImage];
         imageurl=info[UIImagePickerControllerReferenceURL];
         extension = [[imageurl pathExtension] lowercaseString];
         NSLog(@"%@",extension);
         // [img setImage:nil];
         [self presentCropViewControllerWithImage:imgSelected];
     }];
    
    
//    if(camerabool==YES)
//    {
//        UIImage *imgSelected = info[UIImagePickerControllerOriginalImage];
//        imagedata=UIImageJPEGRepresentation(imgSelected, 1.0);
//       // [img setImage:imgSelected];
//        base64string=[imagedata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//        extension=@"jpg";
//        [picker dismissViewControllerAnimated:YES completion:NULL];
//        camerabool=NO;
//        [NSTimer scheduledTimerWithTimeInterval:1.0f
//                                         target:self
//                                       selector:@selector(profileText)
//                                       userInfo:nil
//                                        repeats:YES];
//    }
//    else
//    {
  //  UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
   // }
//    imageurl=info[UIImagePickerControllerReferenceURL];
//    profilepic.text=[NSString stringWithFormat:@"%@",imageurl];
//     extension = [[imageurl pathExtension] lowercaseString];
//   // [extension lowercaseString];
//    NSLog(@"%@",extension);
//    CFStringRef imageUTI = (UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,(__bridge CFStringRef)extension , NULL));
//    NSLog(@"%@",imageUTI);
//    if (UTTypeConformsTo(imageUTI, kUTTypeJPEG))
//    {
//    imagedata=UIImageJPEGRepresentation(chosenImage, 1.0);
//    base64string=[imagedata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//    }
//    else if (UTTypeConformsTo(imageUTI, kUTTypePNG))
//    {
//       imagedata=UIImagePNGRepresentation(chosenImage);
//    base64string=[imagedata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//    }
//    else
//    {
//       // NSLog(@"Unhandled Image UTI: %@", imageUTI);
//        imagedata=UIImageJPEGRepresentation(chosenImage, 1.0);
//        base64string=[imagedata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//        extension=@"jpg";
//    }
//    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)presentCropViewControllerWithImage:(UIImage *)imgInput
{
    TOCropViewController *vcCropView = [[TOCropViewController alloc] initWithImage:imgInput];
    [vcCropView setDelegate:self];
    // Optional customisation.
    //    [vcCropView setRotateButtonsHidden:true];
    //    [vcCropView setRotateClockwiseButtonHidden:true];
    //    [vcCropView setAspectRatioPickerButtonHidden:true];
    [self presentViewController:vcCropView animated:false completion:nil];
}


- (void)cropViewController:(TOCropViewController *)cropViewController didCropToImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle
{
   // [img setImage:image];
   // profilepic.text=@"image uploaded successfully";
    CFStringRef imageUTI = (UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,(__bridge CFStringRef)extension , NULL));
    NSLog(@"%@",imageUTI);
    
    if (UTTypeConformsTo(imageUTI, kUTTypeJPEG))
    {
        
        base64string =[UIImageJPEGRepresentation(image,1.0) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
       // profilepic.text=@"image uploaded successfully";
    }
    else if (UTTypeConformsTo(imageUTI, kUTTypePNG))
    {
        
        base64string =[UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
       // profilepic.text=@"image uploaded successfully";
    }
    else
    {
        // NSLog(@"Unhandled Image UTI: %@", imageUTI);
        imagedata=UIImageJPEGRepresentation(image, 1.0);
        base64string=[imagedata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        extension=@"jpg";
        
    }
    // [picker dismissViewControllerAnimated:YES completion:NULL];
    
    [self dismissViewControllerAnimated:true completion:nil];
    profilepic.text=@"image uploaded successfully";
            [NSTimer scheduledTimerWithTimeInterval:1.0f
                                             target:self
                                           selector:@selector(profileText)
                                           userInfo:nil
                                            repeats:YES];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"forgotPassword"];
            [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)profileText
{
    profilepic.text=@"image uploaded successfully";
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
- (void)cropViewController:(nonnull TOCropViewController *)cropViewController didFinishCancelled:(BOOL)cancelled
{
    base64string=nil;
    extension=nil;
    profilepic.text=@"";
        [self dismissViewControllerAnimated:true completion:nil];

    
}

//- (BOOL)prefersStatusBarHidden
//{
//    return YES;
//}
-(void)frames
{
    firastname.frame=CGRectMake(10,0 ,self.view.frame.size.width-20 ,50 );
    lastname.frame=CGRectMake(10,CGRectGetMaxY(firastname.frame)+5 , self.view.frame.size.width-20, 50);
    companynm.frame=CGRectMake(10,CGRectGetMaxY(lastname.frame)+5 , self.view.frame.size.width-20, 50);
    bussinessE_id.frame=CGRectMake(10,CGRectGetMaxY(companynm.frame)+5 , self.view.frame.size.width-20, 50);
    personalE_id.frame=CGRectMake(10,CGRectGetMaxY(bussinessE_id.frame)+5 , self.view.frame.size.width-20, 50);
    contactno.frame=CGRectMake(10,CGRectGetMaxY(personalE_id.frame)+5 , self.view.frame.size.width-20, 50);
    alterno.frame=CGRectMake(10,CGRectGetMaxY(contactno.frame)+5 , self.view.frame.size.width-20, 50);
    currenloc.frame=CGRectMake(10,CGRectGetMaxY(alterno.frame)+5 , self.view.frame.size.width-20, 50);
    password.frame=CGRectMake(10,CGRectGetMaxY(currenloc.frame)+5 , self.view.frame.size.width-20, 50);
    confpassword.frame=CGRectMake(10,CGRectGetMaxY(password.frame)+5 , self.view.frame.size.width-20, 50);
    profilepic.frame=CGRectMake(10,CGRectGetMaxY(confpassword.frame)+5 , self.view.frame.size.width-20, 50);
    intrestedlocation.frame=CGRectMake(10,CGRectGetMaxY(profilepic.frame)+5 , self.view.frame.size.width-20, 50);
    [chkBtn setFrame:CGRectMake(5,CGRectGetMaxY(intrestedlocation.frame)-2,20, 20)];
    Hyderabad.frame=CGRectMake(CGRectGetMaxX(chkBtn.frame)+2,CGRectGetMaxY(intrestedlocation.frame)-5, self.view.frame.size.width/4-15, 30);
    [chkBtn1 setFrame:CGRectMake(CGRectGetMaxX(Hyderabad.frame)+3,CGRectGetMaxY(intrestedlocation.frame)-2,20, 20)];
    Bangalore.frame=CGRectMake(CGRectGetMaxX(chkBtn1.frame)+3,CGRectGetMaxY(intrestedlocation.frame)-5 , self.view.frame.size.width/4-20, 30);
    [chkBtn2 setFrame:CGRectMake(CGRectGetMaxX(Bangalore.frame)+3,CGRectGetMaxY(intrestedlocation.frame)-2,20, 20)];
    Chennai.frame=CGRectMake(CGRectGetMaxX(chkBtn2.frame)+3,CGRectGetMaxY(intrestedlocation.frame)-5 , self.view.frame.size.width/4-30, 30);
    [chkBtn3 setFrame:CGRectMake(CGRectGetMaxX(Chennai.frame)+3,CGRectGetMaxY(intrestedlocation.frame)-2,20, 20)];
    Pune.frame=CGRectMake(CGRectGetMaxX(chkBtn3.frame)+3,CGRectGetMaxY(intrestedlocation.frame)-5 , self.view.frame.size.width/4-20, 30);
    signupbtn.frame=CGRectMake(120,CGRectGetMaxY(intrestedlocation.frame)+40 , self.view.frame.size.width-220, 34);

    
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    if ([contactno.text length] > 10) {
//        contactno.text = [contactno.text substringToIndex:10-1];
//        return NO;
//    }
//    return YES;
//}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    int limit = 9;
    if(textField==contactno)
    {
        return !([contactno.text length]>limit && [string length] > range.length);
    }
    else if(textField==alterno)
    {
        return !([alterno.text length]>limit && [string length] > range.length);
    }
    return YES;
    
}
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    if(contactno)
//    {
//    int length = (int )[textField.text length] ;
//    if (length >= 10 && ![string isEqualToString:@""]) {
//        contactno.text = [contactno.text substringToIndex:10];
//      //  alterno.text = [alterno.text substringToIndex:10];
//        return NO;
//    }
//    }
//   else if(alterno)
//    {
//    int length1 = (int )[alterno.text length] ;
//    if (length1 >= 10 && ![string isEqualToString:@""]) {
//        alterno.text = [contactno.text substringToIndex:10];
//        return NO;
//    }
//    }
//    return YES;
//}
- (BOOL)validatePhone:(NSString*)phone
{
    NSString *str1=@"^[2-9][0-9]{9}$";
    NSPredicate *no=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",str1];
    if([no evaluateWithObject:phone]==NO)
    {
        UIAlertController *alertController;
        alertController = [UIAlertController  alertControllerWithTitle:@"Warning"  message:@"Please Enter Valid Phone Number."  preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    return [no evaluateWithObject:phone];
}
- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailReg = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailReg];
    
    if ([emailTest evaluateWithObject:email] == NO)
    {
        UIAlertController *alertController;
        alertController = [UIAlertController  alertControllerWithTitle:@"Warning"  message:@"Please Enter Valid Email Address."  preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    return [emailTest evaluateWithObject:email];
}
-(void)signupdetails:(UIButton *)button
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    UIAlertController *alertController;
    if (networkStatus == NotReachable)
    {
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
        
        if ([firastname.text isEqualToString:@""]) {
            alertController = [UIAlertController  alertControllerWithTitle:@""  message:@"Please enter first name"  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
                [firastname becomeFirstResponder];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else  if ([lastname.text isEqualToString:@""]) {
            alertController = [UIAlertController  alertControllerWithTitle:@""  message:@"Please enter last name"  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
                 [lastname becomeFirstResponder];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else  if ([companynm.text isEqualToString:@""]) {
            alertController = [UIAlertController  alertControllerWithTitle:@""  message:@"Please enter Company name"  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
                [companynm becomeFirstResponder];

            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else  if ([bussinessE_id.text isEqualToString:@""]) {
            alertController = [UIAlertController  alertControllerWithTitle:@""  message:@"Please enter bussiness email id"  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
                [bussinessE_id becomeFirstResponder];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else  if ([personalE_id.text isEqualToString:@""]) {
            alertController = [UIAlertController  alertControllerWithTitle:@""  message:@"Please enter personal email id"  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
                [personalE_id becomeFirstResponder];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else  if ([contactno.text isEqualToString:@""]) {
            alertController = [UIAlertController  alertControllerWithTitle:@""  message:@"Please enter Contact number"  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
                 [contactno becomeFirstResponder];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else  if ([contactno.text isEqualToString:@""]) {
            alertController = [UIAlertController  alertControllerWithTitle:@""  message:@"Please enter Contact number"  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
                [contactno becomeFirstResponder];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else  if ([alterno.text isEqualToString:@""]) {
            alertController = [UIAlertController  alertControllerWithTitle:@""  message:@"Please enter Alternative number"  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
                [alterno becomeFirstResponder];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else  if ([password.text isEqualToString:@""]) {
            alertController = [UIAlertController  alertControllerWithTitle:@""  message:@"Please enter Password"  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
                [password becomeFirstResponder];

            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else  if ([confpassword.text isEqualToString:@""]) {
            alertController = [UIAlertController  alertControllerWithTitle:@""  message:@"Please enter Confirm Password"  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
                [confpassword becomeFirstResponder];

            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else  if ([profilepic.text isEqualToString:@""]) {
            alertController = [UIAlertController  alertControllerWithTitle:@""  message:@"Please choose profile pic"  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
                [profilepic becomeFirstResponder];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else  if ([profilepic.text isEqualToString:@""]) {
            alertController = [UIAlertController  alertControllerWithTitle:@""  message:@"Please enter Contact number"  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
                [profilepic becomeFirstResponder];

            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else if ([currenloc.text isEqualToString:@""])
        {
            alertController = [UIAlertController  alertControllerWithTitle:@""  message:@"Please enter current location"  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }]];
            [currenloc becomeFirstResponder];
            [self presentViewController:alertController animated:YES completion:nil];
        }

        else if(![self validatePhone:contactno.text])
        {
            UIAlertController *alertController;
            alertController = [UIAlertController  alertControllerWithTitle:@"Warning"  message:@"Please Enter Valid Phone Number."  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
                [contactno becomeFirstResponder];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if(![self validatePhone:alterno.text])
        {
            UIAlertController *alertController;
            alertController = [UIAlertController  alertControllerWithTitle:@"Warning"  message:@"Please Enter Valid Phone Number."  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
                [alterno becomeFirstResponder];

            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
       else if (![self validateEmailWithString:bussinessE_id.text])
        {
            UIAlertController *alertController;
            alertController = [UIAlertController  alertControllerWithTitle:@"Warning"  message:@"Please Enter Valid Email Address."  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
                 [bussinessE_id becomeFirstResponder];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
       else if (![self validateEmailWithString:personalE_id.text])
        {
            UIAlertController *alertController;
            alertController = [UIAlertController  alertControllerWithTitle:@"Warning"  message:@"Please Enter Valid Email Address."  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            [personalE_id becomeFirstResponder];

        }
        else if(![password.text isEqualToString:confpassword.text])
        {
            UIAlertController *alertController;
            alertController = [UIAlertController  alertControllerWithTitle:@"Warning"  message:@"Confirm password is not equal password ."  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
             [confpassword becomeFirstResponder];
            
        }
        else if(![chkBtn isSelected]&![chkBtn1 isSelected]&![chkBtn2 isSelected]&![chkBtn3 isSelected])
        {
            UIAlertController *alertController;
            alertController = [UIAlertController  alertControllerWithTitle:@""  message:@"Please Select any location"  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else {
             [SVProgressHUD show];
            NSString *locations=@"";
            if([chkBtn isSelected])
            {
                locations=[locations stringByAppendingFormat:@"%@", Hyderabad.text];
            }
            if ([chkBtn1 isSelected]) {
                if ([locations isEqualToString:@""])
                 locations=[locations stringByAppendingFormat:@"%@",Bangalore.text];
                else
                    locations=[locations stringByAppendingFormat:@",%@",Bangalore.text];
            }
            if ([chkBtn2 isSelected]) {
                if ([locations isEqualToString:@""])
                locations=[locations stringByAppendingFormat:@"%@" ,Chennai.text];
                else
                    locations=[locations stringByAppendingFormat:@",%@" ,Chennai.text];
            }
            if ([chkBtn3 isSelected]) {
                if ([locations isEqualToString:@""])
                locations=[locations stringByAppendingFormat:@"%@", Pune.text];
                else
                    locations=[locations stringByAppendingFormat:@",%@", Pune.text];
            }
            NSLog(@"%@",locations);
 
            NSArray *objects = [NSArray arrayWithObjects: personalE_id.text,confpassword.text,firastname.text,lastname.text,companynm.text,base64string,bussinessE_id.text,personalE_id.text,contactno.text,alterno.text,currenloc.text,locations,extension ,nil];
            NSArray *keys = [NSArray arrayWithObjects:@"username", @"password", @"first_name",@"last_name",@"company_name",@"profile_pic",@"business_email_id",@"personal_email_id", @"contact_number",@"alternate_contact_number",@"current_location",@"interested_location",@"file_extension",nil];
            NSDictionary *jsonDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:0 error:nil];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:[NSURL URLWithString:@"http://facilitymanagementcouncil.com/admin/service/registration"]];
            request.HTTPBody = jsonData;
            [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPMethod:@"POST"];
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
        NSLog(@"%@",dic);
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
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
    
}
-(void)sucesstask
{
    if (!(dic==nil)) {
        [SVProgressHUD dismiss];
        int i=[[dic valueForKey:@"status"]intValue];
        if (i==0) {
            UIAlertController *alertController;
            alertController = [UIAlertController  alertControllerWithTitle:@"Warning"  message:[dic valueForKey:@"message"]  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
        else
        {
            
//            [[NSUserDefaults standardUserDefaults] setObject:[dic valueForKey:@"status"] forKey:@"status"];
            [[NSUserDefaults standardUserDefaults] setObject:[dic valueForKey:@"company_name"] forKey:@"company_name"];
            [[NSUserDefaults standardUserDefaults] setObject:[dic valueForKey:@"user_name"] forKey:@"user_name"];
            [[NSUserDefaults standardUserDefaults] setObject:[dic valueForKey:@"profile_pic"] forKey:@"profile_pic"];
            NSLog(@"%@",[dic valueForKey:@"profile_pic"]);

            UIAlertController *alertController;
            alertController = [UIAlertController  alertControllerWithTitle:@""  message:@"Sign UP Secussecfully completed"  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
                [self dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"forgotPassword"];
            [[NSUserDefaults standardUserDefaults] synchronize];

           
        }
    }
    else
    {
        [SVProgressHUD dismiss];
         [self.view makeToast:@"Please check network" duration:1.0 position:@"center"];
//        UIAlertController *alertController;
//        alertController = [UIAlertController  alertControllerWithTitle:@""  message:@"Some thing went worng"  preferredStyle:UIAlertControllerStyleAlert];
//        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//            [alertController dismissViewControllerAnimated:YES completion:nil];
//            [self dismissViewControllerAnimated:YES completion:nil];
//        }]];
//        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    
    
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)chkBtnHandler:(UIButton *)sender {
//    if(sender.tag==1)
//    {
//        [chkBtn setSelected:YES];
//        [chkBtn1 setSelected:NO];
//        [chkBtn2 setSelected:NO];
//        [chkBtn3 setSelected:NO];
//    }
//    else if(sender.tag==2){
//        [chkBtn setSelected:NO];
//        [chkBtn1 setSelected:YES];
//        [chkBtn2 setSelected:NO];
//        [chkBtn3 setSelected:NO];
//        
//    }
//    else if(sender.tag==3){
//        [chkBtn setSelected:NO];
//        [chkBtn1 setSelected:NO];
//        [chkBtn2 setSelected:YES];
//        [chkBtn3 setSelected:NO];
//        
//    }
//    else
//    {
//        [chkBtn setSelected:NO];
//        [chkBtn1 setSelected:NO];
//        [chkBtn2 setSelected:NO];
//        [chkBtn3 setSelected:YES];
//    }
     [(UIButton *)sender setSelected:![(UIButton *)sender isSelected]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
