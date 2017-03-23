//
//  TableViewCell.h
//  home
//
//  Created by surendra reddy on 15/02/17.
//  Copyright © 2017 surendar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KILabel.h"
@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profile_imageView;
@property (strong, nonatomic) IBOutlet UILabel *recentLike_label;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ImageHeightConstrait;
@property (strong, nonatomic) IBOutlet UILabel *linesuparator;

@property (weak, nonatomic) IBOutlet UILabel *profileName_label;
@property (weak, nonatomic) IBOutlet KILabel *content_label;
@property (strong, nonatomic) IBOutlet UIButton *sharebutton;
@property (strong, nonatomic) IBOutlet UITextView *content_textview;

@property (weak, nonatomic) IBOutlet UIImageView *post_imageView;
@property (weak, nonatomic) IBOutlet UILabel *comentCount_label;
@property (strong, nonatomic) IBOutlet UIButton *like;
@property (strong, nonatomic) IBOutlet UILabel *likebuttonlable;
@property (strong, nonatomic) IBOutlet UILabel *sharebuttonlable;

@property (strong, nonatomic) IBOutlet UIView *LikeView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraintTextViewHeight;

@end
