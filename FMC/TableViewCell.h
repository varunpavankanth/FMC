//
//  TableViewCell.h
//  home
//
//  Created by surendra reddy on 15/02/17.
//  Copyright © 2017 surendar. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profile_imageView;
@property (strong, nonatomic) IBOutlet UILabel *recentLike_label;

@property (weak, nonatomic) IBOutlet UILabel *profileName_label;
@property (weak, nonatomic) IBOutlet UILabel *content_label;
@property (strong, nonatomic) IBOutlet UIButton *sharebutton;

@property (weak, nonatomic) IBOutlet UIImageView *post_imageView;
@property (weak, nonatomic) IBOutlet UILabel *comentCount_label;
@property (strong, nonatomic) IBOutlet UIButton *like;


@end
