//
//  CommentsCell.h
//  FMC
//
//  Created by Nennu on 22/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KILabel.h"
@interface CommentsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *ProfileName;

@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageview;
@property (weak, nonatomic) IBOutlet KILabel *contentlabel;
@property (weak, nonatomic) IBOutlet UIView *CommentView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *postHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *ShareView;
@property (strong, nonatomic) IBOutlet UIButton *sharebutton;
@property (strong, nonatomic) IBOutlet UILabel *Comment_lable;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraintTextViewHeight;
@property (strong, nonatomic) IBOutlet UITextView *txtComment;

@end
