//
//  TableViewCell.m
//  home
//
//  Created by surendra reddy on 15/02/17.
//  Copyright © 2017 surendar. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // Fix the bug in iOS7 - initial constraints warning
  self.contentView.bounds = [UIScreen mainScreen].bounds;
}


// If you are not using auto layout, override this method, enable it by setting
// "fd_enforceFrameLayout" to YES.
//- (CGSize)sizeThatFits:(CGSize)size {
//    CGFloat totalHeight = 0;
//    totalHeight += [self.profileName_label sizeThatFits:size].height;
//    totalHeight += [self.content_label sizeThatFits:size].height;
//    totalHeight += [self.post_imageView sizeThatFits:size].height;
//    totalHeight += [self.comentCount_label sizeThatFits:size].height;
//    totalHeight += 80; // margins
//    return CGSizeMake(size.width, totalHeight);
//}
//

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
