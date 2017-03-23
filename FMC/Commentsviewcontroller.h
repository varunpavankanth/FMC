//
//  Commentsviewcontroller.h
//  FMC
//
//  Created by Nennu on 22/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Commentsviewcontroller : UIViewController<UITextFieldDelegate,NSURLSessionDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    UIView   *View;
    UITextField *textfield;
    NSMutableDictionary *commentdic;
    NSError *error1;
    float y,h;
     UIScrollView *scrollView;
    UIImageView  *  ImageView ;
}
@property  NSURLSession *urlSession;
@property(nonatomic,strong)NSMutableDictionary *dic;
@property(nonatomic,strong)NSString *post_id;
@property (weak, nonatomic) IBOutlet UITableView *CommentTableview;


@end
