//
//  PostsCell.h
//  FMC
//
//  Created by Nennu on 22/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *PostmageView;
@property (weak, nonatomic) IBOutlet UILabel *postNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *PostContentLabel;

@end
