//
//  EditViewController.h
//  FMC
//
//  Created by Nennu on 24/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TOCropViewController.h"

@interface EditViewController : UIViewController<UIScrollViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,NSURLSessionDelegate,TOCropViewControllerDelegate>
{
    NSString * Message;
    float y,h;
    BOOL camerabool;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSURLSession *urlSession;
@end
