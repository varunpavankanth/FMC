//
//  MembersDircell.m
//  FMC
//
//  Created by Nennu on 26/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import "MembersDircell.h"
#import "UIImageView+WebCache.h"

@implementation MembersDircell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    }
- (void) bindDataWithCell : (MembersModel *) membermodel :(NSIndexPath *) indexPath :(UITableView*) tableView
{
   static UIImage * placeHolder;
    
    placeHolder = [UIImage imageNamed:@"deafult_icon.png"];
    NSString *firstname=membermodel.first_name;
    NSString *Lastname=membermodel.last_name;
    NSString *companyname=membermodel.company_name;
    NSString *apd=[NSString stringWithFormat:@"%@ %@\n%@",[self stringWithSentenceCapitalization:firstname],[self stringWithSentenceCapitalization:Lastname],[self stringWithSentenceCapitalization:companyname]];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:apd attributes:nil];
    self.cellImageView=[[UIImageView alloc]initWithFrame:CGRectMake(5 ,8, 60,60)];
    self.cellImageView.layer.cornerRadius = 30.0f;
     self.cellImageView.clipsToBounds = YES;
  self.labelDescription=  [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_cellImageView.frame)+5,5, self.frame.size.width,  50)];
    self.labelDescription.attributedText = attributedText;
    self.labelDescription.numberOfLines=0;
   // [self.labelDescription sizeToFit];
   self.cellImageView.image = placeHolder;
    NSString *imageUrl = membermodel.profile_pic;
    [self.cellImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:placeHolder];
    [self.contentView addSubview:self.labelDescription];
    [self.contentView  addSubview:self.cellImageView];
}
                   -(NSString*)stringWithSentenceCapitalization:(NSString*)str
    {
        
        // Get the first character in the string and capitalize it.
        NSString *firstCapChar = [[str substringToIndex:1] capitalizedString];
        
        NSMutableString * temp = [str mutableCopy];
        
        // Replace the first character with the capitalized version.
        [temp replaceCharactersInRange:NSMakeRange(0, 1) withString:firstCapChar];
        
        return temp ;
    }

@end
