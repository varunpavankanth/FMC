//
//  EditViewController.m
//  FMC
//
//  Created by Nennu on 24/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import "EditViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "Reachability.h"
#import "UIView+Toast.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
#define padding 10
@interface EditViewController ()
{
    UIButton *profilebtn;
    UITextField * userNameField, *lastname,*companyname,*email,*altenatephono,*phoneno,*location;
    UILabel * intrestedlocation;
    UILabel * Hyderabad;
    UILabel * Chennai;
    UILabel * Bangalore;
    UILabel * Pune;
    UIButton* chkBtn,*chkBtn1,*chkBtn2,*chkBtn3,*signupbtn;
    UIImagePickerController *imagePicker;
    NSURL *imageurl;
    NSString *extension;
    NSString *base64string;
    NSData *imagedata;
    NSError *error1;
    UIImageView*img;
    NSMutableDictionary *dic;

}

@end

@implementation EditViewController
@synthesize scrollView;
- (void)viewDidLoad {
    [super viewDidLoad];
    scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.delegate = self;
    [scrollView setScrollEnabled:YES];
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.indicatorStyle=UIScrollViewIndicatorStyleWhite;
    scrollView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:scrollView];
    
    NSURLSessionConfiguration *sessionConfig=[NSURLSessionConfiguration ephemeralSessionConfiguration];
    self.urlSession= [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    
    img=[[UIImageView alloc]init];
    [img sd_setImageWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults] valueForKey:@"profile_pic"]] placeholderImage:[UIImage imageNamed:@"deafult_icon.png"]];
    img.frame = CGRectMake(CGRectGetWidth(scrollView.frame)/2-50,20, 100, 100);
    img.clipsToBounds = YES;
    
    img.layer.cornerRadius = 100/2.0f;
    img.layer.borderColor=[[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0]CGColor];
    [scrollView addSubview:img];
    
    UIColor *textcolor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
   
    UIButton* cam=[[UIButton alloc]init];
     [cam addTarget:self action:@selector(takePic:) forControlEvents:UIControlEventTouchUpInside];
    UIImage *eventbtn = [UIImage imageNamed:@"cam.png"];
    [cam setImage:eventbtn forState:UIControlStateNormal];
    [cam setBackgroundColor:[UIColor clearColor]];
    cam.frame = CGRectMake(CGRectGetMaxX(img.frame)-30,CGRectGetMaxY(img.frame)-30,40,40 );
    
    cam.layer.cornerRadius=10;
    [scrollView addSubview:cam];
    
    
    
    userNameField = [[UITextField alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(cam.frame),CGRectGetWidth(self.view.frame)-20, 44)];
    //username.backgroundColor = [UIColor redColor]; // For testing purpose
    userNameField.leftViewMode = UITextFieldViewModeAlways;// Set rightview mode
    userNameField.font=[UIFont systemFontOfSize:15];
    userNameField.delegate=self;
    userNameField.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"first_name"];
    userNameField.textColor=textcolor;
    userNameField.tag=1;
    userNameField.borderStyle = UITextBorderStyleRoundedRect;
    userNameField.layer.borderColor = [[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0]CGColor];
    userNameField.layer.borderWidth= 1.0f;
    //userNameField.layer.cornerRadius=10;
    userNameField.backgroundColor=[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
    userNameField.autocorrectionType=UITextAutocorrectionTypeNo;
    [userNameField setSecureTextEntry:NO];
   [userNameField setLeftViewMode:UITextFieldViewModeAlways];
    UIImageView *leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_icon.png"]];
    userNameField.leftView = leftImageView; // Set right view as image view
    [userNameField setRightViewMode:UITextFieldViewModeAlways];
    UIImageView *reightImageView1=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pen.png"]];
    userNameField.rightView=reightImageView1;

    [scrollView addSubview:userNameField];
    


    lastname = [[UITextField alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(userNameField.frame)+10,CGRectGetWidth(self.view.frame)-20, 44)];
    //username.backgroundColor = [UIColor redColor]; // For testing purpose
    lastname.leftViewMode = UITextFieldViewModeAlways;// Set rightview mode
    lastname.font=[UIFont systemFontOfSize:15];
    //    userNameField.text=[_dict objectForKey:@"username"];
    lastname.delegate=self;
    lastname.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"last_name"];
    lastname.textColor=textcolor;
    lastname.borderStyle = UITextBorderStyleRoundedRect;
    lastname.layer.borderColor = [[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0]CGColor];
    lastname.layer.borderWidth= 1.0f;
    //userNameField.layer.cornerRadius=10;
    lastname.backgroundColor=[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
    lastname.autocorrectionType=UITextAutocorrectionTypeNo;
    [lastname setSecureTextEntry:NO];
   [lastname setLeftViewMode:UITextFieldViewModeAlways];
    UIImageView *leftImageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_icon.png"]];
    lastname.leftView = leftImageView1;
    [lastname setRightViewMode:UITextFieldViewModeAlways];
    UIImageView *reightImageView2=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pen.png"]];
    lastname.rightView=reightImageView2;
    
    [scrollView addSubview:lastname];
    

    
    companyname = [[UITextField alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(lastname.frame)+10,CGRectGetWidth(self.view.frame)-20, 44)];
    //username.backgroundColor = [UIColor redColor]; // For testing purpose
    companyname.leftViewMode = UITextFieldViewModeAlways;// Set rightview mode
    companyname.font=[UIFont systemFontOfSize:15];
    //    userNameField.text=[_dict objectForKey:@"username"];
    companyname.delegate=self;
    companyname.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"company_name"];
    companyname.textColor=textcolor;
    companyname.borderStyle = UITextBorderStyleRoundedRect;
    companyname.layer.borderColor = [[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0]CGColor];
    companyname.layer.borderWidth= 1.0f;
    //userNameField.layer.cornerRadius=10;
    companyname.backgroundColor=[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
    companyname.autocorrectionType=UITextAutocorrectionTypeNo;
    [companyname setSecureTextEntry:NO];
   [companyname setLeftViewMode:UITextFieldViewModeAlways];
    UIImageView *leftImageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"company_name.png"]];
    companyname.leftView = leftImageView2;
    [companyname setRightViewMode:UITextFieldViewModeAlways];
    UIImageView *reightImageView3=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pen.png"]];
    companyname.rightView=reightImageView3;
    [scrollView addSubview:companyname];
    

    
    email = [[UITextField alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(companyname.frame)+10,CGRectGetWidth(self.view.frame)-20, 44)];
    //username.backgroundColor = [UIColor redColor]; // For testing purpose
    email.leftViewMode = UITextFieldViewModeAlways;// Set rightview mode
    email.font=[UIFont systemFontOfSize:15];
    //    userNameField.text=[_dict objectForKey:@"username"];
    email.delegate=self;
    email.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"business_email_id"];;
    email.textColor=textcolor;
    email.borderStyle = UITextBorderStyleRoundedRect;
    email.layer.borderColor = [[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0]CGColor];
    email.layer.borderWidth= 1.0f;
    //userNameField.layer.cornerRadius=10;
    email.backgroundColor=[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
    email.autocorrectionType=UITextAutocorrectionTypeNo;
    [email setSecureTextEntry:NO];
    //username.layer.borderColor=[[UIColor blackColor];
    [email setLeftViewMode:UITextFieldViewModeAlways];
    UIImageView *leftImageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mail_icon.png"]];
    email.leftView = leftImageView3; // Set right view as image view
    [email setRightViewMode:UITextFieldViewModeAlways];
    UIImageView *reightImageView4=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pen.png"]];
    email.rightView=reightImageView4;
    [scrollView addSubview:email];
    

    altenatephono = [[UITextField alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(email.frame)+10,CGRectGetWidth(self.view.frame)-20, 44)];
    //username.backgroundColor = [UIColor redColor]; // For testing purpose
    altenatephono.leftViewMode = UITextFieldViewModeAlways;// Set rightview mode
    altenatephono.font=[UIFont systemFontOfSize:15];
    //    userNameField.text=[_dict objectForKey:@"username"];
    altenatephono.delegate=self;
    altenatephono.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"contact_number"];;
    altenatephono.textColor=textcolor;
    altenatephono.borderStyle = UITextBorderStyleRoundedRect;
    altenatephono.layer.borderColor = [[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0]CGColor];
    altenatephono.layer.borderWidth= 1.0f;
    //userNameField.layer.cornerRadius=10;
    altenatephono.backgroundColor=[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
    altenatephono.autocorrectionType=UITextAutocorrectionTypeNo;
    [ altenatephono setSecureTextEntry:NO];
    //username.layer.borderColor=[[UIColor blackColor];
    [altenatephono setLeftViewMode:UITextFieldViewModeAlways];
    UIImageView *leftImageView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mobile_icon.png"]];
    altenatephono.leftView = leftImageView4; // Set right view as image view
    [altenatephono setRightViewMode:UITextFieldViewModeAlways];
    UIImageView *reightImageView5=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pen.png"]];
    altenatephono.rightView=reightImageView5;
    [scrollView addSubview: altenatephono];
    

    
    
    phoneno = [[UITextField alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(altenatephono.frame)+10,CGRectGetWidth(self.view.frame)-20, 44)];
    //username.backgroundColor = [UIColor redColor]; // For testing purpose
    phoneno.leftViewMode = UITextFieldViewModeAlways;// Set rightview mode
    phoneno.font=[UIFont systemFontOfSize:15];
    //    userNameField.text=[_dict objectForKey:@"username"];
    phoneno.delegate=self;
    phoneno.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"alternate_contact_number"];
    phoneno.textColor=textcolor;
    phoneno.borderStyle = UITextBorderStyleRoundedRect;
    phoneno.layer.borderColor = [[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0]CGColor];
    phoneno.layer.borderWidth= 1.0f;
    //userNameField.layer.cornerRadius=10;
    phoneno.backgroundColor=[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
    phoneno.autocorrectionType=UITextAutocorrectionTypeNo;
    [ phoneno setSecureTextEntry:NO];
    //username.layer.borderColor=[[UIColor blackColor];
    [phoneno setLeftViewMode:UITextFieldViewModeAlways];
    UIImageView *leftImageView5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mobile_icon.png"]];
    phoneno.leftView = leftImageView5; // Set right view as image view
    [phoneno setRightViewMode:UITextFieldViewModeAlways];
    UIImageView *reightImageView6=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pen.png"]];
    phoneno.rightView=reightImageView6;
    [scrollView addSubview: phoneno];

    
    location = [[UITextField alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(phoneno.frame)+10,CGRectGetWidth(self.view.frame)-20, 44)];
    //username.backgroundColor = [UIColor redColor]; // For testing purpose
    location.leftViewMode = UITextFieldViewModeAlways;// Set rightview mode
    location.font=[UIFont systemFontOfSize:15];
    //    userNameField.text=[_dict objectForKey:@"username"];
    location.delegate=self;
    location.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"current_location"];;
    location.textColor=textcolor;
    location.borderStyle = UITextBorderStyleRoundedRect;
    location.layer.borderColor = [[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0]CGColor];
    location.layer.borderWidth= 1.0f;
    //userNameField.layer.cornerRadius=10;
    location.backgroundColor=[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
    location.autocorrectionType=UITextAutocorrectionTypeNo;
    [ location setSecureTextEntry:NO];
   [location setLeftViewMode:UITextFieldViewModeAlways];
    UIImageView *leftImageView6 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"location_icon.png"]];
    location.leftView = leftImageView6; // Set right view as image view
    location.leftView.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    [location setRightViewMode:UITextFieldViewModeAlways];
    UIImageView *reightImageView7=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pen.png"]];
    location.rightView=reightImageView7;
    [scrollView addSubview: location];
    
    intrestedlocation=[[UILabel alloc]initWithFrame:CGRectMake(padding, CGRectGetMaxY(location.frame)+10,CGRectGetWidth(self.view.frame)-120, 44)];
    
    intrestedlocation.text=@"Interested Location";
    intrestedlocation.textColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    [scrollView addSubview:intrestedlocation];
    
    
    
    chkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    [chkBtn setFrame:CGRectMake(padding,CGRectGetMaxY(intrestedlocation.frame)-2,20, 20)];
    [chkBtn setImage:[UIImage imageNamed:@"unchk.png"]
            forState:UIControlStateNormal];
    [chkBtn setImage:[UIImage imageNamed:@"chk.png"]
            forState:UIControlStateSelected];
    
    [chkBtn addTarget:self
               action:@selector(chkBtnHandler:)
     forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:chkBtn];
    
    
    
    
    
    
    Hyderabad=[[UILabel alloc]init];
    Hyderabad.text=@"Hyderabad";
    Hyderabad.frame=CGRectMake(CGRectGetMaxX(chkBtn.frame)+2,CGRectGetMaxY(intrestedlocation.frame)-5, self.view.frame.size.width-20, 30);
    Hyderabad.textColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    [scrollView addSubview:Hyderabad];
    
    
    
    chkBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    [chkBtn1 setFrame:CGRectMake(CGRectGetMinX(Hyderabad.frame)+90,CGRectGetMaxY(intrestedlocation.frame)-2,20, 20)];
    [chkBtn1 setImage:[UIImage imageNamed:@"unchk.png"]
             forState:UIControlStateNormal];
    [chkBtn1 setImage:[UIImage imageNamed:@"chk.png"]
             forState:UIControlStateSelected];
    
    [chkBtn1 addTarget:self
                action:@selector(chkBtnHandler:)
      forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:chkBtn1];
    
    
    Bangalore=[[UILabel alloc]init];
    Bangalore.text=@"Bangalore";
    Bangalore.frame=CGRectMake(CGRectGetMaxX(chkBtn1.frame)+2,CGRectGetMaxY(intrestedlocation.frame)-5, self.view.frame.size.width-20, 30);
    Bangalore.textColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    [scrollView addSubview:Bangalore];
    
    
    
    chkBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [chkBtn2 setFrame:CGRectMake(CGRectGetMinX(Bangalore.frame)+80,CGRectGetMaxY(intrestedlocation.frame)-2,20, 20)];
    
    [chkBtn2 setImage:[UIImage imageNamed:@"unchk.png"]
             forState:UIControlStateNormal];
    [chkBtn2 setImage:[UIImage imageNamed:@"chk.png"]
             forState:UIControlStateSelected];
    
    [chkBtn2 addTarget:self
                action:@selector(chkBtnHandler:)
      forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:chkBtn2];
    
    
    Chennai=[[UILabel alloc]init];
    Chennai.text=@"Chennai";
    Chennai.frame=CGRectMake(CGRectGetMaxX(chkBtn2.frame)+2,CGRectGetMaxY(intrestedlocation.frame)-5, self.view.frame.size.width-20, 30);
    Chennai.textColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    [scrollView addSubview:Chennai];
    
    
    
    chkBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [chkBtn3 setFrame:CGRectMake(CGRectGetMinX(Chennai.frame)+60,CGRectGetMaxY(intrestedlocation.frame)-2,20, 20)];
    [chkBtn3 setImage:[UIImage imageNamed:@"unchk.png"]
             forState:UIControlStateNormal];
    [chkBtn3 setImage:[UIImage imageNamed:@"chk.png"]
             forState:UIControlStateSelected];
    
    [chkBtn3 addTarget:self
                action:@selector(chkBtnHandler:)
      forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:chkBtn3];
    
    
    
    Pune=[[UILabel alloc]init];
    Pune.text=@"Pune";
    Pune.frame=CGRectMake(CGRectGetMaxX(chkBtn3.frame)+2,CGRectGetMaxY(intrestedlocation.frame)-5, self.view.frame.size.width-20, 30);
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
    

    
    signupbtn=[[UIButton alloc]init];
    [signupbtn addTarget:self action:@selector(Editdetails:) forControlEvents:UIControlEventTouchUpInside];
    [signupbtn setTitle:@"Save" forState:UIControlStateNormal];
    [signupbtn setBackgroundColor:[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0]];
    signupbtn.layer.cornerRadius=5.0;
    signupbtn.frame=CGRectMake(120,CGRectGetMaxY(intrestedlocation.frame)+40 , self.view.frame.size.width-220, 34);
    [scrollView addSubview:signupbtn];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width,CGRectGetMaxY(signupbtn.frame)+60);

    // Do any additional setup after loading the view.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [scrollView setContentOffset:CGPointMake(0,51) animated:NO];
    [userNameField resignFirstResponder];
    [lastname resignFirstResponder];
    [companyname resignFirstResponder];
    [email resignFirstResponder];
    [altenatephono resignFirstResponder];
    [phoneno resignFirstResponder];
    [location resignFirstResponder];
    
    
    
    return YES;
}

- (void)chkBtnHandler:(UIButton *)sender {
    // If checked, uncheck and visa versa
    
    [(UIButton *)sender setSelected:![(UIButton *)sender isSelected]];
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
                              actionWithTitle:@"Photo & Video Library"
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
        
        [imagePicker setAllowsEditing:YES];
        [self presentViewController:imagePicker animated:YES completion:nil];
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
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    img.image=chosenImage;
    imageurl=info[UIImagePickerControllerReferenceURL];
    extension = [[imageurl pathExtension] lowercaseString];
    NSLog(@"%@",extension);
    CFStringRef imageUTI = (UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,(__bridge CFStringRef)extension , NULL));
    NSLog(@"%@",imageUTI);
    
    if (UTTypeConformsTo(imageUTI, kUTTypeJPEG))
    {
        base64string =[UIImageJPEGRepresentation(chosenImage,1.0) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }
    else if (UTTypeConformsTo(imageUTI, kUTTypePNG))
    {
        
    base64string =[UIImagePNGRepresentation(chosenImage) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }
    else
    {
        NSLog(@"Unhandled Image UTI: %@", imageUTI);
    }
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*Verfications*/
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
- (BOOL)validateEmailWithString:(NSString*)Email
{
    NSString *emailReg = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailReg];
    
    if ([emailTest evaluateWithObject:Email] == NO)
    {
        UIAlertController *alertController;
        alertController = [UIAlertController  alertControllerWithTitle:@"Warning"  message:@"Please Enter Valid Email Address."  preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    return [emailTest evaluateWithObject:Email];
}

/*Server_Call*/

-(void)Editdetails:(UIButton *)button
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    UIAlertController *alertController;
    if (networkStatus == NotReachable)
    {
        [self.view makeToast:@"No internet connection" duration:1.0 position:@"center"];
    }
    else
    {
        
        if ([userNameField.text isEqualToString:@""]) {
            alertController = [UIAlertController  alertControllerWithTitle:@""  message:@"Please enter first name"  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else  if ([lastname.text isEqualToString:@""]) {
            alertController = [UIAlertController  alertControllerWithTitle:@""  message:@"Please enter last name"  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else  if ([companyname.text isEqualToString:@""]) {
            alertController = [UIAlertController  alertControllerWithTitle:@""  message:@"Please enter Company name"  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else  if ([email.text isEqualToString:@""]) {
            alertController = [UIAlertController  alertControllerWithTitle:@""  message:@"Please enter bussiness email id"  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        
        else  if ([phoneno.text isEqualToString:@""]) {
            alertController = [UIAlertController  alertControllerWithTitle:@""  message:@"Please enter Contact number"  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else  if ([phoneno.text isEqualToString:@""]) {
            alertController = [UIAlertController  alertControllerWithTitle:@""  message:@"Please enter Contact number"  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else  if ([altenatephono.text isEqualToString:@""]) {
            alertController = [UIAlertController  alertControllerWithTitle:@""  message:@"Please enter Contact number"  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        
       else if(![self validatePhone:phoneno.text])
        {
            UIAlertController *alertController;
            alertController = [UIAlertController  alertControllerWithTitle:@"Warning"  message:@"Please Enter Valid Phone Number."  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if(![self validatePhone:altenatephono.text])
        {
            UIAlertController *alertController;
            alertController = [UIAlertController  alertControllerWithTitle:@"Warning"  message:@"Please Enter Valid Phone Number."  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if (![self validateEmailWithString:email.text])
        {
            UIAlertController *alertController;
            alertController = [UIAlertController  alertControllerWithTitle:@"Warning"  message:@"Please Enter Valid Email Address."  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
       
        else if(![chkBtn isSelected]&![chkBtn1 isSelected]&![chkBtn2 isSelected]&![chkBtn3 isSelected])
        {
            UIAlertController *alertController;
            alertController = [UIAlertController  alertControllerWithTitle:@""  message:@"Please Choose plase"  preferredStyle:UIAlertControllerStyleAlert];
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
            if(!base64string)
            {
                NSURL *url=[NSURL URLWithString:[[NSUserDefaults standardUserDefaults] valueForKey:@"profile_pic"]];
                extension= [[url pathExtension] lowercaseString];
                UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
                
                CFStringRef imageUTI = (UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,(__bridge CFStringRef)extension , NULL));
                NSLog(@"%@",imageUTI);
                
                if (UTTypeConformsTo(imageUTI, kUTTypeJPEG))
                {
                    base64string =[UIImageJPEGRepresentation(image,1.0) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                }
                else if (UTTypeConformsTo(imageUTI, kUTTypePNG))
                {
                    
                    base64string =[UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                }
                else
                {
                    NSLog(@"Unhandled Image UTI: %@", imageUTI);
                }
            }
            
            NSArray *objects = [NSArray arrayWithObjects:[[NSUserDefaults standardUserDefaults] valueForKey:@"user_id"],userNameField.text,lastname.text,companyname.text,base64string,email.text,altenatephono.text,phoneno.text,location.text,locations,extension,   nil];
            NSArray *keys = [NSArray arrayWithObjects:@"user_id", @"first_name", @"last_name",@"company_name",@"profile_pic",@"business_email_id",@"contact_number",@"alternate_contact_number", @"current_location",@"interested_location",@"file_extension",nil];
            NSDictionary *jsonDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:0 error:nil];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:[NSURL URLWithString:@"http://facilitymanagementcouncil.com/admin/service/editprofile"]];
            [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            request.HTTPBody = jsonData;
             [request setHTTPMethod:@"POST"];
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
-(void)sucesstask
{
    if (!(dic==nil)) {
         [SVProgressHUD dismiss];
        UIAlertController *alertController;
        if ([[dic valueForKey:@"status"] integerValue]==1)
            Message=@"Your cahnges are Saved Secussfully";
        else
            Message=@"Sorry  we are unable to save changes this time";
        alertController = [UIAlertController  alertControllerWithTitle:@""  message:Message preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
        
            [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"alternate_contact_number"] forKey:@"alternate_contact_number"];
            [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"business_email_id"] forKey:@"business_email_id"];
            [[NSUserDefaults standardUserDefaults] setValue: [dic valueForKey:@"company_name"] forKey:@"company_name"];
            [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"contact_number"] forKey:@"contact_number"];
            [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"current_location"] forKey:@"current_location"];
            [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"first_name"] forKey:@"first_name"];
            [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"interested_location"] forKey:@"interested_location"];
            [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"last_name"] forKey:@"last_name"];
            [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"personal_email_id"] forKey:@"personal_email_id"];
            [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"profile_pic"] forKey:@"profile_pic"];
            [[NSUserDefaults standardUserDefaults] setValue:[dic valueForKey:@"user_id"] forKey:@"user_id"];
            [[NSUserDefaults standardUserDefaults] setObject:[dic valueForKey:@"created_date"] forKey:@"created_date"];
            [[NSUserDefaults standardUserDefaults] setObject:[dic valueForKey:@"modified_date"] forKey:@"modified_date"];
            NSLog(@"%@",[dic valueForKey:@"profile_pic"]);
       


        }
        
        else
        {
            [SVProgressHUD dismiss];
            if ([dic valueForKey:@"status"]==0) {
                UIAlertController *alertController;
                alertController = [UIAlertController  alertControllerWithTitle:@""  message:Message  preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [alertController dismissViewControllerAnimated:YES completion:nil];
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
            //            [[NSUserDefaults standardUserDefaults] setObject:[dic valueForKey:@"status"] forKey:@"status"];
            
        }
    }
   
    
}




@end
