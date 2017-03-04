//
//  MembersDircell.h
//  FMC
//
//  Created by Nennu on 26/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MembersModel.h"

@interface MembersDircell : UITableViewCell
@property (strong, nonatomic) UILabel *labelDescription;
@property (strong, nonatomic) UIImageView *cellImageView;
- (void) bindDataWithCell : (MembersModel *) membermodel :(NSIndexPath *) indexPath :(UITableView*) tableView;
@end
