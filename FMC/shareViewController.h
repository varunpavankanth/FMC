//
//  shareViewController.h
//  FMC
//
//  Created by Nennu on 16/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TOCropViewController.h"
@interface shareViewController : UIViewController<UITextViewDelegate,UIAlertViewDelegate,NSURLSessionDelegate,TOCropViewControllerDelegate>
{
    CALayer *border;
    UIButton *cam;
    UIButton *link;
    UIButton *post;
    UIView   *View;
    CGRect oldframe;
    NSURL *imageurl;
    UIImageView *sharPicImageview;
     BOOL camerabool;
}
@property(nonatomic,strong)UIImageView *imageview;
@property(nonatomic,strong)UITextView *textview;
@property (nonatomic, strong) NSURLSession *urlSession;
@end
