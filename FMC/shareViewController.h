//
//  shareViewController.h
//  FMC
//
//  Created by Nennu on 16/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface shareViewController : UIViewController<UITextViewDelegate,UIAlertViewDelegate,NSURLSessionDelegate>
{
    CALayer *border;
    UIButton *cam;
    UIButton *link;
    UIButton *post;
    UIView   *View;
    CGRect oldframe;
  
}
@property(nonatomic,strong)UIImageView *imageview;
@property(nonatomic,strong)UITextView *textview;
@property (nonatomic, strong) NSURLSession *urlSession;
@end
