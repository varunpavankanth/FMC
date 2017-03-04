//
//  CommentsCell.m
//  FMC
//
//  Created by Nennu on 22/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import "CommentsCell.h"

@implementation CommentsCell
@synthesize profileImageview,ProfileName,contentlabel,postImageView,CommentView,ShareView;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
