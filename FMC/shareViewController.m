//
//  shareViewController.m
//  FMC
//
//  Created by Nennu on 16/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import "shareViewController.h"
#import "Reachability.h"
#import "UIView+Toast.h"
#import "UIImageView+WebCache.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface shareViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UITextViewDelegate,UIDocumentPickerDelegate>
{
    UIImagePickerController *imagePicker;
    UIImage *cameraImage;
    NSData *postDocumentData;
    NSString *extensionType, *documentName, *mimeType, *fileName,*webContentType;
    UIView *PostedfileView;
    UILabel *Postlabel;
    NSString *PostString;
    NSDictionary *attributes;
    CGRect rect;
    NSMutableDictionary *dic;
    NSError *error1;
    NSString *base64string;
}
@end

@implementation shareViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
   // _textview.delegate = self;
    imagePicker.delegate = self;
    NSURLSessionConfiguration *sessionConfig=[NSURLSessionConfiguration ephemeralSessionConfiguration];
    self.urlSession= [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];

    cameraImage = [[UIImage alloc]init];
    self.view.backgroundColor=[UIColor whiteColor];
    self.imageview=[[UIImageView alloc]initWithFrame:CGRectMake(20, 80, 50, 50)];
    self.imageview.layer.cornerRadius=25.0f;
    self.imageview.clipsToBounds = YES;
//    self.imageview.image=image;
     [_imageview sd_setImageWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults]valueForKey:@"profile_pic"]] placeholderImage:[UIImage imageNamed:@"deafult_icon.png"]];
    [self.view addSubview:self.imageview];
    attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:20]};
    self.textview=[[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageview.frame), 80, self.view.frame.size.width-80,30)];
    self.textview.text=@"Share an artical,Photo or idea";
    self.textview.textColor = [UIColor lightGrayColor];
    self.textview.delegate=self;
    _textview.scrollEnabled =NO;
    _textview.editable = YES;
    [self.view addSubview:self.textview];
    View =[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame)-50,CGRectGetMaxX(self.view.frame), 50)];
    oldframe=View.frame;
   // View.backgroundColor=[UIColor blueColor];
    
    border=[CALayer layer];
    border.borderWidth=1.0f;
    border.borderColor=[UIColor lightGrayColor].CGColor;
    border.frame=CGRectMake(0, 0,CGRectGetMaxX(View.frame), 1);
    [View.layer addSublayer:border];
    cam=[[UIButton alloc]init];
    cam.frame=CGRectMake(15, CGRectGetMinY(border.frame)+10,15 ,15);
    [cam setBackgroundImage:[UIImage imageNamed:@"home_camera.png"] forState:UIControlStateNormal];
    [cam addTarget:self action:@selector(CameraButtonClicked) forControlEvents:UIControlEventTouchUpInside];

    [View addSubview:cam];
    link=[[UIButton alloc]init];
    [link setBackgroundImage:[UIImage imageNamed:@"home_link.png"] forState:UIControlStateNormal];
    link.frame=CGRectMake(CGRectGetMaxX(cam.frame)+15, CGRectGetMinY(border.frame)+10,15 ,15);
    [View addSubview:link];
    [link addTarget:self action:@selector(DoccumentButtonClicked) forControlEvents:UIControlEventTouchUpInside];

    post=[[UIButton alloc]init];
    [post setBackgroundImage:[UIImage imageNamed:@"home_post.png"] forState:UIControlStateNormal];
    [post setTitle:@"Post" forState:UIControlStateNormal];
    [post addTarget:self action:@selector(PostServerCall) forControlEvents:UIControlEventTouchUpInside];
    post.frame=CGRectMake(CGRectGetMaxX(border.frame)-60, CGRectGetMinY(border.frame)+10,50 , 30);
    [View addSubview:post];
    [self.view addSubview:View];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardOnScreen:) name:UIKeyboardWillShowNotification object:nil];
   //postview
   
    PostedfileView=[[UIView alloc]initWithFrame:CGRectMake(0, _textview.frame.origin.y+_textview.frame.size.height+10,self.view.frame.size.width, 50)];
    PostedfileView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:PostedfileView];
    Postlabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, self.view.frame.size.width-60, 40)];
    Postlabel.numberOfLines = 2;
    Postlabel.text = documentName;
    Postlabel.textColor= [UIColor blackColor];
    Postlabel.font = [UIFont fontWithName:@"BOlD" size:15];
    
    [PostedfileView addSubview:Postlabel];
    UIButton * deleteButton=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(Postlabel .frame)+10,10, 30, 30)];
    [deleteButton setBackgroundImage:[UIImage imageNamed:@"icon_delete.png"] forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(deleteButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [PostedfileView addSubview:deleteButton];

     PostedfileView.hidden = YES;

    
//    [Postlabel sizeToFit];
    // Do any additional setup after loading the view.
}
-(void)PostFileMethod{
   
   [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)deleteButtonClicked{
    
    PostedfileView.hidden = YES;
    
}
-(void)CameraButtonClicked{
    
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
-(void)DoccumentButtonClicked{
    UIDocumentPickerViewController *documentPicker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:@[@"public.data"] inMode:UIDocumentPickerModeImport];
    documentPicker.delegate = self;
    
    documentPicker.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:documentPicker animated:YES completion:nil];}
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    
    if (controller.documentPickerMode == UIDocumentPickerModeImport) {
        NSString *path = [url path];
        if ([[path pathExtension] isEqualToString:@""]) {
            UIAlertController *alertController;
            alertController = [UIAlertController  alertControllerWithTitle:@"Error"  message:@"Please give the Extension"  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }else{
            NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
            postDocumentData = data;
            extensionType = [path pathExtension];
            [path lastPathComponent];
            documentName = [path lastPathComponent];
            base64string=[postDocumentData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
           if([extensionType isEqualToString:@"docx"]||[extensionType isEqualToString:@"pdf"])
           {
            PostedfileView.hidden = NO;
            Postlabel.text = documentName;
           }
            else
            {
                UIAlertController *alertController;
                alertController = [UIAlertController  alertControllerWithTitle:@"Warning"  message:@"Please select docx or pdf file only"  preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [alertController dismissViewControllerAnimated:YES completion:nil];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
                [self deleteButtonClicked];
            }
                
        }
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
     dispatch_async(dispatch_get_main_queue(), ^{
    cameraImage = info[UIImagePickerControllerEditedImage];
       NSURL *imageurl=info[UIImagePickerControllerReferenceURL];
         imageurl=info[UIImagePickerControllerReferenceURL];
         extensionType = [[imageurl pathExtension] lowercaseString];
          PostedfileView.hidden = NO;
         Postlabel.text=[NSString stringWithFormat:@"%@",imageurl];
         CFStringRef imageUTI = (UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,(__bridge CFStringRef)extensionType , NULL));
         NSLog(@"%@",imageUTI);
         if (UTTypeConformsTo(imageUTI, kUTTypeJPEG))
         {
             postDocumentData=UIImageJPEGRepresentation(cameraImage, 1.0);
             base64string=[postDocumentData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
         }
         else if (UTTypeConformsTo(imageUTI, kUTTypePNG))
         {
             postDocumentData=UIImagePNGRepresentation(cameraImage);
             base64string=[postDocumentData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
         }
         else
         {
             NSLog(@"Unhandled Image UTI: %@", imageUTI);
         }
         [picker dismissViewControllerAnimated:YES completion:NULL];

    });
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}



-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]){
         View.frame=CGRectMake(0, CGRectGetMaxY(self.view.frame)-50,CGRectGetMaxX(self.view.frame), 50);
    NSLog(@"%f",View.frame.origin.y);
    [View setFrame:View.frame];
   // [self frames];
        if ([_textview.text isEqualToString:@""]) {
            _textview.text = @"Share an artical,Photo or idea";
            self.textview.textColor = [UIColor lightGrayColor];
        }
        [textView resignFirstResponder];
    }
    return YES;
}
-(void)keyboardOnScreen:(NSNotification *)notification
{
    NSDictionary *info  = notification.userInfo;
    NSValue      *value = info[UIKeyboardFrameEndUserInfoKey];
    // CGRect frame        = textField.frame;
    CGRect rawFrame      = [value CGRectValue];
    CGRect keyboardFrame = [self.view convertRect:rawFrame fromView:nil];
    float h=keyboardFrame.origin.y;
    CGRect bframe=View.frame;
    bframe.origin.y=h-60;
    [View setFrame:bframe];
  //  [self frames];
    
    //    NSLog(@"keyboardFrame: %@", NSStringFromCGRect(keyboardFrame));
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([_textview.text isEqualToString:@"Share an artical,Photo or idea"]) {
  _textview.text = @"";
        
    _textview.textColor = [UIColor blackColor];
    
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView;{
    
    if (_textview.frame.size.height <= 80) {
         _textview.scrollEnabled = NO;
        rect = [_textview.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width-80, CGFLOAT_MAX)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:attributes
                                            context:nil];
        _textview.frame = CGRectMake(CGRectGetMaxX(self.imageview.frame), 80, rect.size.width, rect.size.height);
        
        [_textview setFrame:_textview.frame];
        
    }else{
        
        _textview.scrollEnabled = YES;
        
    
    }
    CGRect frame = PostedfileView.frame;
   frame.origin.y = _textview.frame.origin.y+_textview.frame.size.height+10;
    [PostedfileView setFrame:frame];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*Server_call*/
-(void)PostServerCall
{
    NSArray *objects;
    NSArray *keys;
    NSString *poststring;
    NSString *extension;
    NSString *userId=[[NSUserDefaults standardUserDefaults] valueForKey:@"user_id"];
    NSLog(@"%@",userId);
    if(extensionType)
    {
        if([extensionType isEqualToString:@"png"]||[extensionType isEqualToString:@"jpg"])
        {
            poststring=@"post_image";
            extension=@"image_extension";
        }
        else if([extensionType isEqualToString:@"docx"]||[extensionType isEqualToString:@"pdf"])
        {
            poststring=@"post_doc";
            extension=@"doc_extension";
            
        }
      
        objects = [NSArray arrayWithObjects:[[NSUserDefaults standardUserDefaults] valueForKey:@"user_id"] ,_textview.text,base64string,extensionType,nil];
    keys = [NSArray arrayWithObjects:@"user_id",@"post_text",poststring,extension,nil];
    }
    else
    {
        
        objects = [NSArray arrayWithObjects: [[NSUserDefaults standardUserDefaults] valueForKey:@"user_id"] ,_textview.text,nil];
        keys = [NSArray arrayWithObjects:@"user_id",@"post_text",nil];
    }
    NSDictionary *jsonDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:0 error:nil];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://facilitymanagementcouncil.com/admin/service/savepost"]];
    request.HTTPBody = jsonData;
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    NSURLSessionDataTask *dataTask =[self.urlSession dataTaskWithRequest:request];
    dic=nil;
    [dataTask resume];
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
    UIAlertController *alertController;
    alertController = [UIAlertController  alertControllerWithTitle:@""  message:[dic valueForKey:@"message"]  preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
